//
//  SplashScreenViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "SplashScreenMoviePlayer.h"
#import "MuppetsIphoneAppDelegate.h"

@implementation SplashScreenViewController

- (id) init {
    self = [super initWithNibName:@"SplashScreenView" bundle:nil];
    if(self){
    }
    return self;
}

- (void)loadVideo{
    MuppetsIphoneAppDelegate *_appDelegate = (MuppetsIphoneAppDelegate *)[UIApplication sharedApplication].delegate;
	//NSLog(@"first run %@",[_appDelegate isFirstRun]);
    NSString *_path                  = [[NSBundle mainBundle] pathForResource:([_appDelegate isFirstRun] ? @"Splash" : @"SplashSmall") ofType:@"mov"];
   // NSLog(@"first run %@ movie path %@",[_appDelegate isFirstRun],_path);
	videoPlayer                      = [[SplashScreenMoviePlayer alloc] initWithPath:_path];
    videoPlayer.delegate             = self;
    videoPlayer.view.frame           = self.view.bounds;
    [self.view addSubview:videoPlayer.view];
    [videoPlayer readyPlayer];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    [self loadVideo];
}

- (void)moviePlayBackDidFinish{
    [videoPlayer.view removeFromSuperview];
    
    MuppetsIphoneAppDelegate *_appDelegate = (MuppetsIphoneAppDelegate *)[UIApplication sharedApplication].delegate;
    [_appDelegate loadHome];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return kSupportedOrientations;
}

- (void) viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [videoPlayer release];
    [super dealloc];
}


@end
