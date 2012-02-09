//
//  PrintingExampleAppDelegate.h
//  PrintingExample
//
//  Created by Craig Spitzkoff on 6/9/11.
//  Copyright 2011 Raizlabs Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrintingExampleViewController;

@interface PrintingExampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PrintingExampleViewController *viewController;

@end
