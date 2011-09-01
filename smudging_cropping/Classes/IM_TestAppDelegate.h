//
//  IM_TestAppDelegate.h
//  IM_Test
//
//  Created by Ayush goel
//

#import <UIKit/UIKit.h>

@class IM_TestViewController;

@interface IM_TestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IM_TestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IM_TestViewController *viewController;

@end

