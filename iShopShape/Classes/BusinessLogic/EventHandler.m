//
//  EventHandler.m
//  iShopShape
//
//  Created by Santosh B on 28/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "EventHandler.h"
#import "DatabaseHandler.h"

@implementation EventHandler

- (void) insertEventInPendingList :guid category : (int)category
{
	[[DatabaseHandler sharedInstance] insertPendingNotification:guid category:category];
}

- (void) updateBadgeNumber : (int)aNumber
{
	
}

+ (int) getBadgeNumber
{
	return 0;
}

-(void) dealloc
{
	[super dealloc];
}
@end
