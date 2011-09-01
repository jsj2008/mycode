//
//  MuppetsIphoneAppDelegate.m
//  MuppetsIphone
//
//  Created by Manish on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MuppetsIphoneAppDelegate.h"
#import "HomeViewController.h"
#import "SplashScreenViewController.h"
#import "MuppetAccount.h"

#import "Project.h"
#import "Muppet.h"
#import "DataLoader.h"
@implementation MuppetsIphoneAppDelegate

@synthesize window=_window;

@synthesize firstRun;
@synthesize choice;
@synthesize viewController=_viewController;
@synthesize splashScreenViewController=_splashScreenViewController;
@synthesize navigationController;


- (void) firstRun {
	NSLog(@"firstRun");
    NSUserDefaults *prefs   = [NSUserDefaults standardUserDefaults];
    firstRun                = [prefs objectForKey:@"firstRun"] == nil;
	
    if (firstRun) {
        //perform first run activites
        [Project makeDummyProject];
        [Muppet createDummyMuppet];
    }
}

- (void)loadSplashScreen{
	NSLog(@"loadSplashScreen");
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
    _splashScreenViewController     = [SplashScreenViewController new];
    self.window.rootViewController  = _splashScreenViewController;
    [_splashScreenViewController release];
    [self.window makeKeyAndVisible];
	NSLog(@"loadSplashScreen");
}

- (void)loadHome{
	NSLog(@"loadHome");
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
	
    if (_splashScreenViewController) {
        [_splashScreenViewController release];_splashScreenViewController=nil;
        
        CATransition *transition	= [CATransition animation];
        transition.duration			= 2.0f;
        transition.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type				= kCATransitionFade;
        [[self.window layer] addAnimation:transition forKey:nil];
    }
	
    self.viewController         = [HomeViewController new];
    self.navigationController   = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [self.viewController release];
    [self.navigationController setNavigationBarHidden:YES];
    self.window.rootViewController = (UIViewController *)self.navigationController;
    [self.navigationController release];
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSLog(@"didFinishLaunchingWithOptions");
    choice=-1;
    [self firstRun];
    
    if (animationsDisabled()) {
        [self loadHome];
    } else {
        [self loadSplashScreen];
    }
    
    // load facebook class
    [MuppetAccount shared];
    
    // load occasions and characters
    [DataLoader shared];
    
    // get notifications
  //  [MuppetNotifications shared];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[[MuppetAccount shared] facebook] handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	NSLog(@"applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	NSLog(@"applicationDidEnterBackground");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"done" forKey:@"firstRun"];
    [prefs synchronize];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{NSLog(@"applicationWillEnterForeground");
	
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{NSLog(@"applicationDidBecomeActive");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

-(void)applicationWillTerminate:(UIApplication *)application
{
	
	NSLog(@"applicationWillTerminate");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"firstRun"];
    [prefs synchronize];
    [_window release];
    [_viewController release];
    [_splashScreenViewController release];
    [navigationController release];
	
	
}
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [_splashScreenViewController release];
    [navigationController release];
    [super dealloc];
}

@end