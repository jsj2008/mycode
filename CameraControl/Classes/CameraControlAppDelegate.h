//
//  CameraControlAppDelegate.h
//  CameraControl
//
//  Created by basant on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraControlViewController;

@interface CameraControlAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CameraControlViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CameraControlViewController *viewController;

@end

