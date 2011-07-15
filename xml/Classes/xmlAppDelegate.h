//
//  xmlAppDelegate.h
//  xml
//
//  Created by Ayush on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class xmlViewController;

@interface xmlAppDelegate : NSObject <UIApplicationDelegate> {
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet xmlViewController *viewController;

@end

