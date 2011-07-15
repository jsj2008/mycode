//
//  SMS_BubblesAppDelegate.h
//  SMS Bubbles
//
//  Created by Santosh B on 1/12/10.
//  Copyright Cybage 2010. All rights reserved.
//

@interface SMS_BubblesAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

