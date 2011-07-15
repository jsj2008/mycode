//
//  Graph.m
//  Graph_week
//
//  Created by sujeet on 12/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Graph.h"

const int bottonIndent = 60;
const int rightIndent = 30;
const int monthLeftIndent = 10;
const int graphIndent = 10;
#pragma mark CG Helpers
CGColorRef CreateDeviceGrayColor(CGFloat w, CGFloat a)
{
	CGColorSpaceRef gray = CGColorSpaceCreateDeviceGray();
	CGFloat comps[] = {w, a};
	CGColorRef color = CGColorCreate(gray, comps);
	CGColorSpaceRelease(gray);
	return color;
}

CGColorRef graphBackgroundColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.6, 1.0);
	}
	return c;
}

CGColorRef graphLineColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.5, 1.0);
	}
	return c;
}

CGColorRef CreateDeviceRGBColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat comps[] = {r, g, b, a};
	CGColorRef color = CGColorCreate(rgb, comps);
	CGColorSpaceRelease(rgb);
	return color;
}

CGColorRef graphYColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceRGBColor(1.0, 0.0, 0.0, 1.0);
	}
	return c;
}

@implementation Graph

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		[self DrawBackground];
	
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame WithStore:(StoreInfo *)mystore AndSelectedStore:(StoreInfo *)selectedstore
{
    
	self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		storeName = [mystore store_name];
		storeRating = [mystore avgRating];
		
		myStore = mystore;	
		selectedStore = selectedstore;
    }
	return [self initWithFrame:frame];
}

#pragma mark Graph Functions non custom Drawing
-(void) DrawBackground
{
	self.backgroundColor = [UIColor colorWithCGColor: graphBackgroundColor()];//[UIColor grayColor]; //[UIColor colorWithCGColor: graphBackgroundColor()];
}

-(void) DrawStoreName
{
	CGRect curRect = [self frame];
	int strX = 15;
	int strY = (curRect.origin.y+curRect.size.height) - bottonIndent +30;

	CGRect storeNameLabelframe;	
	storeNameLabelframe.size = [self getSize:storeName];
	storeNameLabelframe.origin.x = strX;
	storeNameLabelframe.origin.y = strY;

	UILabel* storeNameLabel = [[UILabel alloc] initWithFrame:storeNameLabelframe];

	storeNameLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)];
	
	storeNameLabel.backgroundColor = [UIColor clearColor];
	
	storeNameLabel.textAlignment = UITextAlignmentCenter;
	
	storeNameLabel.textColor = [UIColor whiteColor];
	
	[storeNameLabel setText:storeName];
	
	
	[self addSubview:storeNameLabel];
	
	[storeNameLabel release];
}

- (CGSize) getSize:(NSString*) string
{
	CGSize constraintSize;
	constraintSize.width = self.frame.size.width+30;//260.0f;
	constraintSize.height = MAXFLOAT;	//#define in math.h
	
	return [string sizeWithFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
} 


-(void) DrawRating
{
	
	NSString* ratingImage = [NSString stringWithFormat:@"%dstars.png",[storeRating intValue]];
	CGRect curRect = [self frame];
	int strX =  (curRect.origin.x+curRect.size.width) - 115;
	int strY = (curRect.origin.y+curRect.size.height) - bottonIndent +34;
	
	UIImage* iconImage = [UIImage imageNamed:ratingImage];		
	UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(strX,strY, 84, 16)];			
	[imgView setImage:iconImage];			
	[self addSubview:imgView];			
	[imgView release];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	
	//NSLog(@"Start Draw View");
	[self DrawGraphAxis:rect];
	//NSLog(@"End Draw View");
	
}

-(void) DrawGraphAxis:(CGRect)rect
{
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(c,[[UIColor whiteColor] CGColor]);
	
	//X - Line
	xAxisYpos = rect.size.height - bottonIndent;
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, 0,rect.size.height - bottonIndent);
	CGContextAddLineToPoint(c, rect.size.width,rect.size.height - bottonIndent);
	CGContextStrokePath(c);
	
	//Y - Line
	CGContextBeginPath(c);
	
	CGContextMoveToPoint(c, rect.size.width - rightIndent,0);
	CGContextAddLineToPoint(c, rect.size.width - rightIndent,rect.size.height - bottonIndent);
	CGContextStrokePath(c);
	
	//Draw Right rating Stars
	CGPoint starPosArray[5];
	int noOfStars = 5;
	int starImageHeight = (rect.size.height - bottonIndent -10) / (noOfStars+1);
	int internalSpace = starImageHeight / (noOfStars+1);	//distance bw star img
	
	UIImage* iconImage = [UIImage imageNamed:@"star.png"];		
	UIImageView* imgView; 
	int startX = rect.size.width - rightIndent + 5 ;
	int startY = internalSpace +15;
	
	for (int cnt = 4; cnt >= 0; cnt--) {
		
		CGPoint point;
		point.x = startX;
		point.y = startY + (starImageHeight / 2);
		
		starPosArray[cnt] = point;
		
		imgView=[[UIImageView alloc]initWithFrame:CGRectMake(startX,startY, iconImage.size.width, iconImage.size.height)];			
		[imgView setImage:iconImage];			
		[self addSubview:imgView];			
		[imgView release];	
		
		startY = startY + starImageHeight + internalSpace;
	}
	
	NSMutableArray *myStoreKey = [[NSMutableArray alloc] initWithArray:[myStore.ratingPerWeek allKeys]];
	
	[myStoreKey sortUsingSelector: @selector(compare:)];  //sorting the key
	//NSLog(@"key array =%@",myStoreKey);
	
	
	int myStoreKeyMax = 26;//[[myStoreKey valueForKeyPath:@"@max.intValue"] intValue];
	int myStoreKeyMin = 0;//[[myStoreKey valueForKeyPath:@"@min.intValue"] intValue];
	
	NSMutableArray * selectedStoreKey = [[NSMutableArray alloc]initWithArray:[selectedStore.ratingPerWeek allKeys ]];
	[selectedStoreKey sortUsingSelector: @selector(compare:)];	//sorting the key
	int selectedStoreKeyMax = 26;//[[selectedStoreKey valueForKeyPath:@"@max.intValue"] intValue];	//to the max value in array of nsnumber
	int selectedStoreKeymin = 0;//[[selectedStoreKey valueForKeyPath:@"@min.intValue"] intValue];
	
	//NSLog(@"selectedStoreKeymin %d selectedStoreKeyMax = %d mysortedkey =%@",selectedStoreKeymin,selectedStoreKeyMax,myStoreKey	);
	
	int x;BOOL flag;
	
	
		x = 0;
		flag = NO;
	
	CGPoint monthPosArray[6];	
	
	int noOfMonths = 6;//only show six month at a time
	float monthImageWidth = (rect.size.width - rightIndent - monthLeftIndent+10) / (noOfMonths) ;
	startX = monthLeftIndent ;		//set the start of month x pos
	startY = rect.size.height - bottonIndent ;
	
	for (int cnt = 0; cnt < 6; cnt++) {
		
		CGPoint point;
		point.x = startX + (monthImageWidth * cnt) ;
		point.y = startY; 
		
		monthPosArray[cnt] = point;
		
		

		NSString* monthName;
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"MMM"];
	     NSMutableArray *montharray=[[NSMutableArray alloc]init];
   

		
	
		NSDate *today = [[NSDate alloc] init];
		for(int i=1;i<=6;i++)
		{
		NSString *month = [dateFormatter stringFromDate:today];
		
		[montharray addObject:month];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
		[offsetComponents setMonth:-1]; // note that I'm setting it to -1
		today = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
		}
		//NSLog(@"month array =%@",montharray);		
		int count=[montharray count];
		
		switch (x) 
		{
			case 0:
				monthName = [montharray objectAtIndex:count-1];
				break;
			case 1:
				monthName = [montharray objectAtIndex:count-2];
				break;
			case 2:
				monthName = [montharray objectAtIndex:count-3];
				break;
			case 3:
				monthName = [montharray objectAtIndex:count-4];
				break;
			case 4:
				monthName =[montharray objectAtIndex:count-5];
				break;
			case 5:
				monthName = [montharray objectAtIndex:count-6];
				break;	
			default:
				break;
		}
		


		
		UILabel* monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(point.x,point.y, monthImageWidth, 20)];
		monthLabel.backgroundColor = [UIColor clearColor];			
		monthLabel.textAlignment = UITextAlignmentLeft;			
		monthLabel.textColor = [UIColor whiteColor];			
		[monthLabel setText:monthName];	
		monthLabel.font = [UIFont fontWithName:@"Arial" size:(15.0)];
		[self addSubview:monthLabel];
		
		[monthLabel release];
		
		x++;
	}
	
	//------------------draw graph-----------------------------
	int xunit = (rect.size.width - rightIndent - monthLeftIndent) / 26;		//no of week =26 no of div reqired 25 
	//-10 the start pos of month
	
	//CGpoints for the mystore
	int pointsInMyStore = [myStoreKey count];
	
	CGPoint MYStorePoints[pointsInMyStore];
	startX = monthLeftIndent + graphIndent + (myStoreKeyMin) * xunit;
	
	int controlweek = 0;			//setting the controll week//to set the start in week
	if (myStoreKeyMax > 26 && flag) {
		controlweek = 26;
		startX = monthLeftIndent;
	}
	
	int iloop = 0;
	for (int i = controlweek; i < pointsInMyStore; i++) {	 //keys has been sorted
		if (iloop > 26) {
			break;
		}
		CGPoint point;
		point.x = startX + xunit*iloop;
		CGPoint test = starPosArray[ ([[myStore.ratingPerWeek objectForKey:[myStoreKey objectAtIndex:i]] intValue])-1 ];
		point.y = test.y;
		
		MYStorePoints[iloop] = point; iloop++;
	}
	
	UIColor *selectedColorWhite = [UIColor colorWithRed:(255/255) green:(255/255) blue:(255/255) alpha:0.7f];
	[self DrawGraphSecond:MYStorePoints graphcolor:selectedColorWhite withCount:iloop];
	[self DrawGraphWithGradent:MYStorePoints graphcolor:[UIColor whiteColor] colorCh:2 withCount:iloop];
	
	//CGpoints for the selecteStore
	int pointsInSelectedStore = [selectedStoreKey count];
	CGPoint selectedStorePoints[pointsInSelectedStore];
	startX = monthLeftIndent + graphIndent +(selectedStoreKeymin) * xunit;
	
	controlweek = 0;
	if (selectedStoreKeyMax > 26 && flag) {
		controlweek = 26;
		startX = monthLeftIndent;
	}
	
	iloop = 0;
	for (int i = controlweek; i < pointsInSelectedStore; i++) {
		if (iloop > 26) {
			break;
		}
		CGPoint point;
		point.x = startX +xunit*iloop;
		
		CGPoint test = starPosArray[ ([[selectedStore.ratingPerWeek objectForKey:[selectedStoreKey objectAtIndex:i]] intValue])-1 ];
		point.y = test.y;
		//NSLog(@"y value slectedstore= %f",point.y);
		selectedStorePoints[iloop] = point; iloop++;
	}
	
	UIColor *selectedColor = [UIColor colorWithRed:(255/255) green:(255/255) blue:(255/255) alpha:0.5f];
	int colorchoice = 2;
	if ( !(myStore == selectedStore)) 
	{
		//selectedColor = [UIColor redColor];
		selectedColor = [UIColor colorWithRed:(215/255) green:(255/255) blue:(255/255) alpha:0.5f];
		//selectedColor = [UIColor colorWithRed:(0/255) green:(255/255) blue:(212/255) alpha:0.5f];
		colorchoice = 1;
	}
	
	[selectedStoreKey release];
	[myStoreKey release];
	
	[self DrawGraphSecond:selectedStorePoints graphcolor:selectedColor withCount:iloop];
	[self DrawGraphWithGradent:selectedStorePoints graphcolor:selectedColor colorCh:colorchoice withCount:iloop];}	

-(void) DrawGraphSecond:(CGPoint[]) graphPosArray graphcolor:(UIColor*) color withCount:(int)count
{
	//NSLog(@"drawing");
	
	CGContextRef context = UIGraphicsGetCurrentContext();	
	CGContextSetLineWidth(context, 3);
	CGContextSetStrokeColorWithColor(context,[color CGColor] );
	
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, graphPosArray[0].x,graphPosArray[0].y);
	
	
	for (int cnt=1; cnt < count; cnt++) {
		CGContextAddLineToPoint(context, graphPosArray[cnt].x,graphPosArray[cnt].y);
		
	}
	
	CGContextStrokePath(context);
	
}

-(void) DrawGraphWithGradent:(CGPoint[]) graphPosArray graphcolor:(UIColor*) color colorCh:(int) selectedColor  withCount:(int)count
{
	
	CGGradientRef gradient;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();


	CGFloat colors[] =
	{
		82 / 255.0, 216.0 / 255.0, 255.0 / 255.0, 0.03,
		117.0 / 255.0, 214.0 / 255.0, 255.0 / 255.0, 0.03,
		0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
	};
	
	CGFloat colors1[] =
	{
		230.0 / 255.0, 230.0 / 255.0, 255.0 / 255.0, 0.03,
		150.0 / 255.0, 150.0 / 255.0, 150.0 / 255.0, 0.03,
		170.0 / 255.0,  170.0 / 255.0, 170.0 / 255.0, 1.30,
	};
	
	if(selectedColor == 1){
		gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	}else {
		gradient = CGGradientCreateWithColorComponents(rgb, colors1, NULL, sizeof(colors1)/(sizeof(colors1[0])*4));
	}
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState (context);
	
	CGContextSetLineWidth(context, 2);
	CGContextSetStrokeColorWithColor(context,[color CGColor] );
	
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, graphPosArray[0].x,graphPosArray[0].y);
	
	
	for (int cnt=1; cnt < count ; cnt++) {
		CGContextAddLineToPoint(context, graphPosArray[cnt].x,graphPosArray[cnt].y);
		
	}
	
	CGContextAddLineToPoint(context,graphPosArray[count -1].x, xAxisYpos);
	CGContextAddLineToPoint(context, graphPosArray[0].x,xAxisYpos);
	CGContextClosePath (context);
	CGContextClip(context);
	//CGContextSetRGBFillColor(context, 255,255,255, 0.3);
	CGContextDrawLinearGradient(context, gradient,  CGPointMake(0, 240), CGPointMake(0, 0), 0);
	CGContextDrawPath(context, kCGPathFillStroke);
	
	CGContextRestoreGState (context);
	//CGContextStrokePath(context);
	CGColorSpaceRelease(rgb);
	CGGradientRelease(gradient);
	
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

- (void)dealloc {
	NSLog(@"Graph----------------Release");
	[storeName release];
	[storeRating release];
	//[myStore release];
    [super dealloc];
}


@end
