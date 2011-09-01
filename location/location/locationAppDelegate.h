//
//  locationAppDelegate.h
//  location
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class locationViewController;

@interface locationAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet locationViewController *viewController;

@end
