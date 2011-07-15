//
//  test1AppDelegate.h
//  test1
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class test1ViewController;

@interface test1AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet test1ViewController *viewController;

@end
