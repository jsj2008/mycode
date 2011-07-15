//
//  GraphView.m
//  iJumpPrototype
//
//  Created by Seb Kade on 6/05/10.
//  Copyright 2010 SKADE Development. All rights reserved.
//


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

#import "GraphView.h"


@implementation GraphView

float myWidth;
int arrayCount = 1600;
float yValues[1600];
int pointCount;
BOOL drawData;
float startXPoint, endXPoint, pixelOffset;
int multiplier;
NSString *axisLabel;


/*
- (id)init;
{
    if ((self = [super init])) {
        // Initialization code
		//CGFloat colorGrey = 0.7;
		self.backgroundColor = [UIColor colorWithCGColor: graphBackgroundColor()];

		
		[self setFrame:CGRectMake(0, 0, myWidth, 100)];
		
		[self setBounds:CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height)];  
						
		pointCount = 0;
		pixelOffset = 0;
		drawData = FALSE;
    }
    return self;
}
*/

- (id)initWithFrame:(CGRect)frame;
{
    if ((self = [super initWithFrame:frame])) 
	{
        // Initialization code
		self.backgroundColor = [UIColor colorWithCGColor: graphBackgroundColor()];
		
		// myWidth is a variable that is used throughout this class which tells me how wide the view is and thus how 
		// may data items can be shown as each data item takes up one pixel of width.
		myWidth = CGRectGetWidth(frame);
		
		//IMPORTANT The first two arguments here where the origin of the raoh is. Here i set the origin of the view to the verticle center of the view. 
		// The second two arguments are the rectangular size of the view.
		[self setBounds:CGRectMake(0, -self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height)]; 
		
		//set various varibles to starting values
		pointCount = 0;
		drawData = FALSE;
		multiplier = 10;
		pixelOffset = 0;
		[self createTestData];
	}
    return self;
}


//creates a random number.  From this number chooses whenther to add or subtract 0.1 to the last value.
-(void) createTestData;
{
	for (int i = 0; i < arrayCount; i++) {
		if ((arc4random() % 2) == 1)
		{
			yValues[i] = yValues[i-1] + 0.1;
		} else {
			yValues[i] = yValues[i-1] - 0.1;
		}
		
		pointCount = myWidth;
	}
	
	//calls the function which tells the view to draw the da[ta.
	[self collectionFinished];
}

//Not used in this example but can be used to add points to the data source from an external view controller
-(void) addPoint:(float )point;
{
	if (pointCount < myWidth) {
		yValues[pointCount] = point;
		pointCount++;
		
	}
}

-(void) reset;
{
	pointCount = 0;
}

//tells the view to draw the data
-(void) collectionFinished;
{
	drawData = TRUE;
	[self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
	// Drawing code
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	//create color arrays
	//CGFloat grey[4] = {0.23f, 0.23f, 0.23f, 1.0f};
	//CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
	
	
	//Draw gridlines
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, 0, 0.3);
	CGContextAddLineToPoint(c, myWidth, 0.3);//for first time
	CGContextStrokePath(c);
	
    for (int i = 10; i < self.bounds.size.height / 2; i+= multiplier) {
		CGContextSetStrokeColorWithColor(c, graphLineColor());
		CGContextMoveToPoint(c, 0, i + 0.5);
		CGContextAddLineToPoint(c, myWidth, i + 0.5);
		CGContextStrokePath(c);
		
		CGContextMoveToPoint(c, 0, -i + 0.5);
		CGContextAddLineToPoint(c, myWidth, -i + 0.5);
		CGContextStrokePath(c);
	}
	
	//draw data
	if (drawData){
		int dataIndex = pixelOffset;
		for (int i =1; i < pointCount; i++){
			CGContextSetStrokeColorWithColor(c, graphYColor());
			CGContextMoveToPoint(c, (i -1), yValues[dataIndex - 1] * multiplier);
			CGContextAddLineToPoint(c, i, yValues[dataIndex] * multiplier);
			CGContextStrokePath(c);
			dataIndex++;
		}
	} 
	
	
    
	//Draw Axis numbers
	int numOfLines = self.bounds.size.height / 10;
	for (int i = 0  ;  i < (numOfLines / 2) ; i++) {
		//Positive Numbers
		[[NSString stringWithFormat:@"%i",-i] drawInRect:CGRectMake(0, i * multiplier - 5, 20, multiplier) 
											   withFont:[UIFont systemFontOfSize:10] 
										  lineBreakMode:UILineBreakModeWordWrap 
											  alignment:UITextAlignmentRight];
		//negajtive numbers
		[[NSString stringWithFormat:@"%i",i] drawInRect:CGRectMake(0, -i * multiplier - 5, 20, multiplier) 
											   withFont:[UIFont systemFontOfSize:10] 
										  lineBreakMode:UILineBreakModeWordWrap 
											  alignment:UITextAlignmentRight];
	}
	
	
	
}

#pragma mark -
#pragma mark  Navigatation of GraphView

//This section gets the location of the first touch, then calculates the horizontal distance every time the user
//moves their finger. This horizontal distance is used to scroll the graph left and right.


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	UITouch *touch = [touches anyObject];
	
	CGPoint touchPoint = [touch locationInView:self];
	
	startXPoint = touchPoint.x;
	
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
	UITouch *touch = [touches anyObject];
	
	CGPoint touchPoint = [touch locationInView:self];
	
	endXPoint = touchPoint.x;
	
	[self calculateDistance];
	
	startXPoint = endXPoint;
	
}

-(void) calculateDistance;
{	
	float tempPixelOffset = pixelOffset + (int)(startXPoint - endXPoint);
	if ((tempPixelOffset > 0) && arrayCount - tempPixelOffset > self.bounds.size.width) 
	{
		pixelOffset = tempPixelOffset;
	} 
	else if (tempPixelOffset < 0)
	{
		pixelOffset = 0;
	} else if (arrayCount - tempPixelOffset < self.bounds.size.width)
	{
		pixelOffset = arrayCount - self.bounds.size.width;		
	}
	
	
	[self setNeedsDisplay];
}





- (void)dealloc {
    [super dealloc];
}


@end
