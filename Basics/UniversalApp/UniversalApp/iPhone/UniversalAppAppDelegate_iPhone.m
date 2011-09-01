//
//  UniversalAppAppDelegate_iPhone.m
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "UniversalAppAppDelegate_iPhone.h"
#import "FirstViewController_iPhone.h"

@implementation UniversalAppAppDelegate_iPhone

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"iPhone ");

    
    FirstViewController_iPhone *firstViewController_iPhone = [[FirstViewController_iPhone alloc] initWithNibName:@"FirstViewController_iPhone" bundle:[NSBundle mainBundle]];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:firstViewController_iPhone];
    
    [self.window addSubview:controller.view];
    [self.window makeKeyAndVisible];
    [firstViewController_iPhone release];
    return YES;
}

- (void)dealloc
{
	[super dealloc];
}

@end
