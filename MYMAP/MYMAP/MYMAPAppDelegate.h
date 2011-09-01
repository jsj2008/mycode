//
//  MYMAPAppDelegate.h
//  MYMAP
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYMAPViewController;

@interface MYMAPAppDelegate : NSObject <UIApplicationDelegate> {
  
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MYMAPViewController *viewController;

@end
