//
//  SelImageAppDelegate.h
//  SelImage
//
//  Created by ayush on 25/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelImageViewController;

@interface SelImageAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SelImageViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SelImageViewController *viewController;

@end

