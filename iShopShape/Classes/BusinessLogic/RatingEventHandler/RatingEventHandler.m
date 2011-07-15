//
//  RatingEventHandler.m
//  iShopShape
//
//  Created by Santosh B on 10/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "RatingEventHandler.h"


@implementation RatingEventHandler
+ (int) getBadgeNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = 0;
	if([standardUserDefaults valueForKey:RATINGS_MESSAGE_BADGE])
	{
		badgeNumber = [[standardUserDefaults valueForKey:RATINGS_MESSAGE_BADGE] intValue];
	}
	return badgeNumber;
}

- (void) updateBadgeNumber : (int)aNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = [RatingEventHandler getBadgeNumber];
	
	badgeNumber = badgeNumber + aNumber;
	
	[standardUserDefaults setValue:[NSNumber numberWithInt:badgeNumber] forKey:RATINGS_MESSAGE_BADGE];
}

-(void) dealloc
{
	NSLog(@"RatingEventHandler---------------------Release");
	[super dealloc];
}
@end
