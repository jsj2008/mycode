//
//  CustomImageView.m
//  iShopShape
//
//  Created by Ayush on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"
#import "CalendarTouchEvent.h"

@implementation CustomImageView
@synthesize delegate;


#define GREEN_TEXT [UIColor colorWithRed:19/255.0 green:110/255.0 blue:0/255.0 alpha:1.0]
#define PINK_TEXT [UIColor colorWithRed:120/255.0 green:3/255.0 blue:124/255.0 alpha:1.0]
#define BLUE_TEXT [UIColor colorWithRed:40/255.0 green:76/255.0 blue:149/255.0 alpha:1.0]

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		//eventname=[[UILabel alloc] initWithFrame:CGRectMake(0, 40,130,20)];
    }
    return self;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
	if (delegate) {
		[delegate imagetouched:self.tag];
	}
	
}

- (void) setLabelProperty
{	
	titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, -5,120,20)];
	titleLable.backgroundColor=[UIColor clearColor];
	titleLable.font = [UIFont boldSystemFontOfSize:13.0];
	titleLable.textAlignment = UITextAlignmentLeft;

	[titleLable setShadowColor:[UIColor whiteColor]];
	titleLable.shadowOffset = CGSizeMake(0,0.9);
	
	[self addSubview:titleLable];
	[titleLable release];

	dateLable = [[UILabel alloc] initWithFrame:CGRectMake(2, 14,110,20)];
	dateLable.backgroundColor=[UIColor clearColor];
	dateLable.font = [UIFont systemFontOfSize:13.0];
	dateLable.textAlignment = UITextAlignmentLeft;
	[dateLable setShadowColor:[UIColor whiteColor]];
	dateLable.shadowOffset = CGSizeMake(0,0.9);	
	[self addSubview:dateLable];
	[dateLable release];
	

}

- (void) setEventData : (CalendarEvent*) event
{
	
	if([event.category isEqualToString:@"Focus"])
	{
		titleLable.textColor = GREEN_TEXT;
		dateLable.textColor = GREEN_TEXT;
	}
	else if([event.category isEqualToString:@"Seasonal"])
	{
		titleLable.textColor = PINK_TEXT;
		dateLable.textColor = PINK_TEXT;
	}
	else if([event.category isEqualToString:@"Promotional"])
	{
		titleLable.textColor = BLUE_TEXT;
		dateLable.textColor = BLUE_TEXT;
	}
	else {
		titleLable.textColor = BLUE_TEXT;
		dateLable.textColor = BLUE_TEXT;
	}


	   
	//[self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",event.category]]];
	NSString *eventTitle = event.Eventname;
	

	
	
	
	[titleLable setText:eventTitle];
	[self addSubview:titleLable];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *date = [dateFormatter dateFromString:event.StartDate];
	[dateFormatter setDateFormat:@"MMM dd"];
	NSString *startdate = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];
	
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	date = [dateFormatter dateFromString:event.EndDate];
	[dateFormatter setDateFormat:@"MMM dd"];

	NSString *enddate = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	
	NSString *dateTitle = [[NSString alloc] initWithFormat:@" %@ - %@",startdate, enddate];
	CGSize size1 = [dateTitle sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(120.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
	
	[dateLable setFrame:CGRectMake(dateLable.frame.origin.x,dateLable.frame.origin.y,  size1.width,size1.height)];
	[dateLable setText:dateTitle];
	[dateTitle release];
	[self addSubview:dateLable];
}

- (void)dealloc {
	NSLog(@"CustomImageView -------------- Release");
	delegate = nil;
	[titleLable release];
	[dateLable release];
    [super dealloc];
}


@end
