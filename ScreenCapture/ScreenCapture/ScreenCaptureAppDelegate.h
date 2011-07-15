//
//  ScreenCaptureAppDelegate.h
//  ScreenCapture
//
//  Created by Ayush Goel on 04/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScreenCaptureViewController;

@interface ScreenCaptureAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ScreenCaptureViewController *viewController;

@end
