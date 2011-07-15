//
//  TestHarmonyAppDelegate.h
//  TestHarmony
//
//  Created by Ayush Goel on 22/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestHarmonyViewController;

@interface TestHarmonyAppDelegate : NSObject <UIApplicationDelegate> {
    int click;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic ) int click;

@property (nonatomic, retain) IBOutlet TestHarmonyViewController *viewController;

@end
