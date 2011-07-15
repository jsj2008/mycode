//
//  PortraitGraphAppDelegate.m
//  PortraitGraph
//
//  Created by Seb Kade on 6/05/10.
//  Copyright SKADE Development 2010. All rights reserved.
//

#import "PortraitGraphAppDelegate.h"
#import "MainViewController.h"

@implementation PortraitGraphAppDelegate


@synthesize window, mainVC;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	mainVC = [[MainViewController alloc] initWithFrame:window.bounds];
		
	[window addSubview:mainVC.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
	[mainVC release];
    [window release];
    [super dealloc];
}


@end
