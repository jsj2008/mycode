//
//  testAppDelegate.h
//  test
//
//  Created by Ayush on 28/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class testViewController;

@interface testAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    testViewController *viewController;
	id _splitViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet testViewController *viewController;
@property (nonatomic, retain) IBOutlet id splitViewController;

@end


