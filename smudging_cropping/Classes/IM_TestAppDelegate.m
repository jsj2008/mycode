//
//  IM_TestAppDelegate.m
//  IM_Test
//
//  Created by Ayush goel

//

#import "IM_TestAppDelegate.h"
#import "IM_TestViewController.h"

@implementation IM_TestAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
