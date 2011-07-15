//
//  Notification.m
//  iShopShape
//
//  Created by Santosh B on 17/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "Notification.h"


@implementation Notification

@synthesize notificationId, notificationTitle, notificationImage, position;

-(void)dealloc
{
	NSLog(@"Notification -------------------- Release");
	[notificationId release];
	[notificationTitle release];
	[notificationImage release];
	[super dealloc];
}
@end
