//
//  moveImageAppDelegate.h
//  moveImage
//
//  Created by Ayush Goel on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class moveImageViewController;

@interface moveImageAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet moveImageViewController *viewController;

@end
