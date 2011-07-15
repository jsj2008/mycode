//
//  iShopShapeAppDelegate.m
//  iShopShape
//
//  Created by Santosh B on 14/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "iShopShapeAppDelegate.h"
#import "iShopShapeViewController.h"
#import "APNSEventHandler.h"
#import "Logger.h"
#import "DatabaseHandler.h"
#import "Reachability.h"

#define REPEAT_TIME 240
#define kHostName @"www.google.com"


@implementation iShopShapeAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize navigationController;


-(void) httpPOSTServiceFinish : (NSDictionary *)dict
{
	NSLog(@"httpPOSTServiceFinish ==%@", dict);
}
-(void) httpPOSTServiceFinishWithError : (NSError *)error;
{
	NSLog(@"Error %@", [error description]);
}

- (void) registerUser : (NSString *)storeID
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

	[userDefault setObject:storeID forKey:@"STORE_ID"];
	[userDefault setObject:[self getDeviceIdentifier] forKey:@"USER_ID"];
	
	//[userDefault setObject:@"eaaeb95fef8f3ddf1a475de786cd911e82ddc106" forKey:@"USER_ID"];
	
	NSString *str = [NSString stringWithFormat:@"%@/%@/%@",REGISTER_URL, [userDefault objectForKey:@"USER_ID"],[userDefault objectForKey:@"STORE_ID"]];
	[userDefault synchronize];

	NSURL *url = [NSURL URLWithString:str];
	HTTPServicePOSTHandler *HTTPServicePOSTHandlerObj = [[HTTPServicePOSTHandler alloc] autorelease];
	[HTTPServicePOSTHandlerObj registerUser:url];
	HTTPServicePOSTHandlerObj.delegate = self;
	[pool release];
}

- (void) updateApplicationBadgeNumber
{
	int applicationBadgeNumber = [[DatabaseHandler sharedInstance] getPendingNotificationMessageCount] + [[DatabaseHandler sharedInstance] getPendingInstructionCount] 
	+ [[DatabaseHandler sharedInstance] getNonExecutedCount];
	
	NSLog(@"applicationBadgeNumber -- %d", applicationBadgeNumber);
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:applicationBadgeNumber];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	//Logger initialization
	[Logger init];
	
	databaseHandler = [DatabaseHandler sharedInstance];
	[self deleteDueInstructions];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSLog(@" == %@",[userDefault valueForKey:@"STORE_ID"]);
	if(![userDefault valueForKey:@"STORE_ID"])
	{
		getStoreLists = [[GetStoreLists alloc] init];
		[getStoreLists setDelegate:self];
		[getStoreLists accessStoreList];
	}
	
	[self continousPingToServer];
	
	//Register for APNS notifications
	//[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];

    // Add the view controller's view to the window and display.
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	
	[self.window addSubview:navigationController.view];
	
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	[self deleteDueInstructions];
	[self updateApplicationBadgeNumber];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	if(getStoreLists)
		[getStoreLists release];
	
	[databaseHandler release];
	[navigationController release];
    [viewController release];
    [window release];
    [super dealloc];
}

#pragma mark - DIVICE ID
- (NSString *) getDeviceIdentifier
{
	UIDevice *device = [UIDevice currentDevice];
	return [device uniqueIdentifier];
}

#pragma mark -
#pragma mark ALERT
//Alert view to show an notification alert
-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle{
	UIAlertView *alert = nil;
	
	if([otherTitle isEqualToString:@""])
		alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:nil,nil];
	else 
		alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle,nil];
	[alert show]; 
	[alert release];
}

#pragma mark -
#pragma mark NOTIFICATION

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { 
	NSLog(@"devToken=%@",deviceToken);
	[self alertNotice:@"" withMSG:[NSString stringWithFormat:@"devToken=%@",deviceToken] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	NSLog(@"%@", userInfo);
	
	if(userInfo)
	{
		NSDictionary *dict = [userInfo objectForKey:@"aps"];
		NSString *alert = [dict valueForKey:@"alert"];
		
		[self alertNotice:@"New Message" withMSG:alert cancleButtonTitle:@"" otherButtonTitle:@"Ok"];
		//[[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
		
		//This method will handle the APNS notification based on the notification id
		[self handleAPNSNotification:dict];
	}
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
	NSLog(@"Error in registration. Error: %@", err);
	[self alertNotice:@"" withMSG:[NSString stringWithFormat:@"Error in registration. Error: %@", err] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
}

#pragma mark -
#pragma mark APNS Notification Handler
- (void) handleAPNSNotification:(NSDictionary *)aDict
{
	APNSEventHandler *apnsEventHandler = [[APNSEventHandler alloc] init];
	[apnsEventHandler decideNotificationHandler:aDict];
	
	//update the application badgenumber
	[apnsEventHandler updateApplicationBadgeNumber];
	[apnsEventHandler release];
}

- (void) handleDemoNotification:(NSDictionary *)aDict
{
	APNSEventHandler *apnsEventHandler = [[APNSEventHandler alloc] init];
	[apnsEventHandler handleDemoNotification:(NSMutableArray *)aDict];
	
	//update the application badgenumber
	[apnsEventHandler updateApplicationBadgeNumber];
	[apnsEventHandler release];
	[viewController.homeMenuTable reloadData];
	
}

#pragma mark -
#pragma mark temporary ping implementation
#pragma mark -

- (void) continousPingToServer
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSURL *url = [NSURL URLWithString:GETMESSAGE];
	HTTPServiceHandler *HTTPServiceHandlerObj = [[HTTPServiceHandler alloc] autorelease];
	[HTTPServiceHandlerObj initWithRequest:url];
	
	HTTPServiceHandlerObj.delegate = self;
	[pool release];
}

#pragma mark -
#pragma mark HTTPServiceHandlerDelegate
#pragma mark -

-(void) httpServiceFinish : (NSDictionary *)dict
{
	NSLog(@"Response : %@",dict);
	
	if([(NSMutableArray *)dict count])
	{
	   [self handleDemoNotification:dict];
	}
	[self performSelector:@selector(continousPingToServer) withObject:nil afterDelay:REPEAT_TIME];

}

-(void) httpServiceFinishWithError : (NSError *)error
{
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];	

	[self performSelector:@selector(continousPingToServer) withObject:nil afterDelay:REPEAT_TIME];
}


#pragma mark -
#pragma mark Delete Due Instruction
#pragma mark -

- (void) deleteDueInstructions
{
	NSArray *instructionList = [[DatabaseHandler sharedInstance] readAllInstructionFromDatabase];
	
	
	NSDate *currentDate = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	[dateFormatter setDateFormat:@"eee,MMM dd,yyyy"];

	//for(int iLoop = 0; iLoop < [instructionList count]; iLoop++)
	for(Instruction *instruction in instructionList)
	{
		//Instruction *instruction = [instructionList objectAtIndex:iLoop];
		NSString *end = instruction.endDate;
		NSDate *enddate= [dateFormatter dateFromString:end];
		NSCalendar *calendar = [NSCalendar currentCalendar];
		NSDateComponents *differenceComponents = [calendar components:(NSDayCalendarUnit)
															 fromDate:currentDate
															   toDate:enddate
															  options:0];
		
		int noDays= [differenceComponents day];
		if(noDays<0)
		{
			[ [DatabaseHandler sharedInstance] deletefromInstructions:instruction.instId];
			
		}
	}
	[dateFormatter release];
}
#pragma mark -
#pragma mark GetStoreListsDelegate
#pragma mark -
- (void) getStoreList : (NSArray *)storeList
{
	if([storeList count])
	{
		NSDictionary *dict = [storeList objectAtIndex:0];
		
		NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
		if(![userDefault valueForKey:@"STORE_ID"])
		{
			NSLog(@"Registering user first time");
			NSArray *arr = [dict allKeys];
			if(arr)
			{
				[self registerUser: [arr objectAtIndex:0]];
				
				NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
				
				[userDefault setObject:[dict valueForKey:[arr objectAtIndex:0]] forKey:@"STORE_NAME"];
				
			}
		}
	}
}
@end
