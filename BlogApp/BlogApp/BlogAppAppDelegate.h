//
//  BlogAppAppDelegate.h
//  BlogApp
//
//  Created by Ayush Goel on 11/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlogAppViewController;

@interface BlogAppAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet BlogAppViewController *viewController;

@end
