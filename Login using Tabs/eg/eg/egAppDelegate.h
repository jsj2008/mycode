//
//  egAppDelegate.h
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface egAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
   UINavigationController *navigationController;


}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
