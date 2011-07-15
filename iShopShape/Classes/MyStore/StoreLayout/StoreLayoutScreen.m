//
//  StoreLayoutScreen.m
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "StoreLayoutScreen.h"


@implementation StoreLayoutScreen

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark  Frame calculations
#define PADDING  0

- (CGRect)frameForPagingScrollView {
    CGRect frame = [[UIScreen mainScreen] bounds];
 	frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
	
    CGRect pageFrame = pagingScrollViewFrame;
	
	
    pageFrame.size.width -= (2 * PADDING);
	
    pageFrame.origin.x = (pagingScrollViewFrame.size.width * index) + PADDING;
	
    return pageFrame;
}



- (void)configurePage:(StoreImageScrollView *)page forIndex:(NSUInteger)index
{
    page.index = index;
    page.frame = [self frameForPageAtIndex:index];
	[page displayImage:[UIImage imageNamed:@"storelayoutimage.png"]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{

	storeLayoutImageView = [[StoreImageScrollView alloc] init];

	[self configurePage:storeLayoutImageView forIndex:0];

	[scrollView addSubview:storeLayoutImageView];
	
	[storeLayoutImageView release];
		
	[self setTitle:@"Store layout"];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"StoreLayoutScreen----------------------Release");
	[storeLayoutImageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//	return storeLayoutImageView;
//}

@end
