//
//  HtmlViewerAppDelegate.h
//  HtmlViewer
//
//  Created by Ayush Goel on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HtmlViewerViewController;

@interface HtmlViewerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HtmlViewerViewController *viewController;

@end
