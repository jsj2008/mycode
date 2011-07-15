//
//  APNSEventHandler.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "APNSEventHandler.h"
#import "NotificationHandler.h"
#import "InstructionHandler.h"
#import "RatingEventHandler.h"
#import "GuideHandler.h"
#import "DatabaseHandler.h"

@implementation APNSEventHandler

- (void) dealloc
{
	NSLog(@"APNSEventHandler---------------------------Release");
	
	[super dealloc];
}

- (void) handleDemoNotification:(NSMutableArray *)aArray
{
	NSLog(@"%@",aArray);
	if(alert)
	{
		[alert dismissWithClickedButtonIndex:0 animated:NO];
	}
	if(aArray)
	if([aArray count])
	{
		NSString *message = nil;
		//for(int iLoop = 0 ; iLoop < [aArray count]; iLoop++)
		for(NSDictionary *aDict in aArray)
		{
			//NSDictionary *aDict = [aArray objectAtIndex:iLoop];
			int badgeNumber = [[aDict valueForKey:@"type"] intValue];
			NSString *guid = [aDict valueForKey:@"id"];
			message = [aDict valueForKey:@"message"];
			switch (badgeNumber) 
			{
				case NOTIFICATION_MESSAGE:
				{	
					//Notification handler will insert this in pending list
					NSLog(@"Its notification message");
					NotificationHandler *notificationHandler = [[NotificationHandler alloc] init];
					[notificationHandler insertEventInPendingList:guid category:NOTIFICATION_MESSAGE];
					
					[notificationHandler release];
				}
					break;
				case INSTRUCTIONS_MESSAGE:
				{
					//instruction handler will insert this in pending list
					NSLog(@"Its instruction message");
					InstructionHandler *instructionHandler = [[InstructionHandler alloc] init];
					[instructionHandler insertEventInPendingList:guid category:INSTRUCTIONS_MESSAGE];
					
					[instructionHandler release];
				}
					break;
					
				case RATINGS_MESSAGE:
				{
					//instruction handler will insert this in pending list
					NSLog(@"New Ratings");
					RatingEventHandler *ratingEventHandler = [[RatingEventHandler alloc] init];
					[ratingEventHandler insertEventInPendingList:guid category:RATINGS_MESSAGE];
					
					[ratingEventHandler release];
				}
					break;
				case GUIDES_MESSAGE:
				{
					//guides handler will insert this in pending list
					NSLog(@"Its new guide message");
					GuideHandler *guideHandler = [[GuideHandler alloc] init];
					[guideHandler insertEventInPendingList:guid category:GUIDES_MESSAGE];
					
					[guideHandler release];
				}
					break;
				default:
					break;
			}
		}
		if(message)
		{
			NSString *newMessage = [NSString stringWithFormat:@"A new %@ instruction has been posted.", message];
			[self performSelectorOnMainThread:@selector(showAlertMessage:) withObject:newMessage waitUntilDone:NO];
		}
	}
	
}

- (void) showAlertMessage : (NSString *)messageTitle
{
	alert = [[UIAlertView alloc] initWithTitle:@"iShopShape" message:messageTitle delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"View" ,nil];
	[alert show];
	[alert release];
}
						  
- (void) decideNotificationHandler : (NSDictionary *)aDict
{
	if(aDict)
	{
		int badgeNumber = [[aDict valueForKey:@"badge"] intValue];
		NSString *guid = [aDict valueForKey:@"alert"];
		
		switch (badgeNumber) 
		{
			case NOTIFICATION_MESSAGE:
				{	
					//Notification handler will insert this in pending list
					NSLog(@"Its notification message");
					NotificationHandler *notificationHandler = [[NotificationHandler alloc] init];
					[notificationHandler insertEventInPendingList:guid category:NOTIFICATION_MESSAGE];
					[notificationHandler updateBadgeNumber:1];
					[notificationHandler release];
				}
				break;
			case INSTRUCTIONS_MESSAGE:
				{
					//instruction handler will insert this in pending list
					NSLog(@"Its instruction message");
					InstructionHandler *instructionHandler = [[InstructionHandler alloc] init];
					[instructionHandler insertEventInPendingList:guid category:INSTRUCTIONS_MESSAGE];
					[instructionHandler updateBadgeNumber:1];
					[instructionHandler release];
				}
				break;
			case GUIDES_MESSAGE:
				{
					//guides handler will insert this in pending list
					NSLog(@"Its new guide message");
					GuideHandler *guideHandler = [[GuideHandler alloc] init];
					[guideHandler insertEventInPendingList:guid category:GUIDES_MESSAGE];
					[guideHandler updateBadgeNumber:1];
					[guideHandler release];
				}
				break;
			default:
				break;
		}
	}
}

- (void) updateApplicationBadgeNumber
{
	int applicationBadgeNumber = [[DatabaseHandler sharedInstance] getPendingNotificationMessageCount] + [[DatabaseHandler sharedInstance] getPendingInstructionCount] + [[DatabaseHandler sharedInstance] getPendingRatingCount]
	+ [[DatabaseHandler sharedInstance] getNonExecutedCount];
	
	NSLog(@"applicationBadgeNumber -- %d", applicationBadgeNumber);
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:applicationBadgeNumber];
}

@end
