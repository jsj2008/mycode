//
//  GridViewAppDelegate.h
//  GridView
//
//  Created by Cyabge.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridViewViewController;

@interface GridViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GridViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GridViewViewController *viewController;

@end

