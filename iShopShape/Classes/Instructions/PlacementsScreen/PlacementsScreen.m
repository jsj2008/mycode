//
//  PlacementsScreen.m
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "PlacementsScreen.h"
#import <QuartzCore/QuartzCore.h>

@interface PlacementsScreen()
//-(void) showCalloutAt:(int)buttonId;
@end


@implementation PlacementsScreen

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instruction:(Instruction*)aInstruction{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		instruction = aInstruction;
		
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self setTitle:@"Placements"];
	
	buttonArray = [[NSMutableArray alloc] init];
	originalXCenterArray= [[NSMutableArray alloc] init];
	originalYCenterArray= [[NSMutableArray alloc] init];
	
    [super viewDidLoad];
	
	//Demo hack
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",instruction.instId]];
	
	if(image)
	{
		[image retain];
		//[instructionImageView setImage:resourceImage];
	}
	else 
	{
		NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
		
		image = [[UIImage alloc] initWithContentsOfFile:pngPath];
	}
	
	if(image.size.width > image.size.height)
	{
		maxZoomLevel = image.size.width / self.view.frame.size.width;
	}
	else 
	{
		maxZoomLevel = image.size.height / self.view.frame.size.height;
	}

	
	CGRect imageRect = CGRectMake( 0, 0, 320, image.size.height/maxZoomLevel);
	
	imageView = [[CustomPlacementImageView alloc] initWithFrame:imageRect];
	[imageView setDelegate:self];
	[imageView setImage:image];
	[imageView setUserInteractionEnabled:YES];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	[image release];
	
	CGRect imageViewHolderFrame = imageRect;
	
	imageViewHolderFrame.size.height += 100.0f;
	imageViewHolderFrame.size.width += 60.0f;
	
	[firstScrollView setContentSize:imageViewHolderFrame.size];
	[firstScrollView setBackgroundColor:[UIColor clearColor]];
	[firstScrollView setMaximumZoomScale:maxZoomLevel];
	[firstScrollView setMinimumZoomScale:1.0f];
	[firstScrollView setShowsHorizontalScrollIndicator:NO];
	[firstScrollView setShowsVerticalScrollIndicator:NO];
	imageViewHolder = [[UIView alloc] initWithFrame:imageViewHolderFrame];
	[imageViewHolder addSubview:imageView];
	
	[imageView setCenter:CGPointMake( imageViewHolderFrame.size.width / 2.0f, imageViewHolderFrame.size.height / 2.0f)];
	[firstScrollView addSubview:imageViewHolder];
	[firstScrollView setDelegate:self];
	
	int iLoop=0;
	//for(int iLoop =0 ; iLoop< [instruction.styleProductArray count]; iLoop++)
	for(Product *product in instruction.styleProductArray)
	{
		//Product *product = [instruction.styleProductArray objectAtIndex:iLoop];
		
		UIButton *someButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[someButton addTarget:self 
					   action:@selector(aMethod:)
			 forControlEvents:UIControlEventTouchDown];
		someButton.tag = iLoop;
		iLoop++;
		[(NSMutableArray *)buttonArray addObject:someButton];
		
		float width = 0.0f;
		if(product.hotspotNumber<10)
		{
			[someButton setBackgroundImage:[UIImage imageNamed:@"redcircle.png"] forState:UIControlStateNormal];
			[someButton setBackgroundImage:[UIImage imageNamed:@"redcircle_down.png"] forState:UIControlStateHighlighted];
			//someButton.frame = CGRectMake(product.xCoordinater,product.yCoordinater,29,29);
			width = 29.0f;
		}
		else {
			[someButton setBackgroundImage:[UIImage imageNamed:@"redcircle_Ex.png"] forState:UIControlStateNormal];
			[someButton setBackgroundImage:[UIImage imageNamed:@"redcircle_Ex_down.png"] forState:UIControlStateHighlighted];
			//someButton.frame = CGRectMake(product.xCoordinater,product.yCoordinater,29,29);
			width = 40.0f;
		}

		[someButton setTitle:[NSString stringWithFormat:@"%d", product.hotspotNumber] forState:UIControlStateNormal];
		[someButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
		[someButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
		[someButton.titleLabel setTextColor:[UIColor whiteColor]];
		someButton.frame = CGRectMake(product.xCoordinater,product.yCoordinater,width,29);
		[someButton setBackgroundColor:[UIColor clearColor]];
		
		CGPoint someViewCenter = [someButton center];
		someViewCenter.x = imageView.frame.origin.x + (product.xCoordinater/ maxZoomLevel);
		someViewCenter.y = imageView.frame.origin.y + ( product.yCoordinater/ maxZoomLevel);
		[someButton setCenter:someViewCenter];
		
		[(NSMutableArray*)originalXCenterArray addObject:[NSNumber numberWithFloat:someButton.center.x]];
		[(NSMutableArray*)originalYCenterArray addObject:[NSNumber numberWithFloat:someButton.center.y]];
		
		[firstScrollView addSubview:someButton];
	}
	
	[firstScrollView setCenter: CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
	
	CGRect visibleRect = CGRectZero;
	visibleRect.origin = CGPointMake( (imageViewHolderFrame.size.width / 2.0f) - (firstScrollView.frame.size.width / 2.0f), (imageViewHolderFrame.size.height / 2.0f) - (firstScrollView.frame.size.height / 2.0f));
	visibleRect.size = [firstScrollView frame].size;
	
	[firstScrollView scrollRectToVisible:visibleRect animated:NO];

	
}

- (void) createExpandView : (UIButton *)button
{
	int tag = button.tag;
	
	Product *product = [instruction.styleProductArray objectAtIndex:tag];
	
	expandView = [[ExpandView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
	[expandView setUserInteractionEnabled:NO];
	expandView.currentTag = tag;
	//[expandView setBackgroundColor:[UIColor yellowColor]];
	
	[expandView.layer setAnchorPoint:CGPointMake(0.5, 1.0f)];
	
	[expandView setCenter:[button center]];
	[expandView createCallout:product];
	expandViewOriginalCenter = CGPointMake(imageView.frame.origin.x + product.xCoordinater/ maxZoomLevel, imageView.frame.origin.y + product.yCoordinater/ maxZoomLevel);
	
	[firstScrollView addSubview:expandView];
	[expandView release];
}

- (IBAction) aMethod:(id)sender
{
	UIButton *button = (UIButton*) sender;
	if(expandView)
	{
		if(expandView.currentTag != button.tag)
		{
			[self releaseExpandView];
			[self createExpandView:button];
		}
		else {
			[self releaseExpandView];
		}
	}
	else {
		[self createExpandView:button];
	}
}

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

- (void) releaseExpandView
{
	if(expandView)
	{
		[expandView removeFromSuperview];
		expandView = nil;
	}
}

- (void)dealloc {
	NSLog(@"Placement Screen --------------------- Release");

	[imageView release];
	imageView = nil;
	
	[buttonArray release];
	buttonArray = nil;
	
	[originalXCenterArray release];
	[originalYCenterArray release];
	
    [super dealloc];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imageViewHolder;
}

- (void) scrollViewDidZoom:(UIScrollView *)inScrollView {
	
	
	CGFloat zoomLevel = [inScrollView zoomScale];
	
	int iLoop = 0;
	//for(int iLoop =0 ; iLoop< [instruction.styleProductArray count]; iLoop++)
	for(UIButton *button in buttonArray)
	{
		//UIButton *button = [buttonArray objectAtIndex:iLoop];
		
		CGPoint newButtonCenter = CGPointMake([[originalXCenterArray objectAtIndex:iLoop] floatValue] , [[originalYCenterArray objectAtIndex:iLoop] floatValue]);
		newButtonCenter.x *= zoomLevel;
		newButtonCenter.y *= zoomLevel;
		[button setCenter:newButtonCenter];
		iLoop++;
	}
	
	CGPoint newViewCenter = expandViewOriginalCenter;
	newViewCenter.x *= zoomLevel ;
	newViewCenter.y *= zoomLevel ;
	[expandView setCenter:newViewCenter];
}

#pragma mark CustomPlacementImageViewDelegate
- (void) touchDetected
{
	[self releaseExpandView];
	
}
@end
