//
//  CalendarTouchEvent.h
//  iShopShape
//
//  Created by Ayush on 18/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarTouch.h"
#import "CalendarEvent.h"

@interface CalendarTouchEvent : UIViewController 
{
  	IBOutlet UITableView *EventTable;
//	NSMutableArray *eventarray;
	CalendarEvent *calendarTouch;
	int height;
}
@property (nonatomic, retain) UITableView *EventTable;

//@property (nonatomic, retain) NSMutableArray *eventarray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil details:(CalendarEvent *)aCalenderEventDetails;
@end