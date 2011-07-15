//
//  PortraitGraphAppDelegate.h
//  PortraitGraph
//
//  Created by Seb Kade on 6/05/10.
//  Copyright SKADE Development 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface PortraitGraphAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainViewController *mainVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainVC;

@end

