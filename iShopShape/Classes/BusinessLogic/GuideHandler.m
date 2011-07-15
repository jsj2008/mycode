//
//  GuideHandler.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "GuideHandler.h"


@implementation GuideHandler

+ (int) getBadgeNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = 0;
	if([standardUserDefaults valueForKey:GUIDES_MESSAGE_BADGE])
	{
		badgeNumber = [[standardUserDefaults valueForKey:GUIDES_MESSAGE_BADGE] intValue];
	}
	return badgeNumber;
}

- (void) updateBadgeNumber : (int)aNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = [GuideHandler getBadgeNumber];

	badgeNumber = badgeNumber + aNumber;
	
	[standardUserDefaults setValue:[NSNumber numberWithInt:badgeNumber] forKey:GUIDES_MESSAGE_BADGE];
}

-(void) dealloc
{
	NSLog(@"GuideHandler---------------------Release");
	[super dealloc];
}
@end
