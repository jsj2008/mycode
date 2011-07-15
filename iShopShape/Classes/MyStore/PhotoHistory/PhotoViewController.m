#import "PhotoViewController.h"
#import "ImageScrollView.h"
#import "StoreImageObj.h"

@implementation PhotoViewController

#pragma mark -
#pragma mark View loading and unloading

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageArray : (NSArray*)imageLibrary index :(int)aIndex{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		__imageData = [[NSMutableArray alloc] initWithArray:imageLibrary];
		NSLog(@"%@", __imageData);
		currentImageIndex = aIndex;
	}
	
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	[__imageData release];
    [pagingScrollView release];
    pagingScrollView = nil;
    [recycledPages release];
    recycledPages = nil;
    [visiblePages release];
    visiblePages = nil;
}

- (void)dealloc
{
    [pagingScrollView release];
    [super dealloc];
}


//
- (UIImage *)imageAtIndex:(NSUInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"Actual_%@",[self imageNameAtIndex:index]];

	UIImage *img = [UIImage imageNamed:imageName];

	if(!img)
	{
		NSString *newimageName = [NSString stringWithFormat:@"%@",[self imageNameAtIndex:index]];
		NSString *newPath = [NSString stringWithFormat:@"Documents/%@",newimageName];
		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
		

		return [UIImage imageWithContentsOfFile:pngPath];
	}
	
    return img;    
}

- (NSString *)imageNameAtIndex:(NSUInteger)index {
    NSString *name = nil;
    if (index < [__imageData count]) {
        StoreImageObj *imageObj = [__imageData objectAtIndex:index];
        name = imageObj.imageName;
    }
    return name;
}
//

-(NSDate *)stringToDate:(NSString *)stringDate{
	
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];		
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;
	
}


- (void)loadView 
{
    self.wantsFullScreenLayout = YES;
	
    // Configure the scrollView
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
    pagingScrollView.pagingEnabled = YES;
    pagingScrollView.backgroundColor = [UIColor blackColor];
    pagingScrollView.showsVerticalScrollIndicator = NO;
    pagingScrollView.showsHorizontalScrollIndicator = NO;
    pagingScrollView.contentSize = CGSizeMake(pagingScrollViewFrame.size.width * [__imageData count],
                                              pagingScrollViewFrame.size.height);
	
    pagingScrollView.delegate = self;
    self.view = pagingScrollView;
	
    // TODO ? Prepare to tile content
    recycledPages = [[NSMutableSet alloc] init];
    visiblePages  = [[NSMutableSet alloc] init];
    [self processPages];
	
	
}

- (void)viewDidLoad {
	
	[self setTitle:[NSString stringWithFormat:@"%d of %d", currentImageIndex + 1, [__imageData count]]];
    [super viewDidLoad];
	
    CGFloat topOffset = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    pagingScrollView.contentInset = UIEdgeInsetsMake(-topOffset, 0.0, 0.0, 0.0);

	[pagingScrollView setContentOffset:CGPointMake(currentImageIndex * 320, 0)];
	
}


- (void)processPages {
	
    // Calculate which pages are visible
    CGRect visibleBounds = pagingScrollView.bounds;
	
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [__imageData count] - 1);
	
    if (lastNeededPageIndex >= 0) {
		
        // Recycle no-longer-visible pages 
        for (ImageScrollView *page in visiblePages) {
            if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
                [recycledPages addObject:page];
                [page removeFromSuperview];
            }
        }
        [visiblePages minusSet:recycledPages];
		
        // add missing pages
        for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {
            if (![self isDisplayingPageForIndex:index]) {
                ImageScrollView *page = [self dequeueRecycledPage];
                if (page == nil) {
                    page = [[[ImageScrollView alloc] init] autorelease];
                }
                [self configurePage:page forIndex:index];
                [pagingScrollView addSubview:page];
                [visiblePages addObject:page];
            }
        }
    }
}

- (ImageScrollView *)dequeueRecycledPage {
    ImageScrollView *page = [recycledPages anyObject];
    if (page) {
        [[page retain] autorelease];
        [recycledPages removeObject:page];
    }
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index {
    BOOL foundPage = NO;
    for (ImageScrollView *page in visiblePages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index {
    page.index = index;
    page.frame = [self frameForPageAtIndex:index];
	
    [page displayImage:[self imageAtIndex:index]];
}


#pragma mark -
#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	int index = scrollView.contentOffset.x / 320;
	index = index+1;
	[self setTitle:[NSString stringWithFormat:@"%d of %d", index, [__imageData count]]];
	
    [self processPages];
}


#pragma mark -
#pragma mark  Frame calculations
#define PADDING  0

- (CGRect)frameForPagingScrollView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2*PADDING);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
	
    CGRect pageFrame = pagingScrollViewFrame;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (pagingScrollViewFrame.size.width * index) + PADDING;
    
    return pageFrame;
}



@end
