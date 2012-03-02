//
//  testViewController.m
//  test
//
//  Created by Ayush on 01/03/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "testViewController.h"

@implementation testViewController

@synthesize contentView = _contentView;
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;


- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) 
    {
        self.adBannerView = [[classAdBannerView alloc] initWithFrame:CGRectMake(0,0,320,40)];
        [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];            
        [_adBannerView setDelegate:self];
    }
}

- (void)fixupAdView {
  
    if (_adBannerView != nil) 
    {  
      [UIView beginAnimations:@"fixupViews" context:nil];
        if (_adBannerViewIsVisible) 
         {
             if(!added)
             {
                 added=YES;
              [self.view addSubview:_adBannerView];
             }
            customWebView.frame =CGRectMake(0,0,320,420);
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = 410;
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 40;
            contentViewFrame.size.height = self.view.frame.size.height - 40;
            _contentView.frame = contentViewFrame;
         } 
         else 
         {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = -40;
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 420;
            contentViewFrame.size.height = self.view.frame.size.height;
            _contentView.frame = contentViewFrame;            
         }
        [UIView commitAnimations];
    }   
}


- (void)viewDidLoad 
{
    added=NO;
    [self createAdBannerView];
    customWebView.delegate = self;
//    customWebView.frame =CGRectMake(0,-80,320,480);
    [customWebView setBackgroundColor:[UIColor blackColor]];
    [customWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]isDirectory:NO]]];
}

- (void) viewWillAppear:(BOOL)animated {
 
    [self fixupAdView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}

- (void)dealloc {

      self.contentView = nil;
    self.adBannerView = nil;
    [self.adBannerView release];
    [super dealloc];
}

#pragma mark Orientation support

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
      [self fixupAdView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
   return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_adBannerViewIsVisible) {                
        _adBannerViewIsVisible = YES;
         [self fixupAdView];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_adBannerViewIsVisible)
    {        
        _adBannerViewIsVisible = NO;
         [self fixupAdView];
    }
}


@end
