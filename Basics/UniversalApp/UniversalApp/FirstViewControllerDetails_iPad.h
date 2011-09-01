//
//  FirstViewControllerDetails_iPad.h
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol substitudePopOverViewController <NSObject>

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem ;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem ;

@end

@interface FirstViewControllerDetails_iPad : UIViewController {
    
    UINavigationBar *navigationBar;
    UILabel *myTitle;
}
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;

@property (nonatomic, retain) IBOutlet UILabel *myTitle;

- (void) setTexts : (NSString *)text;
@end
