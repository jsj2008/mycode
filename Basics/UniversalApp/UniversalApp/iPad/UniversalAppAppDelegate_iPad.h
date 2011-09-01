//
//  UniversalAppAppDelegate_iPad.h
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalAppAppDelegate.h"

@interface UniversalAppAppDelegate_iPad : UniversalAppAppDelegate <UISplitViewControllerDelegate>{
    @private
    UISplitViewController *splitViewController;
     UIBarButtonItem *rootPopoverButtonItem;
}

@end
