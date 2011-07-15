//
//  CalendarScreen.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "CalendarScreen.h"
#import "CalendarEvent.h"
#import "CustomImageView.h"

#import "CalendarTouch.h"

@implementation CalendarScreen

@synthesize ImageBar;
@synthesize WeekNoBar;
@synthesize LabelBar;
@synthesize ly2;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	[self setTitle:@"Calendar"];

	calanderEventDetailsArray= [[NSMutableArray alloc] init];
	[self createdatabase];
	[self weeklabel];
	NSMutableDictionary *eventNameDictWithArray = [[NSMutableDictionary alloc] init];
	keyArray = [[NSMutableArray alloc] init];
	for(int i=0;i<[calanderEventDetailsArray count];i++)
	{
		NSArray *lkeyArray = [eventNameDictWithArray allKeys];
		CalendarEvent *localEvent =[calanderEventDetailsArray objectAtIndex:i];
		NSLog(@"%@", localEvent.category);
		if([lkeyArray containsObject:localEvent.category])
		{
			NSMutableArray *localEventArray = [eventNameDictWithArray objectForKey:localEvent.category];
			[localEventArray addObject:localEvent];
			[eventNameDictWithArray setObject:localEventArray forKey:localEvent.category];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:localEvent,nil];
			[eventNameDictWithArray setObject:localEventArray forKey:localEvent.category];
			[localEventArray release];
			[keyArray addObject:localEvent.category];
		}
	}
	[self settings];
	strip.backgroundColor=[UIColor clearColor];
	year = [[UILabel alloc] initWithFrame:CGRectMake(5 ,19,120, 30)];
	year.text=[NSString stringWithFormat:@"%d",currentyear];
	year.textColor = [UIColor colorWithRed:65/255.0
									 green:65/255.0
									  blue:65/255.0
									 alpha:1.0];
	year.font = [UIFont systemFontOfSize: 13.0 ];
	year.backgroundColor=[UIColor clearColor];
	[strip addSubview:year];
	[year release];
	
	//for(int iLoop =0; iLoop < [keyArray count]; iLoop++)
	int newCounter = 0;
	int iLoop = 0;
	int imagecounter=0;
	for(NSString *key in keyArray)
	{
		if(imagecounter==0)
		{
			topImage=[UIImage imageNamed:@"green-top.png"];
			middleImage=[UIImage imageNamed:@"green-middle.png"];
			bottomImage=[UIImage imageNamed:@"green-bottom.png"];
		}
		else if(imagecounter==1)
		{
			topImage=[UIImage imageNamed:@"pink-top.png"];
			middleImage=[UIImage imageNamed:@"pink-middle.png"];
			bottomImage=[UIImage imageNamed:@"pink-bottom.png"];
		}
		else 
		{
			topImage=[UIImage imageNamed:@"blue-top.png"];
			middleImage=[UIImage imageNamed:@"blue-middle.png"];
			bottomImage=[UIImage imageNamed:@"blue-bottom.png"];
		}
		imagecounter=imagecounter+1;
		
		NSLog(@"key === %@", key);
		//NSArray *eventArray = [eventNameDictWithArray objectForKey:[keyArray objectAtIndex:iLoop]];
		NSArray *eventArray = [eventNameDictWithArray objectForKey:key];
		NSDate *startdate,*enddate;
		
		for(int jLoop = 0; jLoop < [eventArray count]; jLoop++)
		{
			CalendarEvent *event=[eventArray objectAtIndex:jLoop];
			/***** Setting the Label Bar****/
			if(jLoop==0)
			{
				UILabel * v = [[UILabel alloc] initWithFrame:CGRectMake((iLoop)*130+40 ,-3,120,30)];
				[v setCenter:CGPointMake((iLoop)*130+60, 13)];
				[v setTextAlignment:UITextAlignmentCenter];
				v.text=event.category;
				v.textColor = [UIColor colorWithRed:65/255.0
											  green:65/255.0
											   blue:65/255.0
											  alpha:1.0];
				v.backgroundColor=[UIColor clearColor];
				[v setShadowColor:[UIColor whiteColor]];
				v.shadowOffset = CGSizeMake(0,0.9);
				
				v.font = [UIFont systemFontOfSize: 13.0 ];
				[LabelBar addSubview:v];
				[v release];
			}
			startdate=[self stringToDate:event.StartDate];
			enddate=[self stringToDate:event.EndDate];
			startweek=[self weekno:globaldate and:startdate]+27-globalweek;
			endweek=[self weekno:globaldate and:enddate]+27-globalweek;
			//NSLog(@"start week =%f endweek=%f",startweek,endweek);
			if(startweek>0)
			{
				topview= [[CustomImageView alloc] initWithFrame:CGRectMake((iLoop*130) + 15, (startweek*60),120,11)];
				customeview= [[CustomImageView alloc] initWithFrame:CGRectMake((iLoop*130) + 15, (startweek*60)+11,120,((endweek-startweek)*60))];
				bottomview= [[CustomImageView alloc] initWithFrame:CGRectMake((iLoop*130) + 15,  (startweek*60)+11+(endweek-startweek)*60,120,11)];
				customeview.tag=newCounter;
				newCounter++;
				
				// [customeview setImage:[UIImage imageNamed:imagename]];
				[topview setImage:topImage];
				[customeview setImage:middleImage];
				[bottomview setImage:bottomImage];
				
				topview.backgroundColor=[UIColor clearColor];
				bottomview.backgroundColor=[UIColor clearColor];
				customeview.backgroundColor=[UIColor clearColor];
				
				[customeview setUserInteractionEnabled:YES];
				[customeview setDelegate:self];
				[customeview setLabelProperty];
				[customeview setEventData:event];
				[ImageBar setBackgroundColor:[UIColor clearColor]];
				[ImageBar addSubview:topview];
				[ImageBar addSubview:customeview];
				[ImageBar addSubview:bottomview];
				[customeview release];
			}
		}
		iLoop++;
		//newCounter++;
	}
	
	[eventNameDictWithArray release];
	[keyArray release];
	[super viewDidLoad];
}
/*
 - (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view;   // default returns YES
 - (BOOL)touchesShouldCancelInContentView:(UIView *)view; */



-(void) weeklabel
{
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormat setDateFormat:@"dd-MM-yyyy"];
	
	NSString *dateString = [dateFormat stringFromDate:today];
	NSArray *array = [dateString componentsSeparatedByString:@"-"];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *todayDay= [gregorian components:NSDayCalendarUnit fromDate:today];
	todayDay.day = 01;
	todayDay.month = 01;
	todayDay.year =[[array objectAtIndex:2] intValue];
	currentyear=todayDay.year;
	globaldate = [gregorian dateFromComponents:todayDay];
	int weekday=[self weekday:globaldate];
	todayDay.day = 01-weekday+2;
	globaldate = [gregorian dateFromComponents:todayDay];
	[gregorian release];
	startweek=[self weekno:globaldate and:today];
	globalweek=startweek;
	
	int localweek=startweek-26;
	if(localweek ==0)
	{
		localweek=52;
	}
	if(localweek <0)
	{
		localweek=localweek+51;
	}
	
	yearcounter=52-localweek+globalweek;
	[ImageBar setContentOffset:CGPointMake(0,yearcounter*60)];
	[WeekNoBar setContentOffset:CGPointMake(0,yearcounter*60)];
	static int i=1;
	for (i=1; i <= 78; i++) 
	{
		int j=60*i;
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.font = [UIFont boldSystemFontOfSize:14.0];
		NSString *aValue=[[NSNumber numberWithInt:localweek] stringValue];
		localweek=localweek+1;
		if(localweek>52)
		{
			localweek=1;
		}
		label.frame = CGRectMake(4,j, 20, 10);
		label.text=aValue;
		label.textColor=[UIColor blackColor];
		[label setBackgroundColor:[UIColor clearColor]];
		[WeekNoBar addSubview:label];
		[WeekNoBar setBackgroundColor:[UIColor clearColor]];
		[label release];
	}
}

-(NSDate *)stringToDate:(NSString *)stringDate{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];                      
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;
}

-(float)weekno:(NSDate *)from and:(NSDate *)end{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:NSDayCalendarUnit
												fromDate:from
												  toDate:end
												 options:0];
	NSInteger days = [components day];  
	days=days+1;
	[gregorian release];
	float weeknumber=(float)days/7+1;
	return weeknumber;
}


-(NSInteger )weekday:(NSDate *)from
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit fromDate:from];
	NSInteger weekdays = [components weekday]; 
	[gregorian release];
	weekdays=weekdays-1;
	return weekdays;
}


-(void) settings
{
	[WeekNoBar setUserInteractionEnabled:NO];
	WeekNoBar.pagingEnabled = NO;
	ImageBar.pagingEnabled = YES;
	WeekNoBar.bounces = NO;
	ImageBar.bounces=NO;
	WeekNoBar.delegate=self;
	ImageBar.delegate=self;
	
	[WeekNoBar setContentSize:CGSizeMake(40, 4750)];
	
	//[ImageBar setContentSize:CGSizeMake(([keyArray count]*133), 4750)];
	[ImageBar setContentSize:CGSizeMake((520), 4750)];
	[verticalstripImageView setBackgroundColor:[UIColor clearColor]];
	// verticalstripImageView.frame = CGRectMake(0, 0,([keyArray count]*133) , 4750);
	// [verticalstripImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"vertical_stips.png"]]];
	
	[LabelBar setContentSize:CGSizeMake(100, 40)];
	[LabelBar setUserInteractionEnabled:NO];
	WeekNoBar.showsHorizontalScrollIndicator = NO;
    WeekNoBar.showsVerticalScrollIndicator = NO;
	LabelBar.showsHorizontalScrollIndicator = NO;
    LabelBar.showsVerticalScrollIndicator = NO;
	//stripImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [keyArray count]*133, 4750)];
	stripImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 520, 4750)];
	[stripImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stips_new.png"]]];
	//[stripImageView setImage:[UIImage imageNamed:@"stips_new.png"]];
	[ImageBar addSubview:stripImageView];
	//[stripImageView setBackgroundColor:[UIColor clearColor]];
	[stripImageView release];
}

-(void)imagetouched:(int) tagid
{	
	CalendarEvent * calendarEventDetails = [calanderEventDetailsArray objectAtIndex:tagid];
	CalendarTouchEvent *eventDetailsScreen = [[CalendarTouchEvent alloc] initWithNibName:@"CalendarTouchEvent" bundle:[NSBundle mainBundle] details:calendarEventDetails];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:eventDetailsScreen];
	[self presentModalViewController:navController animated:YES];
	[navController release];
	[eventDetailsScreen release];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    startPos = scrollView.contentOffset;
	scrollView.directionalLockEnabled = YES;
	if(!scrollView.decelerating)
		scrollDirection=0;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
		scrollDirection=3;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if(scrollView == ImageBar)
	{
		if (scrollDirection==0)
		{
			//we need to determine direction
			//use the difference between positions to determine the direction.
			if (abs(startPos.x-ImageBar.contentOffset.x)<abs(startPos.y-ImageBar.contentOffset.y)){          
				NSLog(@"Vertical Scrolling");
				scrollDirection=1;
			} 
			else
			{
				NSLog(@"Horitonzal Scrolling");
				scrollDirection=2;
			}
		}
		//Update scroll position of the scrollview according to detected direction.     
		if (scrollDirection==1) 
		{
			//NSLog(@" Y ===== %f", ImageBar.contentOffset.y);
			[ImageBar setContentOffset:CGPointMake(startPos.x,ImageBar.contentOffset.y) animated:NO];
		} 
		else if (scrollDirection==2)
		{
			//NSLog(@" X ===== %f", ImageBar.contentOffset.x);
			[ImageBar setContentOffset:CGPointMake(ImageBar.contentOffset.x,startPos.y) animated:NO];
		}
		WeekNoBar.contentOffset=CGPointMake(0, ImageBar.contentOffset.y); 
		LabelBar.contentOffset=CGPointMake(ImageBar.contentOffset.x, 0);
		if(ImageBar.contentOffset.y<((yearcounter*60)-(globalweek*60)))
		{
			year.text=[NSString stringWithFormat:@"%d",currentyear-1];
		}
		if(ImageBar.contentOffset.y>((yearcounter*60)-(globalweek*60)))
		{
			year.text=[NSString stringWithFormat:@"%d",currentyear];
		}
		if(ImageBar.contentOffset.y>((yearcounter*60)-(globalweek*60))+(52-globalweek)*60)
		{
			year.text=[NSString stringWithFormat:@"%d",currentyear+1];
		}
    }
}

- (void ) createdatabase

{       
    
    CalendarEvent *eFocus=[[CalendarEvent alloc] init];
    
    eFocus.category=@"Focus";
    
    eFocus.Eventname=@"Precision";
    
    eFocus.StartDate=@"21-03-2011";
    
    eFocus.EndDate=@"04-04-2011";
    
    
    
    CalendarTouch *calendarTouch=[[CalendarTouch alloc] init];
    
    calendarTouch.eventname=@"Precision";
    
    
    
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"Prec1.png",@"Prec2.png", nil];
    
    calendarTouch.imageNameArray = imageArray;
    
    [imageArray release];
    
    
    
    NSArray *imageTitleArray = [[NSArray alloc] initWithObjects:@"Graphics Both",@"Graphics Men APP", nil];
    
    calendarTouch.imageTitleArray = imageTitleArray;
    
    [imageTitleArray release];
    
    
    
    NSArray *imageSizeLableArray = [[NSArray alloc] initWithObjects:@"210*320cm. 1pcs",@"70*150cm. 2pcs", nil];
    
    calendarTouch.imageSizeLableArray = imageSizeLableArray;
    
    [imageSizeLableArray release];
    
    
    
    calendarTouch.StartDate=@"21-03-2011";
    
    calendarTouch.EndDate=@"04-04-2011";
    
    calendarTouch.theme=@"Precision is focussing on our high quality garmets ";
    
    eFocus.calenderTouch = calendarTouch;
    
    
    
    [calanderEventDetailsArray addObject:eFocus ];
    
    
    
    [calendarTouch release];
    
    
    
    [eFocus release];
    
    
    
    /*************************SEASENAL********************************/
    
    CalendarEvent *eSeasonal=[[CalendarEvent alloc] init];
    
    eSeasonal.category=@"Seasonal";
    
    eSeasonal.Eventname=@"Go Contemporary";
    
    eSeasonal.StartDate=@"21-02-2011";
    
    eSeasonal.EndDate=@"28-02-2011";
    
    
    
    calendarTouch =[[CalendarTouch alloc] init];
    
    calendarTouch.eventname=@"Go Contemporary";
    
    
	imageArray = [[NSArray alloc] initWithObjects:@"Contemp1.png",@"Contemp2.png", nil];
    
    calendarTouch.imageNameArray = imageArray;
    
    [imageArray release];
    
    
    
    imageTitleArray = [[NSArray alloc] initWithObjects:@"B/W pullover details",@"B/W long hoodie", nil];
    
    calendarTouch.imageTitleArray = imageTitleArray;
    
    [imageTitleArray release];
    
    
    
    imageSizeLableArray = [[NSArray alloc] initWithObjects:@"210*320cm. 1pcs",@"70*150cm. 2pcs", nil];
    
    calendarTouch.imageSizeLableArray = imageSizeLableArray;
    
    [imageSizeLableArray release];
    
    
    
    
    calendarTouch.StartDate=@"21-02-2011";
    
    calendarTouch.EndDate=@"28-02-2011";
    
    calendarTouch.theme=@"Go Contemporary is the main direction of the brand  and points out the sustainability ";
    
    eSeasonal.calenderTouch = calendarTouch;
    
    
    
    [calanderEventDetailsArray addObject:eSeasonal ];
    
    
    
    [calendarTouch release];
    
    [eSeasonal release];
    
    
    
    /******** 2 ********/
    
    
    
    CalendarEvent *eSeasonalSecond =[[CalendarEvent alloc] init];
    
    eSeasonalSecond.category=@"Seasonal";
    
    eSeasonalSecond.Eventname=@"Go Versatile";
    
    eSeasonalSecond.StartDate=@"02-05-2011";
    
    eSeasonalSecond.EndDate=@"09-05-2011";
    
    
    
    
    calendarTouch=[[CalendarTouch alloc] init];
    
    
    
    calendarTouch.eventname=@"Go Versatile";
    
    
    
    imageArray = [[NSArray alloc] initWithObjects:@"Vers1.png",@"Vers2.png", nil];
    
    calendarTouch.imageNameArray = imageArray;
    
    [imageArray release];
    
    
    
    imageTitleArray = [[NSArray alloc] initWithObjects:@"Blouson Women",@"Striped Tee Men", nil];
    
    calendarTouch.imageTitleArray = imageTitleArray;
    
    [imageTitleArray release];
    
    
    
    imageSizeLableArray = [[NSArray alloc] initWithObjects:@"210*320cm. 1pcs",@"70*150cm. 2pcs", nil];
    
    calendarTouch.imageSizeLableArray = imageSizeLableArray;
    
    [imageSizeLableArray release];
    
    calendarTouch.StartDate=@"02-05-2011";
    
    calendarTouch.EndDate=@"09-05-2011";
    
    calendarTouch.theme=@"Go Versatile describes the collection and its infinite combinations of the products.";
    
    eSeasonalSecond.calenderTouch = calendarTouch;
    
    
    
    [calendarTouch release];          
    
    [calanderEventDetailsArray addObject:eSeasonalSecond ];
    
    [eSeasonalSecond release];
    
    
    
    /******** 3 ********/
    
    
    
    CalendarEvent *eSeasonalThird =[[CalendarEvent alloc] init];
    
    eSeasonalThird.category=@"Seasonal";
    
    
    
    
    eSeasonalThird.Eventname=@"Serenity";
    
    eSeasonalThird.StartDate=@"11-04-2011";
    
    eSeasonalThird.EndDate=@"18-04-2011";
    
    
    calendarTouch=[[CalendarTouch alloc] init];
    
    
    
    calendarTouch.eventname=@"Serenity";
    
    
    
    imageArray = [[NSArray alloc] initWithObjects:@"Seren1.png",@"Seren2.png", nil];
    
    calendarTouch.imageNameArray = imageArray;
    
    [imageArray release];
    
    
    
    imageTitleArray = [[NSArray alloc] initWithObjects:@"Focus shoes Women",@"Focus shoe U44202", nil];
    
    calendarTouch.imageTitleArray = imageTitleArray;
    
    [imageTitleArray release];
    
    
    
    imageSizeLableArray = [[NSArray alloc] initWithObjects:@"210*320cm. 1pcs",@"70*150cm. 2pcs", nil];
    
    calendarTouch.imageSizeLableArray = imageSizeLableArray;
    
    [imageSizeLableArray release];
    
    calendarTouch.StartDate=@"11-04-2011";
    
    calendarTouch.EndDate=@"18-04-2011";
    
    calendarTouch.theme=@"Spring´s focus lies on footwear and accessories ";
    
    eSeasonalThird.calenderTouch = calendarTouch;
    
    
    
    [calendarTouch release];          
    
    [calanderEventDetailsArray addObject:eSeasonalThird ];
    
    [eSeasonalThird release];
    
    
    
    
    
    /*********************************Promotional*********************************/
    
    CalendarEvent *e=[[CalendarEvent alloc] init];
    
    e.category=@"Promotional";
    
    e.Eventname=@"Dedication";
    
    e.StartDate=@"14-03-2011";
    
    e.EndDate=@"21-03-2011";
    
    
    
    calendarTouch=[[CalendarTouch alloc] init];
    
    
    
    calendarTouch.eventname=@"Dedication";
    
    imageArray = [[NSArray alloc] initWithObjects:@"Dedicat1.png",@"Dedicat2.png", nil];
    
    calendarTouch.imageNameArray = imageArray;
    
    [imageArray release];
    
    
    
    imageTitleArray = [[NSArray alloc] initWithObjects:@"Soccer top athlete",@"tennis top athlete", nil];
    
    calendarTouch.imageTitleArray = imageTitleArray;
    
    [imageTitleArray release];
    
    
    
    imageSizeLableArray = [[NSArray alloc] initWithObjects:@"210*320cm. 1pcs",@"70*150cm. 2pcs", nil];
    
    calendarTouch.imageSizeLableArray = imageSizeLableArray;
    
    [imageSizeLableArray release];    
    
    calendarTouch.StartDate=@"14-03-2011";
    
    calendarTouch.EndDate=@"21-03-2011";;
    
    calendarTouch.theme=@"Dedication is supported by world class athletes. ";
    
    e.calenderTouch = calendarTouch;
    
    
    
    [calanderEventDetailsArray addObject:e ];
    
    [calendarTouch release];
    
    [e release];
    
    
    
    
    
    
}






/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"CalendarScreen -------------------- Release");
	[WeekNoBar release];
	[ImageBar release];
	[LabelBar release];
	[calanderEventDetailsArray release];
	[stripImageView release];
	[imagename release];
	[globaldate release];
	
    [super dealloc];
}



@end



