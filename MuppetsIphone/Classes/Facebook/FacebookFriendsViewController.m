//
//  FacebookFriendsViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/18/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "FacebookFriendsViewController.h"

#define kColumns      7
#define kRows         3

@interface FacebookFriendsViewController (private)

- (UIView *)viewForIndex:(NSUInteger)index;
- (NSArray *)friendsForAlphabet:(NSString *)anAlphabet;
- (void)showFriendsForAlphabet:(NSString *)anAlphabet;
- (void)layoutGridElements;

@end

@implementation FacebookFriendsViewController
@synthesize alphabetScrubber;

@synthesize data;
@synthesize originalData;
@synthesize scrollView;
@synthesize pageControl;
@synthesize selectionDetailsLabel;
@synthesize backgroundImage;
@synthesize delegate;
@synthesize selectedFriends;

- (id)init
{
    self = [super initWithNibName:@"FacebookFriendsView" bundle:nil];
    if (self) {
        selectedFriends = [[[MuppetNotifications shared] notificationIgnoredFacebookFriends] mutableCopy];
        _currentAlphabetIndex = -1;
    }
    return self;
}

- (void)dealloc
{
    [data release];
    [originalData release];
    [delegate release];
    [scrollView release];
    [backgroundImage release];
    [pageControl release];
    [selectionDetailsLabel release];
    [alphabetScrubber release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrubberTapped:)];
    [singleTapRecognizer setDelegate:self];
    [singleTapRecognizer setNumberOfTapsRequired:1];
    [alphabetScrubber addGestureRecognizer:singleTapRecognizer];
    [singleTapRecognizer release];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrubberPanned:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [alphabetScrubber addGestureRecognizer:panRecognizer];
    [panRecognizer release];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showHudWithLabel:@"Fetching Facebook Friends"];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setBackgroundImage:nil];
    [self setPageControl:nil];
    [self setSelectionDetailsLabel:nil];
    [self setAlphabetScrubber:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)layoutGridElements{
    for (UIView *_subview in scrollView.subviews) {
        [_subview removeFromSuperview];
    }

    [data enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        int _indexOnPage = idx % (kRows*kColumns);
        if (_indexOnPage == 0) {
            UIView *_page = [[UIView alloc] initWithFrame:self.scrollView.bounds];
            [scrollView addSubview:_page];
            [_page release];
        }
        UIView *_currentPage  = [scrollView.subviews lastObject];
        
        UIView *_tile = [self viewForIndex:idx];
        [_currentPage addSubview:_tile];
        [_tile release];
    }];
    
    [scrollView relayoutChildrenHorizontallyWithMargin:0.0f];
    for (UIView *_subview in scrollView.subviews) {
        [_subview arrangeChildrenInGridWithRows:kRows andColumns:kColumns animated:NO];
    }
    
    if ([scrollView.subviews count] > 0) {
        UIView *_firstGrid = [scrollView.subviews objectAtIndex:0];
        _firstGrid.alpha = 0.0f;
        _firstGrid.transform = CGAffineTransformMakeTranslation(30.0f, 0.0f);
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState 
						 animations:^{
							 _firstGrid.alpha = 1.0f;
                             _firstGrid.transform = CGAffineTransformIdentity;
						 } 
						 completion:nil];
    }
    
    [pageControl setNumberOfPages:[scrollView.subviews count]];
    
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:0.5f];
    [self update];
}

- (void)facebookAccountStatusChanged{
    [super facebookAccountStatusChanged];

    if ([MuppetAccount shared].status == AccountStatusMuppetLoggedIn) {
        [[MuppetAccount shared] fetchFriendsWithResponseBlock:^(NSArray *friends) {
            originalData    = [friends copy];
            data            = [friends copy];
            [friends release];
            [self layoutGridElements];
        } andErrorBlock:^(NSError *error) {
            
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView{
    CGFloat pageWidth = aScrollView.frame.size.width;
    int page = floor((aScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [pageControl setCurrentPage:page];
}

- (UIView *)viewForIndex:(NSUInteger)index{
    NSDictionary *_data = [data objectAtIndex:index];

    FacebookFriendCell *_cell = [FacebookFriendCell new];
    [_cell setData:_data];
    _cell.delegate = self;

    if ([selectedFriends indexOfObject:[_data objectForKey:@"id"]] != NSNotFound) {
        _cell.selected = YES;
    }

    return _cell;
}

- (void)enumerateGridElementsUsingBlock:(void (^)(id obj, NSUInteger idx))block{
    int _index = 0;
    for (UIView *_gridContainer in scrollView.subviews) {
        for (UIView *_gridElement in _gridContainer.subviews) {
            block(_gridElement, _index ++);
        }
    }
}

- (IBAction)doneClicked:(id)sender {
    [[MuppetNotifications shared] setNotificationIgnoredFacebookFriends:selectedFriends];
    [delegate facebookFriendsSelected];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelClicked:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)update{
    int _selectionCount = [originalData count] - [selectedFriends count];
    selectionDetailsLabel.text = [NSString stringWithFormat:@"Get Alerts for %d Facebook %@", _selectionCount, _selectionCount == 1 ? @"Friend" : @"Friends"];
}

- (void)friendCellSelectionUpdated:(FacebookFriendCell *)cell{
    [self update];
    
    NSUInteger _index = [selectedFriends indexOfObject:cell.identifier];
    if (_index != NSNotFound) {
        [selectedFriends removeObjectAtIndex:_index];
    }
    
    if (cell.selected) {
        [selectedFriends addObject:cell.identifier];
    }
}

#pragma mark filtering

- (void)selectAlphabetAtPoint:(CGPoint)_point{
    int _index = (int)_point.x/alphabetScrubber.frame.size.width*26;
    
    if (_index == _currentAlphabetIndex) {
        return;
    }
    
    NSArray *searchArray    = [NSArray arrayWithObjects:
                               @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", 
                               @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    [self showFriendsForAlphabet:[searchArray objectAtIndex:_index]];
    
    _currentAlphabetIndex = _index;
}

- (NSArray *)friendsForAlphabet:(NSString *)anAlphabet{
    NSPredicate *_predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(name beginswith[c] '%@')", anAlphabet]];
    NSArray *_filtered      = [originalData filteredArrayUsingPredicate:_predicate];
    return [_filtered copy];
}

- (void)showFriendsForAlphabet:(NSString *)anAlphabet{
    [data release]; data=nil;
    data = [self friendsForAlphabet:anAlphabet];
    [self layoutGridElements];
}

- (IBAction)selectEverybody:(id)sender {
    [self enumerateGridElementsUsingBlock:^(id obj, NSUInteger idx) {
        [obj setSelected:NO]; 
    }];

    [self update];
}

- (IBAction)selectNobody:(id)sender {
    [self enumerateGridElementsUsingBlock:^(id obj, NSUInteger idx) {
        [obj setSelected:YES]; 
    }];

    [self update];
}

#pragma mark filter events

- (IBAction)showAllButtonClicked:(id)sender {
    [data release]; data=nil;
    data = [originalData copy];
    [self layoutGridElements];
    _currentAlphabetIndex = -1;
}

- (void)scrubberTapped:(UITapGestureRecognizer *)gesture{
    CGPoint _point  = [gesture locationInView:alphabetScrubber];
    [self selectAlphabetAtPoint:_point];
}

-(void)scrubberPanned:(UIPanGestureRecognizer *)gesture{
    if([(UIPanGestureRecognizer*)gesture state] == UIGestureRecognizerStateChanged) {
        CGPoint _point  = [gesture locationInView:alphabetScrubber];
        [self selectAlphabetAtPoint:_point];
    }
}

@end
