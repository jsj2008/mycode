//
//  NotificationHandler.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "NotificationHandler.h"

@implementation NotificationHandler


+ (int) getBadgeNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = 0;
	if([standardUserDefaults valueForKey:NOTIFICATION_MESSAGE_BADGE])
	{
		badgeNumber = [[standardUserDefaults valueForKey:NOTIFICATION_MESSAGE_BADGE] intValue];
	}
	return badgeNumber;
}

- (void) updateBadgeNumber : (int)aNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = [NotificationHandler getBadgeNumber];
	
	badgeNumber = badgeNumber + aNumber;
	
	[standardUserDefaults setValue:[NSNumber numberWithInt:badgeNumber] forKey:NOTIFICATION_MESSAGE_BADGE];
}

-(void) dealloc
{
	NSLog(@"NotificationHandler---------------------Release");
	[super dealloc];
}
@end
