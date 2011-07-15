//
//  CallOutView.m
//  CallOutView
//


#import "CallOutView.h"

@interface CallOutView()
	-(void) initialize;
	-(void) setAnchorPoint:(CGPoint)pt;
	-(void) addButtonTarget:(id)target action:(SEL)selector;
	-(void) showWithAnimiation:(UIView*)parent;
@end


@implementation CallOutView
@synthesize text;



#define CENTER_IMAGE_WIDTH  31
#define CALLOUT_HEIGHT  120
#define MIN_LEFT_IMAGE_WIDTH  20
#define MIN_RIGHT_IMAGE_WIDTH  80
#define CENTER_IMAGE_ANCHOR_OFFSET_X  15
#define MIN_ANCHOR_X  MIN_LEFT_IMAGE_WIDTH + CENTER_IMAGE_ANCHOR_OFFSET_X
#define BUTTON_WIDTH  29
#define BUTTON_Y  10
#define LABEL_HEIGHT  48
#define LABEL_FONT_SIZE  18


#pragma mark - Comment this will set the anchor point Y position from the click
#define ANCHOR_Y  120


#define RECTFRAME CGRectMake (0, 0, 300, CALLOUT_HEIGHT)

static UIImage *CALLOUT_LEFT_IMAGE;

static UIImage *CALLOUT_CENTER_IMAGE;
static UIImage *CALLOUT_RIGHT_IMAGE;

#pragma mark -
#pragma mark Comment -- By setting this value we can move the anchor point to middle or right or left
#pragma mark left = 32 middle = 100 and right = 160

float ANCHOR_X = 160;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self initialize];
	
    }
    return self;
}

-(id)initWithText:(NSString*)atext point:(CGPoint)point
{
	if (self = [super initWithFrame:RECTFRAME]) {
		[self setAnchorPoint:point];
		[self initialize];
		self.text = atext;
	}	
	return self;
}

-(id)initWithProduct:(Product*)product point:(CGPoint)point target:(id)object action:(SEL)selector
{
	if (self = [super initWithFrame:RECTFRAME]) {
		[self setAnchorPoint:point];
		[self initialize];
		//self.text = atext;
		calloutLabel.text = product.productName;
		calloutLabel1.text = product.productCode;
		calloutLabel2.text = [NSString stringWithFormat:@"Quantity : %d", product.quantity];
		[self addButtonTarget:object action:selector];
		
		NSString *newPath = [NSString stringWithFormat:@"Documents/%@_thumnail.png",product.productCode];
		
		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	
		UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngPath];
		[calloutImage setImage:img];
		[img release];

		
	}	
	return self;
}


+ (CallOutView*) addCalloutView:(UIView*)parent product:(Product*)product point:(CGPoint)pt target:(id)target action:(SEL)selector
{
	NSLog(@"CallOut Points  ==== %f %f", pt.x, pt.y);
	CallOutView *callout = [[CallOutView alloc] initWithProduct:product point:pt target:target action:selector];
	[callout showWithAnimiation:parent];
	return [callout autorelease];
	return nil;
}


-(void) showWithAnimiation:(UIView*)parent
{
	self.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationWillStartSelector:@selector(animationWillStart:context:)];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView setAnimationDuration:0.1f];
	[parent addSubview:self];
	self.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
	[UIView commitAnimations];
}

- (void)animationWillStart:(NSString *)animationID context:(void *)context
{
	
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	self.transform = CGAffineTransformIdentity;	
}

-(void)setText:(NSString *)aText{
	calloutLabel.text = aText;
	[calloutLabel setNeedsLayout];
}


- (void) initialize
{
	NSLog(@"in initialize");
	self.backgroundColor = [UIColor clearColor];
	self.opaque = false;
	
	if (CALLOUT_LEFT_IMAGE == nil) {
		CALLOUT_LEFT_IMAGE = [[[UIImage imageNamed:@"callout_left.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0] retain];
	}
	
	if (CALLOUT_CENTER_IMAGE == nil) {
		CALLOUT_CENTER_IMAGE = [[UIImage imageNamed:@"callout_center.png"] retain];
	}
	
	if (CALLOUT_RIGHT_IMAGE == nil) {
		CALLOUT_RIGHT_IMAGE = [[[UIImage imageNamed:@"callout_right.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0] retain];
	}

	CGRect frame = self.frame;
	frame.size.height = CALLOUT_HEIGHT;
	if (frame.size.width < 100)
		frame.size.width = 100;
	self.frame = frame;
	
	if (ANCHOR_X < MIN_ANCHOR_X) {
		ANCHOR_X = MIN_ANCHOR_X;
	}


	calloutLeft = [[UIImageView alloc] init];
	calloutLeft.image = CALLOUT_LEFT_IMAGE;
	[self addSubview:calloutLeft];
	[calloutLeft release];
	
	calloutCenter = [[UIImageView alloc] init];
	calloutCenter.image = CALLOUT_CENTER_IMAGE;
	[self addSubview:calloutCenter];
	[calloutCenter release];
	
	
	calloutRight = [[UIImageView alloc] init];
	calloutRight.image = CALLOUT_RIGHT_IMAGE;
	[self addSubview:calloutRight];
	[calloutRight release];
	
	calloutImage = [[UIImageView alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH-5,35, 60, 60)];
	calloutImage.backgroundColor=[UIColor clearColor];
	[self addSubview:calloutImage];
	[calloutImage release];
	
	
	calloutLabel = [[UILabel alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH+60,20, frame.size.width - - MIN_LEFT_IMAGE_WIDTH - BUTTON_WIDTH - MIN_RIGHT_IMAGE_WIDTH - 2 , LABEL_HEIGHT)];
	calloutLabel.font = [UIFont boldSystemFontOfSize:LABEL_FONT_SIZE];
	calloutLabel.textColor = [UIColor whiteColor];
	calloutLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:calloutLabel];
	[calloutLabel release];
	
	calloutLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH+60, 40, frame.size.width - - MIN_LEFT_IMAGE_WIDTH - BUTTON_WIDTH - MIN_RIGHT_IMAGE_WIDTH - 2 , LABEL_HEIGHT)];
	calloutLabel1.font = [UIFont systemFontOfSize:13];
	calloutLabel1.textColor = [UIColor whiteColor];
	calloutLabel1.backgroundColor = [UIColor clearColor];
	[self addSubview:calloutLabel1];
	[calloutLabel1 release];
	
	calloutLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH+60, 60, frame.size.width - - MIN_LEFT_IMAGE_WIDTH - BUTTON_WIDTH - MIN_RIGHT_IMAGE_WIDTH - 2 , LABEL_HEIGHT)];
	calloutLabel2.font = [UIFont systemFontOfSize:13];
	calloutLabel2.textColor = [UIColor whiteColor];
	calloutLabel2.backgroundColor = [UIColor clearColor];
	[self addSubview:calloutLabel2];
	[calloutLabel2 release];
	

}


- (void) layoutSubviews
{

	[super layoutSubviews];
	
	CGRect frame = self.frame;
	frame.size.height = CALLOUT_HEIGHT;
	if (frame.size.width < 100)
		frame.size.width = 100;
	self.frame = frame;
	
	size = [calloutLabel.text sizeWithFont:calloutLabel.font];
	CGSize size2 = [calloutLabel1.text sizeWithFont:calloutLabel1.font];
	CGSize size3 = [calloutLabel2.text sizeWithFont:calloutLabel2.font];
	
	width = size.width;
	
	if(width < size2.width)
	{
		width = size2.width + 10;
	}
	if(width < size3.width)
	{
		width =size3.width + 10;
	}
	
	frame.size.width = width + MIN_LEFT_IMAGE_WIDTH + BUTTON_WIDTH + MIN_RIGHT_IMAGE_WIDTH + 3;
	frame.size.height = CALLOUT_HEIGHT;
	self.frame = frame;
	
	if (ANCHOR_X < MIN_ANCHOR_X) {
		ANCHOR_X =  MIN_ANCHOR_X;
	}
	
	 left_width = ANCHOR_X - CENTER_IMAGE_ANCHOR_OFFSET_X;
	 right_width = frame.size.width - left_width - CENTER_IMAGE_WIDTH-60;
	
		
//	calloutLeft.frame = CGRectMake(10, 20, left_width, CALLOUT_HEIGHT);
//	calloutCenter.frame = CGRectMake(left_width+10, 20, CENTER_IMAGE_WIDTH, CALLOUT_HEIGHT);
//	calloutRight.frame = CGRectMake(left_width+CENTER_IMAGE_WIDTH+10, 20, right_width+20, CALLOUT_HEIGHT);
//	calloutLabel.frame = CGRectMake(MIN_LEFT_IMAGE_WIDTH+60,20, size.width, LABEL_HEIGHT);
	
	calloutLeft.frame = CGRectMake(0, 20, 80, CALLOUT_HEIGHT);
	calloutCenter.frame = CGRectMake(80, 20, CENTER_IMAGE_WIDTH, CALLOUT_HEIGHT);
	calloutRight.frame = CGRectMake(80+CENTER_IMAGE_WIDTH, 20, 80, CALLOUT_HEIGHT);
	calloutLabel.frame = CGRectMake(MIN_LEFT_IMAGE_WIDTH+50,20, 100, LABEL_HEIGHT);

}

-(void) setAnchorPoint:(CGPoint)pt 
{
	
	if(pt.x<20)
		ANCHOR_X =0;
	else if (pt.x < 100.0f )
		ANCHOR_X = 32;
	else if (pt.x > 300)
		ANCHOR_X = 140;
	else if (pt.x > 240)
		ANCHOR_X = 100;
	else if (pt.x > 100.0f)
		ANCHOR_X = 60;
	self.frame = CGRectMake(pt.x - ANCHOR_X, pt.y - ANCHOR_Y, self.frame.size.width, self.frame.size.height);

	
}

- (void) addButtonTarget:(id)target action:(SEL)selector
{
	[calloutButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


- (void)dealloc {
	NSLog(@"Callout Release");
	[text release];
	text = nil;
    [super dealloc];
}


@end
