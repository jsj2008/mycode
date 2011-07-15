//
//  InstructionHandler.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "InstructionHandler.h"


@implementation InstructionHandler

+ (int) getBadgeNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = 0;
	if([standardUserDefaults valueForKey:INSTRUCTIONS_MESSAGE_BADGE])
	{
		badgeNumber = [[standardUserDefaults valueForKey:INSTRUCTIONS_MESSAGE_BADGE] intValue];
	}
	return badgeNumber;
}

- (void) updateBadgeNumber : (int)aNumber
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	int badgeNumber = [InstructionHandler getBadgeNumber];
	
	badgeNumber = badgeNumber + aNumber;
	
	[standardUserDefaults setValue:[NSNumber numberWithInt:badgeNumber] forKey:INSTRUCTIONS_MESSAGE_BADGE];
}

-(void) dealloc
{
	NSLog(@"InstructionHandler---------------------Release");
	[super dealloc];
}
@end
