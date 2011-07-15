//
//  NotificationScreen.m
//  iShopShape
//
//  Created by Santosh B on 22/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "NotificationScreen.h"
#import "MessageStreamScreen.h"
#import "NotificationTableCell.h"
#import "NSMutableArray(Reverse).h"
#import "DatabaseHandler.h"
#import "NotificationStatus.h"
#import "Parser.h"
#import "Logger.h"



@implementation NotificationScreen

@synthesize notificationsTable;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self setTitle:@"Notifications"];
	
	titleArray = [[NSMutableArray alloc] init];
	notificationList = (NSMutableArray *)[[NSMutableArray alloc] init];
	
	NSArray *array = [[DatabaseHandler sharedInstance] getPendingNotifications];
	
	for(NSString *instructionId in array)
	{
		[activityIndicator startAnimating];
		[self getNotificationDetailsFromServer:instructionId];
	}
	[self loadNotificationsFromLocalDatabase];
	
    [super viewDidLoad];
}

- (void) loadNotificationsFromLocalDatabase
{
	if(notificationList)
	{
		[(NSMutableArray *)notificationList removeAllObjects];
	}
	NSArray *array = (NSMutableArray*)[[DatabaseHandler sharedInstance] readAllNotification];
	NSArray *lastArray = (NSMutableArray*)[[NSMutableArray alloc] init];
	statusDictionary = [[NSMutableDictionary alloc] init];
	
//	//for(int iLoop = 0 ; iLoop < [array count]; iLoop++)
	for(NotificationStatus *notificationStatus in array)
	{
		
		//NotificationStatus *notificationStatus = [array objectAtIndex:iLoop];

		NSString *lguid = notificationStatus.notificationId;
		int status = notificationStatus.status;
		
		NSLog(@"Guid=%@ status =%d", lguid, status);
		
		NSNumber *number = [NSNumber numberWithInt:status];
		[(NSMutableDictionary *)statusDictionary setValue:number forKey:notificationStatus.notificationId];
		
		//[(NSMutableArray*)lastArray addObject:notificationStatus.notificationId];
		
		Instruction *inst = [[DatabaseHandler sharedInstance] readFromInstruction:notificationStatus.notificationId];
		NSLog(@"INST == %@", inst.title);
		[(NSMutableArray*)lastArray addObject:inst];
	}
	
	if(lastArray && [lastArray count])
	{
		[(NSMutableArray*)lastArray reverse];
	}
	[(NSMutableArray *)notificationList addObjectsFromArray:lastArray];
	[lastArray release];
	[notificationsTable reloadData];
	[activityIndicator stopAnimating];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//-(void) viewWillAppear:(BOOL)animated
//{
//	[notificationsTable reloadData];
//}

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
	NSLog(@"NotificationScreen -------------------- Release");
	[notificationList release];
	[statusDictionary release];
	[notificationsTable release];
    [super dealloc];
}

//- (void) setCellSize : (NotificationTableCell*)cell index:(int) index
//{
//	Notification *notification = [notificationList objectAtIndex:index];
//	
//	NSString *fullAddress = notification.notificationTitle;
//
//	CGSize constraintSize ;
//	constraintSize.width = 280;
//	constraintSize.height = MAXFLOAT;
//
//	CGSize stringSize =[fullAddress sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//	int addressHeight = stringSize.height;
//	CGRect rect = CGRectMake(10, 5, 280, addressHeight);
//	[cell.notificationLable setFrame:rect];
//	cell.notificationLable.numberOfLines = 0;
//	cell.notificationLable.lineBreakMode = UILineBreakModeWordWrap;
//	cell.notificationLable.adjustsFontSizeToFitWidth = YES;
//
//	[cell.notificationLable setText:fullAddress];
//}



#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

//- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	NSString *notificationTitle = [NSString stringWithFormat:@"VM has replied to your %@ message", [[DatabaseHandler sharedInstance] readNotificationTitles:notification.notificationId]];
//	CGSize size = [notificationTitle  sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(280,100) lineBreakMode:UILineBreakModeWordWrap];
//	return size.height + 40;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	return [notificationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	static NSString *identifier =@"HOME_MENU";
	
	NotificationTableCell *cell = (NotificationTableCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[NotificationTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	
	//Notification *notification = [notificationList objectAtIndex:indexPath.row];
	
	Instruction *inst = [notificationList objectAtIndex:indexPath.row];
	if(inst)
	{
		NSNumber *number = [statusDictionary valueForKey:inst.instId];
		if([number intValue] == 1)
		{
			[cell.bgView setAlpha:0];
		}
		else 
		{
			[cell.bgView setAlpha:1];
		}
		
		Instruction *inst = [notificationList objectAtIndex:indexPath.row];
		NSLog(@"\n\n\n\n\n inst.title === %@", inst.title);
		[cell setCellData:inst.title];		
		
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	Instruction *inst = [notificationList objectAtIndex:indexPath.row];
	NSString *aTitle = inst.title; 
	NSString *notificationTitle = [NSString stringWithFormat:@"VM has replied to your %@ message", aTitle];
	
	CGSize constraintSize ;
	constraintSize.width = 280;
	constraintSize.height = MAXFLOAT;
	
	CGSize stringSize =[notificationTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

	return stringSize.height + 20;
}


- (void)launchMessageStreamScreen : (int) index
{

	Instruction *inst = [notificationList objectAtIndex:index];
	
	MessageStreamScreen *messageStreamScreen = [[MessageStreamScreen alloc] initWithNibName:@"MessageStreamScreen" bundle:[NSBundle mainBundle] guid:inst.instId];
	[self.navigationController pushViewController:messageStreamScreen animated:YES];
	[messageStreamScreen release];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	/*
	 delete notification from the unviewedlist
	 */
	
	Instruction *inst = [notificationList objectAtIndex:indexPath.row];
	
	[[DatabaseHandler sharedInstance] updateViewedNotification:inst.instId];

	[self launchMessageStreamScreen:indexPath.row];
	NotificationTableCell *cell = (NotificationTableCell*)[notificationsTable cellForRowAtIndexPath:indexPath];
	[cell.bgView setAlpha:0];
	
}

#pragma mark -
- (void) getNotificationDetailsFromServer : (NSString *)instructionID
{	
	NSString *urlString = [NSString stringWithFormat:@"%@/%@", NOTIFICATION_DETAILS_URL, instructionID];//@"11111111-1111-1111-1111-111111111111"];
	NSURL *url = [NSURL URLWithString:urlString];
	HTTPServiceHandler *HTTPServiceHandlerObj = [[HTTPServiceHandler alloc] autorelease];
	[HTTPServiceHandlerObj initWithRequest:url];
	HTTPServiceHandlerObj.delegate = self;
}

- (void) stopActivityIndicator
{
	[activityIndicator stopAnimating];
	[self loadNotificationsFromLocalDatabase];
}


#pragma mark -

- (void) insertNotificationToDatabase : (Notification *)notification
{
	[[DatabaseHandler sharedInstance] insertMessageStream:notification];
	[[DatabaseHandler sharedInstance] insertNotification:notification];	
	[[DatabaseHandler sharedInstance] deletefromPending:notification.notificationId];
}

#pragma mark -
#pragma mark HTTPServiceHandlerDelegate
#pragma mark -
-(void) httpServiceFinish : (NSDictionary *)dict
{
	if(dict)
	{
		Notification *notification = [Parser parseNotificationDetails:(NSArray*)dict];
		if(notification)
		{
			[self performSelectorOnMainThread:@selector(insertNotificationToDatabase:) withObject:notification waitUntilDone:NO];
		}
	}
	
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
}

-(void) httpServiceFinishWithError : (NSError *)error
{
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];
	
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
}

@end
