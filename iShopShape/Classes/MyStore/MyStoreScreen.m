//
//  MyStoreScreen.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "MyStoreScreen.h"
#import "MyStoreCustomCell.h"
#import "NotificationCustomCell.h"
#import "RatingsScreen.h"
#import "StoreLayoutScreen.h"
#import "Logger.h"
#import "DatabaseHandler.h"
#import "PhotoHistory.h"
#import "StoreImageObj.h"

#define GET_RATING_DETAILS_URL @""

@implementation MyStoreScreen

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void) getRatingDetails
{
	NSURL *url = [NSURL URLWithString:GET_RATING_DETAILS_URL];
	HTTPServiceHandlerObj = [[HTTPServiceHandler alloc] init];
	[HTTPServiceHandlerObj setDelegate:self];
	[HTTPServiceHandlerObj initWithRequest:url];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	currentWeekRatings = 0;
	[self setTitle:@"My Store"];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackground.png"]]];
	[myStoreTableView setBackgroundColor:[UIColor clearColor]];
	
	//If any pending ratings are available download it.
	if([[DatabaseHandler sharedInstance] getPendingRatingCount])
	{
		[self getRatingDetails];
	}
	[super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"MyStoreScreen-----------------------------Release");
	[HTTPServiceHandlerObj setDelegate:nil];
	[HTTPServiceHandlerObj release];
    [super dealloc];
}


- (NSArray *)getMyStorePhotoHistory 
{
	NSArray *pictureArray = [[DatabaseHandler sharedInstance] readAllImagesandDate];
	return pictureArray;
}

#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	int rows = 0;
	switch (section) {
		case 0:
			rows = 1;
			break;
		case 1:
			rows = 2;
			break;
	}
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	static NSString *identifier =@"HOME_MENU";
	
	if(indexPath.section == 0)
	{
		MyStoreCustomCell *cell = (MyStoreCustomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
		
		if(nil == cell)
		{
			cell =[[[MyStoreCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
		}
		
		[cell.menuNameLbl setText:@"Ratings"];
		[cell.menuIconImageView setImage:[UIImage imageNamed:@"ratingMenuIcon.png"]];
		currentWeekRatings = 3;
		NSString *myRating = [[NSString alloc] initWithFormat:@"%dstars.png",currentWeekRatings];
		[cell.ratingStarImageView setImage:[UIImage imageNamed:myRating]];
		[myRating release];
		myRating = nil;
		
		return cell;	
	}
	
	NotificationCustomCell *cell = (NotificationCustomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[NotificationCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	
	if(indexPath.section == 1 && indexPath.row == 0)
	{
		[cell.menuNameLbl setText:@"Photo History"];
		[cell.menuIconImageView setImage:[UIImage imageNamed:@"photohistoryMenuIcon.png"]];
	}
	else if(indexPath.section == 1 && indexPath.row == 1)
	{
		[cell.menuNameLbl setText:@"Store layout"];
		[cell.menuIconImageView setImage:[UIImage imageNamed:@"storelayoutMenuIcon.png"]];
	}
	
	[cell.badgeNumberLbl setHidden:YES];
	[cell.badgeNumberBackgroundView setHidden:YES];

	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	switch (indexPath.section) 
	{
		case 0:
			switch (indexPath.row) 
			{
				case 0:
				{
					RatingsScreen *ratingScreen = [[RatingsScreen alloc] initWithNibName:@"RatingsScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:ratingScreen animated:YES];
					[ratingScreen release];
				}
				break;
			}
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
				{
					PhotoHistory *photoHistory = [[PhotoHistory alloc] initWithNibName:@"PhotoHistory" bundle:[NSBundle mainBundle] picArray:(NSMutableArray*)[self getMyStorePhotoHistory]];
					[photoHistory setTitle:@"Photo History"];
					[self.navigationController pushViewController:photoHistory animated:YES];
					[photoHistory release];
					
				}
				break;
				case 1:
				{
					StoreLayoutScreen *storeLayoutScreen = [[StoreLayoutScreen alloc] initWithNibName:@"StoreLayoutScreen" bundle:[NSBundle mainBundle]];
					[self.navigationController pushViewController:storeLayoutScreen animated:YES];
					[storeLayoutScreen release];
				}
					break;
			}
			break;
	}
}


#pragma mark -
#pragma mark HTTPServiceHandlerDelegate
#pragma mark -

-(void) httpServiceFinish : (NSDictionary *)dict
{
	NSLog(@"Response : %@",dict);
	currentWeekRatings = 1;
	[myStoreTableView reloadData];
}

-(void) httpServiceFinishWithError : (NSError *)error
{
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];	
}

@end
