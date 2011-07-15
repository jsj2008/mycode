//
//  SimpleTableAppDelegate.h
//  SimpleTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleTableViewController;

@interface SimpleTableAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SimpleTableViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SimpleTableViewController *viewController;

@end

