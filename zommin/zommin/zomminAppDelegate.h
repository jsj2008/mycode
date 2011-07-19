//
//  zomminAppDelegate.h
//  zommin
//
//  Created by Ayush Goel on 18/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class zomminViewController;

@interface zomminAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet zomminViewController *viewController;

@end
