//
//  MuppetsIphoneAppDelegate.h
//  MuppetsIphone
//
//  Created by Manish on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;
@class UICustomNavigationController;
@class SplashScreenViewController;

@interface MuppetsIphoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    int choice;
    int tagCount;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, getter = isFirstRun) BOOL firstRun;

@property (nonatomic, retain) HomeViewController *viewController;
@property (nonatomic )  int choice;

@property (nonatomic, retain) SplashScreenViewController *splashScreenViewController;
@property (nonatomic, retain) UICustomNavigationController *navigationController;

- (void)loadHome;

@end

