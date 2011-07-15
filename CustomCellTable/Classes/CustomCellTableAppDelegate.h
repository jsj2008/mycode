//
//  CustomCellTableAppDelegate.h
//  CustomCellTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCellTableViewController;

@interface CustomCellTableAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CustomCellTableViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CustomCellTableViewController *viewController;

@end

