//
//  graphTestAppDelegate.h
//  graphTest
//
//  Created by Yogesh Bhople on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@class graphTestViewController;

@interface graphTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    //FirstViewController *viewController;
	graphTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet graphTestViewController *viewController;

@end

