//
//  UIBaseViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MuppetAccount.h"
#import "MuppetNotifications.h"
#import "TKAlertCenter.h"

@interface UIBaseViewController : UIViewController {
    UIButton *facebookLoginButton;
    UIView *backStack;
}

@property (nonatomic, retain) IBOutlet UIButton *facebookLoginButton;
@property (nonatomic, retain) IBOutlet UIView *backStack;
@property (nonatomic, retain) IBOutlet UIView *backStackCharacter;
- (void)quickAlertViewWithTitle:(NSString *) title message:(NSString *)message button:(NSString *)button;
- (void)facebookAccountStatusChanged;

- (void)showHud;
- (void)showHudWithLabel:(NSString *)labelText;
- (void)hideHud;

@end
