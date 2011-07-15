//
//  TrainingAppDelegate.h
//  Training
//
//  Created by Sujit Kumar on 11/30/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrainingViewController;

@interface TrainingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TrainingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TrainingViewController *viewController;

@end

