//
//  SettingsViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/19/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "SettingsViewController.h"
#import "FacebookFriendsViewController.h"

@implementation SettingsViewController
@synthesize tableView;
@synthesize delegate;

- (id)init{
    self = [super initWithNibName:@"SettingsView" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [delegate release];
    [tableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)facebookAccountStatusChanged{
    [super facebookAccountStatusChanged];
    
    if ([MuppetAccount shared].status == AccountStatusMuppetLoggedIn) {
        NSArray *_indexPaths = [NSArray arrayWithObjects: 
                               [NSIndexPath indexPathForRow:CellTypeFacebookFriends inSection:0],
                               [NSIndexPath indexPathForRow:CellTypeFacebookNotifications inSection:0],
                               nil];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:_indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover        = self.view.frame.size;
    
    facebookConnectCell                     = [[TKLabelImageCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"imageCell"];
    facebookConnectCell.label.text          = @"Facebook Connect";
    facebookConnectCell.label.font          = [UIFont boldSystemFontOfSize:10.0f];
    facebookConnectCell.cellImageView.image = [UIImage imageNamed:@"chevron.png"];
    facebookConnectCell.selectionStyle      = UITableViewCellSelectionStyleNone;
    
    facebookFriendsCell                     = [[TKLabelImageCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"imageCell"];
    facebookFriendsCell.label.text          = @"Facebook Friends";
    facebookFriendsCell.label.font          = [UIFont boldSystemFontOfSize:10.0f];
    facebookFriendsCell.cellImageView.image = [UIImage imageNamed:@"chevron.png"];
    facebookFriendsCell.selectionStyle      = UITableViewCellSelectionStyleNone;
    
    facebookAlertsSwitchCell                = [[TKLabelSwitchCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"switchCell"];
    facebookAlertsSwitchCell.label.text     = @"Facebook Alerts";
    facebookAlertsSwitchCell.label.font		= [UIFont boldSystemFontOfSize:10.0f];
    facebookAlertsSwitchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    facebookAlertsSwitchCell.switcher.on    = [[MuppetNotifications shared] facebookNotificationsEnabled];
    
    disneyAlertsSwitchCell                  = [[TKLabelSwitchCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"switchCell"];
    disneyAlertsSwitchCell.label.text       = @"Disney Alerts";
    disneyAlertsSwitchCell.label.font		= [UIFont boldSystemFontOfSize:10.0f];
    disneyAlertsSwitchCell.selectionStyle   = UITableViewCellSelectionStyleNone;
    disneyAlertsSwitchCell.switcher.on      = [[MuppetNotifications shared] disneyNotificationsEnabled];
    
    [facebookAlertsSwitchCell.switcher addTarget: self
                                          action: @selector(facebookAlertsToggled:) 
                                forControlEvents: UIControlEventValueChanged];

    [disneyAlertsSwitchCell.switcher addTarget: self
                                        action: @selector(disneyAlertsToggled:) 
                              forControlEvents: UIControlEventValueChanged];

}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [delegate popoverControllerDidDismissPopover:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([MuppetAccount shared].status == AccountStatusMuppetLoggedIn)
        return 4;
    else 
        return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([MuppetAccount shared].status == AccountStatusMuppetLoggedIn){
        switch (indexPath.row) {
            case CellTypeFacebookConnect:
                return facebookConnectCell;
            case CellTypeFacebookFriends:
                return facebookFriendsCell;
            case CellTypeFacebookNotifications:
                return facebookAlertsSwitchCell;
            default:
                return disneyAlertsSwitchCell;
        }
    } else {
        switch (indexPath.row) {
            case CellTypeFacebookConnect:
                return facebookConnectCell;
            default:
                return disneyAlertsSwitchCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == CellTypeFacebookFriends) {
		NSLog(@"didSelectRowAtIndexPath FacebookFriendsViewController");
        FacebookFriendsViewController *_facebookFriends = [FacebookFriendsViewController new];
        _facebookFriends.modalTransitionStyle           = UIModalTransitionStyleFlipHorizontal;
        [delegate presentModalViewController:_facebookFriends animated:YES];
        [_facebookFriends release];
    } else if (indexPath.row == CellTypeFacebookConnect) {
        if ([MuppetAccount shared].status != AccountStatusMuppetLoggedIn){
            [[MuppetAccount shared] login];
        }
    }
}

#pragma mark events

- (void)facebookFriendsSelected{
}

- (void)facebookAlertsToggled:(UISwitch *)sender{
    [[MuppetNotifications shared] setFacebookNotificationsEnabled:sender.on];
}

- (void)disneyAlertsToggled:(UISwitch *)sender{
    [[MuppetNotifications shared] setDisneyNotificationsEnabled:sender.on];
}

-(IBAction)closeSettingsView
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
