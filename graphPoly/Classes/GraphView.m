//
//  GraphView.m
//  graphTest
//
//  Created by Yogesh Bhople on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "RawData.h"
#import <math.h>

const int bottonIndent = 100;
const int rightIndent = 30;

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

@implementation GraphView

@synthesize secondGraphArray;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		[self DrawBackground];
		[self DrawCountryName];
		[self DrawRating];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame graphdata:(NSMutableArray*) dataArray CountryName:(NSString*) cName Rating:(NSInteger) rating secongraph:(NSMutableArray*) secPointArray
{
	rawDataArray = dataArray;
	countryName = cName;
	countryRating = rating;
	
	secondGraphArray =  secPointArray;
//	limit = sizeof(secPointArray) /sizeof(secPointArray[0]);
//	NSString* logStr = [NSString stringWithFormat:@"LIMIT : %d",limit];
//	NSLog(@"%@",logStr);
	
//	for (int i=0; i<limit; i++) {
//		secondGraph[i] = secPointArray[i];
//	}

	
	return [self initWithFrame:frame];
	
}

#pragma mark Graph Functions non custom Drawing
-(void) DrawBackground
{
	self.backgroundColor = [UIColor grayColor];//[UIColor colorWithCGColor: graphBackgroundColor()];
}

-(void) DrawCountryName
{
	CGRect curRect = [self frame];
	int strX = 5;
	int strY = (curRect.origin.y+curRect.size.height) - 50;
	
	//CGRect countryNameLabelframe = CGRectMake(strX,strY, 100,25);
	
	CGRect countryNameLabelframe;	
	countryNameLabelframe.size = [self getSize:countryName];
	countryNameLabelframe.origin.x = strX;
	countryNameLabelframe.origin.y = strY;
	
	
	UILabel* countryLabel = [[UILabel alloc] initWithFrame:countryNameLabelframe];
	//Set Font
	//Set Color
	countryLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)];
	
	countryLabel.backgroundColor = [UIColor clearColor];
	
	countryLabel.textAlignment = UITextAlignmentCenter;
	
	countryLabel.textColor = [UIColor whiteColor];
	
	[countryLabel setText:countryName];
	
	
	[self addSubview:countryLabel];
	
	[countryLabel release];
}

- (CGSize) getSize:(NSString*) string
{
	CGSize constraintSize;
	constraintSize.width = self.frame.size.width+30;//260.0f;
	constraintSize.height = MAXFLOAT;
	
	return [string sizeWithFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
} 

-(void) DrawRating
{
	NSString* ratingImage = [NSString stringWithFormat:@"%d.png",countryRating];

	//NSLog(@"%@",ratingImage);
	
	CGRect curRect = [self frame];
	int strX =  (curRect.origin.x+curRect.size.width) - 110;
	int strY = (curRect.origin.y+curRect.size.height) - 50;
	
	UIImage* iconImage = [UIImage imageNamed:ratingImage];		
	UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(strX,strY, 100, 20)];			
	[imgView setImage:iconImage];			
	[self addSubview:imgView];			
	[imgView release];
}

#pragma mark Graph Functions with Custom Drawing



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	[self DrawGraphAxis:rect];	
	
}

									 
									 
-(void) DrawGraphAxis:(CGRect)rect
	{
		
//		CGSize offset;
//		float widthOfShadow = 80;
//		offset.width = 40;
//		offset.height = -40;		
		
		
		
		CGContextRef c = UIGraphicsGetCurrentContext();
		//CGContextSetShadow(c, offset, widthOfShadow);
		
		//CGContextSetShadowWithColor( c , offset , 40,CreateDeviceRGBColor(1.0, 0.5, 1.0, 1.0) );
		//Draw gridlines
		
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
		
		
		CGPoint startPosArray[5];
		
		//Draw Right Stars
		int noOfStars = 5;
		int starImageHeight = (rect.size.height - bottonIndent) / (noOfStars+1);
		int internalSpace = starImageHeight / (noOfStars+1);
		
		UIImage* iconImage = [UIImage imageNamed:@"star.png"];		
		UIImageView* imgView; 
		int startX = rect.size.width - rightIndent + 10 ;
		int startY = internalSpace ;
		for (int cnt = 0; cnt < 5; cnt++) {
			
			CGPoint point;
			point.x = startX;
			point.y = startY + (starImageHeight / 2);
			
			startPosArray[cnt] = point;
			
			imgView=[[UIImageView alloc]initWithFrame:CGRectMake(startX,startY, 20, starImageHeight)];			
			[imgView setImage:iconImage];			
			[self addSubview:imgView];			
			[imgView release];	
			
			startY = startY + starImageHeight + internalSpace;
		}
		
		CGPoint monthPosArray[6];		
		//Draw Months
		
		int noOfMonths = [rawDataArray count];
		
		
		float monthImageWidth = (rect.size.width - rightIndent) / (noOfMonths+1) ;
		//int lftIndent = 5;//(monthImageWidth/2);
		internalSpace = monthImageWidth / (noOfMonths+1);
		
		float xIncrement = (rect.size.width - rightIndent - internalSpace - (monthImageWidth/2)) / (noOfMonths);
		
//		UIImage* monthImage = [UIImage imageNamed:@"month.jpeg"]; //50x20		
		//UIImageView* imgView; 
		startX = internalSpace;//20 ;
		startY = rect.size.height - bottonIndent + 10 ;
		for (int cnt = 0; cnt < 6; cnt++) {
			
			CGPoint point;
			point.x = startX + (monthImageWidth/2) ;
			point.y = startY; 
			
			monthPosArray[cnt] = point;
						
//			imgView=[[UIImageView alloc]initWithFrame:CGRectMake(startX,startY, monthImageWidth, 20)];			
//			[imgView setImage:monthImage];			
//			[self addSubview:imgView];			
//			[imgView release];	
			
			
			NSString* monthName;
			switch (cnt) {
				case 0:
					monthName = @"Jan";
					break;
				case 1:
					monthName = @"Feb";
					break;
				case 2:
					monthName = @"Mar";
					break;
				case 3:
					monthName = @"Apr";
					break;
				case 4:
					monthName = @"May";
					break;
				case 5:
					monthName = @"Jun";
					break;	
				case 6:
					monthName = @"Jul";
					break;
				case 7:
					monthName = @"Aug";
					break;
				case 8:
					monthName = @"Sep";
					break;
				case 9:
					monthName = @"Oct";
					break;
				case 10:
					monthName = @"Nov";
					break;
				case 11:
					monthName = @"Dec";
					break;					
				default:
					break;
			}
			
			UILabel* monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX,startY, monthImageWidth, 20)];
			monthLabel.backgroundColor = [UIColor clearColor];			
			monthLabel.textAlignment = UITextAlignmentCenter;			
			monthLabel.textColor = [UIColor whiteColor];			
			[monthLabel setText:monthName];	
			monthLabel.font = [UIFont fontWithName:@"Arial" size:(15.0)];
			[self addSubview:monthLabel];
			
			[monthLabel release];
			
			//startX = startX + monthImageWidth/*Image width*/ + internalSpace /*Spacing*/;
			startX += xIncrement;
		}		
		
		[self CalculateActualPoints:monthPosArray starposition:startPosArray];
		
	}

- (void) CalculateActualPoints:(CGPoint[]) monthImagePosArray starposition:(CGPoint[]) starImagePosArray
{
//	CGContextRef c = UIGraphicsGetCurrentContext();	
//	CGContextSetStrokeColorWithColor(c,[[UIColor yellowColor] CGColor]);
//	for (int cnt = 0; cnt < 6; cnt++) {
//
//		CGContextBeginPath(c);
//		CGContextMoveToPoint(c, monthImagePosArray[cnt].x,0);
//		CGContextAddLineToPoint(c, monthImagePosArray[cnt].x,monthImagePosArray[cnt].y);
//		CGContextStrokePath(c);	
//				
//	}
//	
//	CGContextSetStrokeColorWithColor(c,[[UIColor greenColor] CGColor]);
//	for (int cnt=0; cnt < 5; cnt++) {
//		
//		CGContextBeginPath(c);
//		CGContextMoveToPoint(c, 0,starImagePosArray[cnt].y);
//		CGContextAddLineToPoint(c, starImagePosArray[cnt].x,starImagePosArray[cnt].y);
//		CGContextStrokePath(c);
//	}
	
	CGPoint actualpointsArray[24];
	int noOfMonths = [rawDataArray count];
	
	int inernalSpacing = (monthImagePosArray[1].x - monthImagePosArray[0].x)/4 ;
	int faction = fmod((monthImagePosArray[1].x - monthImagePosArray[0].x), 4);
	if (faction > 0) {
		inernalSpacing++;
	}
	NSLog(@"Firsr X: %f",monthImagePosArray[1].x);
	NSLog(@"Second X: %f",monthImagePosArray[0].x);
	NSLog(@"Internal Spacing: %d",inernalSpacing);
	
	int actCounter = 0;
	
	for (int cnt = 0; cnt<noOfMonths; cnt++) {
		
		RawData* obj = [rawDataArray objectAtIndex:cnt];
		int weekCount = [obj.weekRatingData count];
		int startXpos = monthImagePosArray[cnt].x;
		
		for (int counter = 0; counter < weekCount; counter++) {
			CGPoint point;
			point.x = startXpos;
			int rating = [[obj.weekRatingData objectAtIndex:counter]intValue];
			//rating--;//because array index is starts from zero and rating starts from one
			rating = 5 - rating; 
			point.y =	starImagePosArray[rating].y;
			actualpointsArray[actCounter++] = point;
			startXpos = startXpos + inernalSpacing;
			}
			
		}
	actCounter = actCounter -1;
	actualpointsArray[actCounter].x = 	actualpointsArray[actCounter].x + inernalSpacing;

	[self DrawGraph:actualpointsArray graphcolor:[UIColor whiteColor]];
	
	
	
	////////////////////////////SECOND GRAPH/////////////////////////
	CGPoint actualpointsArray1[24];
	int arrCnt = 0;
	for (int cnt = 0; cnt<noOfMonths; cnt++) {
		
//		RawData* obj = [rawDataArray objectAtIndex:cnt];
//		int weekCount = [obj.weekRatingData count];
		int startXpos = monthImagePosArray[cnt].x;
		
		for (int counter = 0; counter < 4; counter++) {
			CGPoint point;
			point.x = startXpos;
			int rating = [[secondGraphArray objectAtIndex:arrCnt]intValue];
			//rating--;//because array index is starts from zero and rating starts from one
			rating = 5 - rating; 
			point.y =	starImagePosArray[rating].y;
			actualpointsArray1[arrCnt++] = point;
			startXpos = startXpos + inernalSpacing;
			NSLog(@"Internal Spacin%d %d",rating,arrCnt);
		}
		
	}	
	arrCnt = arrCnt -1;
	actualpointsArray1[arrCnt].x = 	actualpointsArray1[arrCnt].x + inernalSpacing;
	
	
	
//	CGPoint actualpointsArray1[24];
//	noOfMonths = [secondGraphArray count];
//	//NSLog(@"LIMIT : %d",noOfMonths);
//	int startXpos = monthImagePosArray[0].x;
//		for (int counter = 0; counter < noOfMonths; counter++) {
//			CGPoint point;
//			point.x = startXpos;
//			int rating = [[secondGraphArray objectAtIndex:counter]intValue];
//			//rating--;//because array index is starts from zero and rating starts from one
//			rating = 5 - rating; 
//			point.y =	starImagePosArray[rating].y;
//			actualpointsArray1[counter] = point;
//			startXpos = startXpos + inernalSpacing;
//			NSLog(@"Internal Spacin%d",inernalSpacing);
//		}
	[self DrawGraph:actualpointsArray1 graphcolor:[UIColor blueColor]];
	
	
	[self DrawGraphShadow:actualpointsArray shadowcolor:[UIColor purpleColor]];
	[self DrawGraphShadow:actualpointsArray1 shadowcolor:[UIColor purpleColor]];
	
}

-(void) DrawGraphShadow:(CGPoint[]) graphPosArray shadowcolor:(UIColor*) color
{
	self.backgroundColor = [UIColor yellowColor];
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (flg !=1) {
		CGContextSetRGBFillColor(context, 255,255,255, 0.3);
		//CGContextSetRGBStrokeColor(context, 0, 0, 255, 0.1);
		flg = 1;
	}else {
		CGContextSetRGBFillColor(context, 0, 200, 150, 0.4);
		//CGContextSetRGBStrokeColor(context, 255, 255, 0, 0.1);
	}

	

	//CGContextBeginPath(context);
	CGContextFillPath(context);
	CGContextMoveToPoint(context,graphPosArray[0].x, xAxisYpos);
	
	for (NSUInteger i = 0; i < 24; i++) {
		CGContextAddLineToPoint(context, graphPosArray[i].x, graphPosArray[i].y);
	}
	CGContextAddLineToPoint(context,graphPosArray[23].x, xAxisYpos);	
	CGContextEOFillPath(context);
	//CGContextClosePath(context);
	CGContextSetLineWidth(context, 5.0);
	CGContextStrokePath(context); 
}
									 
-(void) DrawGraph:(CGPoint[]) graphPosArray graphcolor:(UIColor*) color
	{
		CGContextRef c = UIGraphicsGetCurrentContext();
		CGContextSetLineWidth(c, 2);
		//[c LineWidth = 5;
		
//		CGSize offset;
//		float blur;
//		offset.width = 0;
//		offset.height = 2;
//		
//		CGContextSetShadow(c, offset, 2);//blur);//10);
		
	
	//	CGContextSetStrokeColorWithColor(c,[[UIColor whiteColor] CGColor]);
		CGContextSetStrokeColorWithColor(c,[color CGColor] );

		CGContextBeginPath(c);
		CGContextMoveToPoint(c, graphPosArray[0].x,graphPosArray[0].y);

		
		for (int cnt=1; cnt < 24; cnt++) {
			CGContextAddLineToPoint(c, graphPosArray[cnt].x,graphPosArray[cnt].y);
			
		}
		
		
		CGContextStrokePath(c);
		
		
		
		CGContextSetRGBFillColor(c, 0, 0, 255, 0.1);
		CGContextSetRGBStrokeColor(c, 0, 0, 255, 0.5);
//		//		
//		// Draw a circle (filled)
//		CGContextFillEllipseInRect(c, CGRectMake(100, 100, 25, 25));		
//		// Draw a circle (border only)
//		CGContextStrokeEllipseInRect(c, CGRectMake(100, 100, 25, 25));
//		
//		for (int cnt=0; cnt < 24; cnt++) {			
//			CGContextFillEllipseInRect(c, CGRectMake(graphPosArray[cnt].x-2,graphPosArray[cnt].y-2, 4, 4));		
//			CGContextStrokeEllipseInRect(c, CGRectMake(graphPosArray[cnt].x-2,graphPosArray[cnt].y-2, 4, 4));
//		}
		
		
		/////////////////////////////////////////////////////////////////////

		
		
	}

//- DrawShadow:(CGPoint) sPoint endpoint:(CGPoint) ePoint ylimit:(int) yValue
//{
//	CGContextRef c = UIGraphicsGetCurrentContext();
//	CGContextSetRGBFillColor(c, 0, 0, 255, 0.1);
//	CGContextSetRGBStrokeColor(c, 0, 0, 255, 0.5);
//	
//	
//	
//	for (int cnt = sPoint; cnt <= ePoint; cnt++) {
//		
//		CGContextBeginPath(c);
//		CGContextMoveToPoint(c, cnt,graphPosArray[0].y);		
//		CGContextAddLineToPoint(c, graphPosArray[cnt].x,graphPosArray[cnt].y);
//		CGContextStrokePath(c);
//		
//	}
//	
//}

- (void)dealloc {
	[rawDataArray release];
    [super dealloc];
}


@end
