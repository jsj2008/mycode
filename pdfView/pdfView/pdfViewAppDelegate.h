//
//  pdfViewAppDelegate.h
//  pdfView
//
//  Created by Ayush Goel on 25/11/11.
//  Copyright 2011 goelay@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pdfViewViewController;

@interface pdfViewAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet pdfViewViewController *viewController;

@end
