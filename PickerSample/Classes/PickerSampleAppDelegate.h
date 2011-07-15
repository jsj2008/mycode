//
//  PickerSampleAppDelegate.h
//  PickerSample
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerSampleViewController;

@interface PickerSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PickerSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PickerSampleViewController *viewController;

@end

