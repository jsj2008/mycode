//
//  CalendarEvent.h
//  ScrollViewController
//
//  Created by Ayush Goel on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarTouch.h"

@interface CalendarEvent : NSObject {
	NSString *category;
	NSString *Eventname;
	NSString *StartDate;
	NSString *EndDate;
	UIImage *addimage;
	CalendarTouch *calenderTouch;
}


@property(nonatomic,retain) NSString *StartDate;
@property(nonatomic,retain) NSString *EndDate;
@property(nonatomic,retain) UIImage *addimage;
@property(nonatomic,retain) NSString *category;
@property(nonatomic,retain) NSString *Eventname;
@property(nonatomic,retain) CalendarTouch *calenderTouch;
@end
