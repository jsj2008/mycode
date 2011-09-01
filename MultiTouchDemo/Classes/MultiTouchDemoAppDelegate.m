//
//  MultiTouchDemoAppDelegate.m
//  MultiTouchDemo
//
//  Created by Jason Beaver on 5/29/08.
//  Copyright Apple Inc. 2008. All rights reserved.
//

#import "MultiTouchDemoAppDelegate.h"
#import "MultiTouchDemoViewController.h"

@implementation MultiTouchDemoAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}

- (void)dealloc
{
    [viewController release];
	[window release];
	[super dealloc];
}

@end
