//
//  try2AppDelegate.h
//  try2
//
//  Created by Ayush Goel on 01/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class try2ViewController;

@interface try2AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet try2ViewController *viewController;

@end
