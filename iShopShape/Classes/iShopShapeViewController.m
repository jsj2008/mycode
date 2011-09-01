//
//  iShopShapeViewController.m
//  iShopShape
//
//  Created by Santosh B on 14/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "iShopShapeViewController.h"
#import "NotificationCustomCell.h"
#import "MyStoreCustomCell.h"
#import "InstructionsScreen.h"
#import "NotificationScreen.h"
#import "CalendarScreen.h"
#import "CommunityScreen.h"
#import "GuidesScreen.h"
#import "MyStoreScreen.h"
#import "EventHandler.h"
#import "InstructionHandler.h"
#import "NotificationHandler.h"
#import "GuideHandler.h"
#import "DatabaseHandler.h"
#import "SettingsScreen.h"

#import "Logger.h"

#define MAX_STARS 5
#define MIN_STARS 0

@implementation iShopShapeViewController
@synthesize homeMenuTable;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	//set title to the screen
	[self setTitle:@"Home"];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
	
	[homeMenuTable setBackgroundColor:[UIColor clearColor]];
	
	//Disable scrolling for the table
	[homeMenuTable setScrollEnabled:NO];

    [super viewDidLoad];
}

-(IBAction) settingsButtonAction :(id) sender
{
	SettingsScreen *settingsScreen = [[SettingsScreen alloc] initWithNibName:@"SettingsScreen" bundle:[NSBundle mainBundle]];
	
  	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsScreen];	
	
	[self presentModalViewController:navController animated:YES];
	
	[navController release];
	
	[settingsScreen release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void) viewWillAppear:(BOOL)animated
{
	[homeMenuTable reloadData];
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[homeMenuTable release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	switch (section) {
		case FIRST:
			return SECOND;
		case SECOND:
			return THIRD+1;
		case THIRD:
			return THIRD;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	static NSString *identifier =@"HOME_MENU";
	static NSString *mystore_identifier =@"HOME_MYSTORE";
	
	NotificationCustomCell *cell = (NotificationCustomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[NotificationCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	
	BOOL aBool = NO;
	switch (indexPath.section) 
	{
		case FIRST:
			{
				int notifications = [[DatabaseHandler sharedInstance] getPendingNotificationMessageCount];
				[cell.menuNameLbl setText:@"Notifications"];
				//[cell.menuIconImageView setImage:[UIImage imageNamed:@"notificationMenuIcon.png"]];
				[cell.badgeNumberLbl setText:[NSString stringWithFormat:@"%d",notifications]];
				aBool = notifications ? NO : YES;

				[cell.badgeNumberLbl setHidden:aBool];
				[cell.badgeNumberBackgroundView setHidden:aBool];
			}
			break;
		case SECOND:
			switch (indexPath.row) 
			{
				case FIRST:
					{	
					
					int instructions = [[DatabaseHandler sharedInstance] getPendingInstructionCount];
					instructions = instructions + [[DatabaseHandler sharedInstance] getNonExecutedCount];
						
					[cell.menuNameLbl setText:@"Instructions"];
				//	[cell.menuIconImageView setImage:[UIImage imageNamed:@"instructionMenuIcon.png"]];
					[cell.badgeNumberLbl setText:[NSString stringWithFormat:@"%d",instructions]];
					
					aBool = instructions ? NO : YES;
						
					[cell.badgeNumberLbl setHidden:aBool];
					[cell.badgeNumberBackgroundView setHidden:aBool];
					}
					break;
				case SECOND:
					[cell.menuNameLbl setText:@"Calendar"];
					//[cell.menuIconImageView setImage:[UIImage imageNamed:@"calendarMenuIcon.png"]];
					[cell.badgeNumberLbl setHidden:YES];
					[cell.badgeNumberBackgroundView setHidden:YES];
					break;
				case THIRD:
					[cell.menuNameLbl setText:@"Guides"];
				//	[cell.menuIconImageView setImage:[UIImage imageNamed:@"guidesMenuIcon.png"]];
					[cell.badgeNumberLbl setHidden:YES];
					[cell.badgeNumberBackgroundView setHidden:YES];
					break;
					
			}
			break;
		case THIRD:			
			{
				switch (indexPath.row) 
				{
					case 0:	
					{
						MyStoreCustomCell *cell = (MyStoreCustomCell*)[tableView dequeueReusableCellWithIdentifier:mystore_identifier];
						
						if(nil == cell)
						{
							cell =[[[MyStoreCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:mystore_identifier] autorelease];
						}
						
						[cell.menuNameLbl setText:@"My Store"];
						//[cell.menuIconImageView setImage:[UIImage imageNamed:@"myStoreMenuIcon.png"]];
						
						int myStoreRating = 3;
						
						NSString *myRating = [[NSString alloc] initWithFormat:@"%dstars.png",myStoreRating];
						[cell.ratingStarImageView setImage:[UIImage imageNamed:myRating]];
						[myRating release];
						myRating = nil;
						
						return cell;
					}
						case 1:
							
					{
						[cell.menuNameLbl setText:@"Community"];
						//[cell.menuIconImageView setImage:[UIImage imageNamed:@"communityMenuIcon.png"]];
						[cell.badgeNumberLbl setHidden:YES];
						[cell.badgeNumberBackgroundView setHidden:YES];
					}

				}
				
			}
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	switch (indexPath.section) {
		case FIRST:
		{
			NotificationScreen *notificationScreen = [[NotificationScreen alloc] initWithNibName:@"NotificationScreen" bundle:[NSBundle mainBundle]];
			[self.navigationController pushViewController:notificationScreen animated:YES];
			[notificationScreen release];
		}
		break;
		case SECOND:
			switch (indexPath.row) {
				case FIRST:
				{
					InstructionsScreen *instructionsScreen = [[InstructionsScreen alloc] initWithNibName:@"InstructionsScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:instructionsScreen animated:YES];
					[instructionsScreen release];
					break;
				}
				case SECOND:
				{
					CalendarScreen *calendarScreen = [[CalendarScreen alloc] initWithNibName:@"CalendarScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:calendarScreen animated:YES];
					[calendarScreen release];
				}
				break;
				case THIRD:
				{
					GuidesScreen  *guidesScreen= [[GuidesScreen alloc] initWithNibName:@"GuidesScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:guidesScreen animated:YES];
					[guidesScreen release];
				}
				break;
			}
			break;

		case THIRD:
		{
			switch (indexPath.row) {
				case 0:	
				{
					MyStoreScreen *myStoreScreen = [[MyStoreScreen alloc] initWithNibName:@"MyStoreScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:myStoreScreen animated:YES];
					[myStoreScreen release];
				}
				break;
				case 1:
				{
					CommunityScreen *communityScreen = [[CommunityScreen alloc] initWithNibName:@"CommunityScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:communityScreen animated:YES];
					[communityScreen release];
				}
				break;
			}
		}
		break;

		default:
			break;
	}
	
}
@end
