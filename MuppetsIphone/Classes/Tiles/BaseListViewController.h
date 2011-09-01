//
//  BaseListViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"

@interface BaseListViewController : UIBaseViewController {
    NSDictionary *data;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSDictionary *data;

- (IBAction)gotoHome:(id)sender;
- (IBAction)gotoGrid:(id)sender;
- (IBAction)addFlair:(id)sender;

@end
