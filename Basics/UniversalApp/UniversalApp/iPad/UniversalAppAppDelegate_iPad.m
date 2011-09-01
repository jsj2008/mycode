//
//  UniversalAppAppDelegate_iPad.m
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "UniversalAppAppDelegate_iPad.h"
#import "FirstViewController_iPad.h"
#import "FirstViewControllerDetails_iPad.h"

@implementation UniversalAppAppDelegate_iPad

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"iPad ");
   splitViewController = [[UISplitViewController alloc] init];
    
    FirstViewController_iPad *firstViewController_iPad = [[FirstViewController_iPad alloc] initWithNibName:@"FirstViewController_iPad" bundle:[NSBundle mainBundle]];
    
    FirstViewControllerDetails_iPad *firstViewControllerDetails_iPad = [[FirstViewControllerDetails_iPad alloc] initWithNibName:@"FirstViewControllerDetails_iPad" bundle:[NSBundle mainBundle]];
    
    splitViewController.viewControllers = [NSArray arrayWithObjects:firstViewController_iPad,firstViewControllerDetails_iPad,nil];
    
    [splitViewController setDelegate:self];
    [firstViewController_iPad release];
    
    [firstViewControllerDetails_iPad release];
    
    [self.window addSubview:splitViewController.view];
    [self.window makeKeyAndVisible];
   //[splitViewController autorelease];
    
    return YES;
}

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    UIViewController *controller = [splitViewController.viewControllers objectAtIndex:1];
    
    NSLog(@"splitViewController %f",controller.view.frame.size.width);
//    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    barButtonItem.title = @"Root View Controller";
    //self.popoverController = pc;
    rootPopoverButtonItem = barButtonItem;
    FirstViewController_iPad <substitudePopOverViewController>*detailViewController = [splitViewController.viewControllers objectAtIndex:1];
   
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    UIViewController *controller = [splitViewController.viewControllers objectAtIndex:1];
    
    NSLog(@"splitViewController --1 %f",controller.view.frame.size.width
);
//    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    FirstViewController_iPad  <substitudePopOverViewController>*detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
//    self.popoverController = nil;
    rootPopoverButtonItem = nil;
}


- (void)dealloc
{
    [splitViewController release];
	[super dealloc];
}

@end
