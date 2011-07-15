//
//  NotificationStatus.m
//  iShopShape
//
//  Created by Santosh B on 15/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "NotificationStatus.h"


@implementation NotificationStatus
@synthesize notificationId, status;

- (void)dealloc
{
	[notificationId release];
	[super dealloc];
}
@end
