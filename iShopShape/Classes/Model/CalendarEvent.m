//
//  CalendarEvent.m
//  ScrollViewController
//
//  Created by Ayush Goel on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalendarEvent.h"


@implementation CalendarEvent

@synthesize  StartDate;
@synthesize EndDate;
@synthesize addimage;
@synthesize category;
@synthesize Eventname;
@synthesize calenderTouch;
-(void)dealloc
{
	NSLog(@"CalendarEvent -------------------- Release");
	[StartDate release];
	[EndDate release];
	[addimage release];
	[category release];
	[Eventname release];
	[calenderTouch release];
	[super dealloc];
}
@end
