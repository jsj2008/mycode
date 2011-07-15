//
//  ScreenCaptureViewController.m
//  ScreenCapture
//
//  Created by Ayush Goel on 04/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScreenCaptureViewController.h"


@implementation ScreenCaptureViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    myview=[[ScreenCaptureView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    [self.view addSubview:myview];
    [myview release];
    [myview setBackgroundColor:[UIColor clearColor]];
    
    UIScrollView *new=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,320,480)];
    new.contentSize=CGSizeMake(1000,1000);
    [self.view addSubview:new];
    new.delegate=self;
    [new release];
    [super viewDidLoad];
}
- (void) scrollViewDidScroll: (UIScrollView*)scrollView 
{
    [myview setNeedsDisplay];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [myview stopRecording];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
