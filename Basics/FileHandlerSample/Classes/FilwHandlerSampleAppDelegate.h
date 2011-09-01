//
//  FilwHandlerSampleAppDelegate.h
//  FilwHandlerSample
//
//  Created by Santosh on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilwHandlerSampleViewController;

@interface FilwHandlerSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FilwHandlerSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FilwHandlerSampleViewController *viewController;

@end

