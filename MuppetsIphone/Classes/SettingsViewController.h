//
//  SettingsViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/19/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "TapkuLibrary.h"
#import "FacebookFriendsViewController.h"

enum {
    CellTypeFacebookConnect=0,
    CellTypeFacebookFriends,
    CellTypeFacebookNotifications,
    CellTypeDisneyNotifications
};

@interface SettingsViewController : UIBaseViewController <UITableViewDataSource, UITabBarControllerDelegate, FacebookFriendSelector> {
    UITableView *tableView;
    id delegate;
    
    TKLabelSwitchCell *facebookAlertsSwitchCell;
    TKLabelSwitchCell *disneyAlertsSwitchCell;
    TKLabelImageCell *facebookConnectCell;
    TKLabelImageCell *facebookFriendsCell;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) id delegate;
-(IBAction)closeSettingsView;
@end
