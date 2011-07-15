//
//  CalendarTouch.m
//  iShopShape
//
//  Created by Ayush on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarTouch.h"


@implementation CalendarTouch
@synthesize TitleLabel;
@synthesize Imagename;
@synthesize descrption;
@synthesize HeaderLabel;
@synthesize tagid;
@synthesize eventname;
@synthesize StartDate;
@synthesize EndDate;
@synthesize theme;

@synthesize imageNameArray , imageTitleArray, imageSizeLableArray ;

- (void) dealloc
{
	[TitleLabel release];
	[eventname release];
	[Imagename release];
	[descrption release];
	[HeaderLabel release];
	[StartDate release];
	[EndDate release];
	[theme release];
	
	[imageNameArray release];
	[imageTitleArray release];
	[imageSizeLableArray release];
	
	[super dealloc];
}
@end
