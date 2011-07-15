//
//  CalendarTouchEvent.m
//  iShopShape
//
//  Created by Ayush on 18/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarTouchEvent.h"
#import "CustomCalendarEvent.h"
#import "CalendarCustomCell.h"

@implementation CalendarTouchEvent
@synthesize EventTable;
//@synthesize eventarray;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil details:(CalendarEvent *)aCalenderEventDetails
{
	 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	 if (self) 
	 {
		 calendarTouch = aCalenderEventDetails;
	 }
	 return self;
}


- (void)viewDidLoad 
{
	[self setTitle:calendarTouch.Eventname];
	
	[EventTable setBackgroundColor:[UIColor clearColor]];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackground.png"]]];
	
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
									   initWithTitle:@"Done" 
									   style:UIBarButtonItemStyleBordered
									   target:self
									   action:@selector(cancelButtonAction:)
									   ];
	[[self navigationItem] setRightBarButtonItem:settingsButton];
	[settingsButton release];

   // CalendarTouch *calandertouch =[eventarray objectAtIndex:0];
	CalendarTouch *calendarDetails =  calendarTouch.calenderTouch;
	CGSize size = [calendarDetails.theme sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280,50) lineBreakMode:UILineBreakModeWordWrap];
	height=size.height;
	[super viewDidLoad];
}


- (IBAction) cancelButtonAction : (id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section==0)
	{
		CalendarTouch *calendarDetails =  calendarTouch.calenderTouch;
       return [calendarDetails.imageTitleArray count];
	}
	if(section==1)
		return 2;
	
	return  1;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section==1)
		return 18.0f;
	return 28.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section==0)
           return @"Materials";
//	if(section==1)
//		return @"Notes";
	return @" ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	
	NSInteger sectionRows = indexPath.section;
	
	CalendarTouch *calendarDetails =  calendarTouch.calenderTouch;
	
	if(sectionRows==0)
	{
		static NSString *kCustomCellID = @"MyCellID";
		CustomCalendarEvent *cell = (CustomCalendarEvent*)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
		
		if (cell == nil) 
		{
			cell = [[[CustomCalendarEvent alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
		}	
		
		[cell setCellData:[calendarDetails.imageNameArray objectAtIndex:indexPath.row] size:[calendarDetails.imageSizeLableArray objectAtIndex:indexPath.row]];
		//[cell setCellData:calandertouch];

		return cell;
	}
	
	if(sectionRows==1)
	{
		//CalendarTouch *calandertouch =[eventarray objectAtIndex:0];
		static NSString *kCustomCellID1 = @"MyCellsimpleID";
		CalendarCustomCell *cell1 = (CalendarCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCustomCellID1];
		if (cell1 == nil)
		cell1 = [[[CalendarCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID1] autorelease];
	   
		if(indexPath.row==0)
		{
			cell1.titlename.text= @"Theme";
			cell1.description.text=calendarDetails.theme;
			NSString *eventdescription = calendarDetails.theme;
			CGSize size = [eventdescription sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280,50) lineBreakMode:UILineBreakModeWordWrap];
			cell1.titlename.backgroundColor=[UIColor clearColor];
			cell1.description.numberOfLines = 0;
			cell1.description.lineBreakMode = UILineBreakModeWordWrap;
			cell1.description.textAlignment = UITextAlignmentLeft;
			cell1.titlename.frame = CGRectMake(10,10,280,20);
			cell1.description.frame=CGRectMake(10,30,size.width,size.height);
		}
		
		if(indexPath.row==1)
		{
			cell1.titlename.text= @"Duration";
			
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"dd-MM-yyyy"];
			[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			NSDate *date = [dateFormatter dateFromString:calendarTouch.StartDate];
			[dateFormatter setDateFormat:@"eeee, MMM dd, yyyy"];
			NSString *date1 = [dateFormatter stringFromDate:date];
			NSString *start=[NSString stringWithFormat:@"Start: %@",date1];	
			cell1.startdate.text=start;
			cell1.titlename.frame = CGRectMake(10,10,280,20);
		    cell1.startdate.frame=CGRectMake(10,30,280,20);
			
			[dateFormatter setDateFormat:@"dd-MM-yyyy"];
			[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			date = [dateFormatter dateFromString:calendarTouch.EndDate];
			[dateFormatter setDateFormat:@"eeee, MMM dd, yyyy"];
			date1 = [dateFormatter stringFromDate:date];
			NSString *end=[NSString stringWithFormat:@"End: %@",date1];	
		    cell1.enddate.text=end;
			cell1.enddate.frame=CGRectMake(10,50,280,20);
			[dateFormatter release];
			
		}
			
		return cell1;
	}
	
	return 0;
		
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	int temp=height+50;
	CalendarTouch *calendarDetails =  calendarTouch.calenderTouch;
	
	NSInteger sectionRows = indexPath.section;
    if(sectionRows==0)
	{
		NSArray *array = calendarDetails.imageNameArray;
		NSString *imageName = [array objectAtIndex:indexPath.row];
		UIImage *image = [UIImage imageNamed:imageName];
	     return image.size.height + 40;
	}
	if(sectionRows==1)
	{
	   if(temp>85)
		return height+49;
	   else 
		   return 85;	
	 }
	return  1;
	
}

#pragma mark -

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.EventTable = nil;
	
}


- (void)dealloc {
	NSLog(@"CalendarTouchEvent ------------------------- Release");
	
    [super dealloc];
}




@end
