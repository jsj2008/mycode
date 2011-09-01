//
//  BaseGridViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "BaseGridViewController.h"

#define kItemsPerPage 6
#define kColumns      3
#define kRows         2

@interface BaseGridViewController (private)

- (void)gridItemSelected:(id)data;
- (UIImage *)thumbnailForObject:(id)object;
- (UIView *)viewForIndex:(NSUInteger)index;

@end

@implementation BaseGridViewController
@synthesize scrollView;
@synthesize data;
@synthesize pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _rotations = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:2.52f], 
                      [NSNumber numberWithFloat:-1.62f], 
                      [NSNumber numberWithFloat:1.57f], 
                      [NSNumber numberWithFloat:-5.33f], 
                      
                      [NSNumber numberWithFloat:-2.78f], 
                      [NSNumber numberWithFloat:1.09f], 
                      [NSNumber numberWithFloat:2.61f], 
                      [NSNumber numberWithFloat:2.50f], 
                      
                      [NSNumber numberWithFloat:2.47f], 
                      [NSNumber numberWithFloat:0.00f], 
                      [NSNumber numberWithFloat:-4.06f], 
                      [NSNumber numberWithFloat:0.00f], 
                      nil];
    }
    return self;
}

- (void)dealloc
{
    [_rotations release];
    [scrollView release];
    [data release];
    [pageControl release];
    [super dealloc];
}

- (void)layoutGridElements{
    for (UIView *_subview in scrollView.subviews) {
        /*
        [_subview.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
         */
        [_subview removeFromSuperview];
    }
    
    [data enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        int _indexOnPage = idx % kItemsPerPage;
        if (_indexOnPage == 0) {
            UIView *_page = [[UIView alloc] initWithFrame:self.scrollView.bounds];
            [scrollView addSubview:_page];
        }
        UIView *_currentPage    = [scrollView.subviews lastObject];
        UIView *_tile           = [self viewForIndex:idx];
        _tile.transform         = CGAffineTransformMakeRotation(degreesToRadian([[_rotations objectAtIndex:_indexOnPage] floatValue]));
        [_currentPage addSubview:_tile];
        [_tile release];
    }];
    
    [scrollView relayoutChildrenHorizontallyWithMargin:0.0f];
    for (UIView *_subview in scrollView.subviews) {
        [_subview arrangeChildrenInGridWithRows:kRows andColumns:kColumns animated:NO];
    }
    
    [pageControl setNumberOfPages:[scrollView.subviews count]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutGridElements];
}

- (UIView *)viewForIndex:(NSUInteger)index{
    NSDictionary *_data = [data objectAtIndex:index];
    
    BaseGridElementView *_cell  = [BaseGridElementView new];
    _cell.delegate              = self;
    _cell.data                  = _data;
    _cell.image.image           = [self thumbnailForObject:_data];
    [_cell hideLabel];

    return _cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView{
    CGFloat pageWidth = aScrollView.frame.size.width;
    int page = floor((aScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [pageControl setCurrentPage:page];
}

- (UIImage *)thumbnailForObject:(id)object{
    return [[UIImage imageNamed:[object objectForKey:@"thumb"]] transparentBorderImage:4];
}

- (void)gridItemSingleTapped:(BaseGridElementView *)cell{
    [self gridItemSelected:cell.data];
}

- (void)gridItemSelected:(id)data{}

- (void)enumerateGridElementsUsingBlock:(void (^)(id obj, NSUInteger idx))block{
    int _index = 0;
    for (UIView *_gridContainer in scrollView.subviews) {
        for (UIView *_gridElement in _gridContainer.subviews) {
            block(_gridElement, _index ++);
        }
    }
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)gotoHome:(id)sender{
    [self.navigationController popViewControllerUsingTransition:kCATransitionFade];
}

@end
