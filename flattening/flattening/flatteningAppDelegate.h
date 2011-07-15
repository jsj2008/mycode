//
//  flatteningAppDelegate.h
//  flattening
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class flatteningViewController;

@interface flatteningAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet flatteningViewController *viewController;

@end
