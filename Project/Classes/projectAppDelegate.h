//
//  projectAppDelegate.h
//  project
//
//  Created by Ayush Goel on 11/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginview.h"

@interface projectAppDelegate : NSObject <UIApplicationDelegate> {
    
   UIWindow *window;
    UINavigationController *navigationController;
	loginview *l1;
	IBOutlet int idno;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic) IBOutlet int idno;
@end

