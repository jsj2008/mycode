//
//  UIBaseViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "UIBaseViewController.h"
#import "MBProgressHUD.h"
#import "MuppetsIphoneAppDelegate.h"

@interface UIBaseViewController (private)

- (void)facebookAccountStatusChanged;

@end

@implementation UIBaseViewController

@synthesize facebookLoginButton;
@synthesize backStack;
@synthesize backStackCharacter;

- (void)themeBackStack
{

    CGRect _frame;
    MuppetsIphoneAppDelegate *del=[UIApplication sharedApplication].delegate;
 
    if(del.choice==1)
    {
        backStack.hidden=YES;
         _frame=backStackCharacter.frame;
        _frame.origin.x = 5.0f;
        _frame.origin.y = 5.0f;
        backStackCharacter.frame = _frame;
        
        [backStackCharacter setBackgroundColor:[UIColor clearColor]];
        float _x=0;
        for (UIButton *_backButton in backStackCharacter.subviews) 
        {
            [_backButton.titleLabel sizeToFit];
            _frame              = _backButton.frame;
            _frame.origin.x     = _x;
            _frame.origin.y     = 0.0f;
            _frame.size.width   = _backButton.titleLabel.frame.size.width + 40.0f;
            _frame.size.height   =  35.0f;
            _backButton.frame   = _frame;
            _x                 += _frame.size.width - 20.0f;
            [_backButton applyBackButtonTheme];
        }
      [self.view addSubview:backStackCharacter];
        del.choice=0;
    }
    else
    {
          _frame   = backStack.frame;
        _frame.origin.x = 5.0f;
        _frame.origin.y = 5.0f;
        backStack.frame = _frame;
        
        [backStack setBackgroundColor:[UIColor clearColor]];
        float _x=0;
        for (UIButton *_backButton in backStack.subviews) 
        {
            [_backButton.titleLabel sizeToFit];
            _frame              = _backButton.frame;
            _frame.origin.x     = _x;
            _frame.origin.y     = 0.0f;
            _frame.size.width   = _backButton.titleLabel.frame.size.width + 40.0f;
            _frame.size.height   =  35.0f;
            _backButton.frame   = _frame;
            _x                 += _frame.size.width - 20.0f;
            [_backButton applyBackButtonTheme];
        }
       [self.view addSubview:backStack];
    }
  
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self facebookAccountStatusChanged];    
    
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(facebookAccountStatusChanged) 
                                                 name: AccountLoginStatusChanged 
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(disneyNotificationReceived:) 
                                                 name: DisneyNotificationsReceived 
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(facebookNotificationReceived:) 
                                                 name: FacebookNotificationsReceived 
                                               object: nil];
    
   
    [self themeBackStack];
    
  
}

- (void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)facebookAccountStatusChanged{
    switch ([MuppetAccount shared].status) {
        case AccountStatusLoggedOut:
        case AccountStatusFacebookLoginFailed:
        case AccountStatusMuppetLoginFailed:
            facebookLoginButton.hidden  = NO;
            facebookLoginButton.enabled = YES;        
            break;
        case AccountStatusMuppetLoggedIn:
            facebookLoginButton.hidden = YES;
            break;
        case AccountStatusVerifyingFacebookCredentials:
        case AccountStatusVerifyingMuppetCredentials:
        case AccountStatusFacebookLoginDialogShown:
        case AccountStatusFacebookLoggedIn:
            facebookLoginButton.hidden  = NO;        
            facebookLoginButton.enabled = NO;
            break;
    }
}

- (void)disneyNotificationReceived:(NSNotification *)notification{
}

- (void)facebookNotificationReceived:(NSNotification *)notification{
}

-(void) quickAlertViewWithTitle:(NSString *) title message:(NSString *)message button:(NSString *)button {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:button otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)dealloc {
    [backStack release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return kSupportedOrientations;
}

- (void)showHud{
    UIView *_aview      = self.navigationController ? self.navigationController.view : self.view;
    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:_aview animated:YES];
    _hud.dimBackground  = YES;
}

- (void)showHudWithLabel:(NSString *)labelText{
    MuppetsIphoneAppDelegate *_appDelegate = (MuppetsIphoneAppDelegate *)[UIApplication sharedApplication].delegate;

    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:[_appDelegate window] animated:YES];
    _hud.dimBackground  = YES;
    _hud.labelText      = labelText;
}

- (void)hideHud{
    MuppetsIphoneAppDelegate *_appDelegate = (MuppetsIphoneAppDelegate *)[UIApplication sharedApplication].delegate;

    [MBProgressHUD hideHUDForView:[_appDelegate window] animated:YES];
}

@end
