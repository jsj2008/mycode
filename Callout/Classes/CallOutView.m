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
static UIImage *CALLOUT_ITEM_IMAGE;
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

-(id)initWithText:(NSString*)atext point:(CGPoint)point target:(id)object action:(SEL)selector
{
	if (self = [super initWithFrame:RECTFRAME]) {
		[self setAnchorPoint:point];
		[self initialize];
		self.text = atext;
		[self addButtonTarget:object action:selector];
	}	
	return self;
}


+ (CallOutView*) addCalloutView:(UIView*)parent text:(NSString*)text point:(CGPoint)pt target:(id)target action:(SEL)selector
{
	CallOutView *callout = [[CallOutView alloc] initWithText:text point:pt target:target action:selector];
	[callout showWithAnimiation:parent];
	return [callout autorelease];
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
	calloutLabel1.text = @"01129136913698";
	calloutLabel2.text = @"Quantity - 5";
	[calloutLabel setNeedsLayout];
}


- (void) initialize
{
	self.backgroundColor = [UIColor clearColor];
	self.opaque = false;
	
	if (CALLOUT_LEFT_IMAGE == nil) {
		CALLOUT_LEFT_IMAGE = [[[UIImage imageNamed:@"callout_left.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] retain];
	}
	
	if (CALLOUT_CENTER_IMAGE == nil) {
		CALLOUT_CENTER_IMAGE = [[UIImage imageNamed:@"callout_center.png"] retain];
	}
	
	if (CALLOUT_RIGHT_IMAGE == nil) {
		CALLOUT_RIGHT_IMAGE = [[[UIImage imageNamed:@"callout_right.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0] retain];
	}
	if (CALLOUT_ITEM_IMAGE == nil) {
		CALLOUT_ITEM_IMAGE = [[[UIImage imageNamed:@"shirt.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0] retain];
	}
	CGRect frame = self.frame;
	frame.size.height = CALLOUT_HEIGHT;
	if (frame.size.width < 100)
		frame.size.width = 100;
	self.frame = frame;
	
	if (ANCHOR_X < MIN_ANCHOR_X) {
		ANCHOR_X = MIN_ANCHOR_X;
	}
	
	
	float left_width = ANCHOR_X - CENTER_IMAGE_ANCHOR_OFFSET_X;
	float right_width = frame.size.width - left_width - CENTER_IMAGE_WIDTH;
	
	calloutLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, left_width, CALLOUT_HEIGHT)];
	calloutLeft.image = CALLOUT_LEFT_IMAGE;
	[self addSubview:calloutLeft];
	[calloutLeft release];
	
	calloutCenter = [[UIImageView alloc] initWithFrame:CGRectMake(left_width, 0, CENTER_IMAGE_WIDTH, CALLOUT_HEIGHT)];
	calloutCenter.image = CALLOUT_CENTER_IMAGE;
	[self addSubview:calloutCenter];
	[calloutCenter release];
	
	
	calloutRight = [[UIImageView alloc] initWithFrame:CGRectMake(left_width + CENTER_IMAGE_WIDTH, 0, right_width, CALLOUT_HEIGHT)];
	calloutRight.image = CALLOUT_RIGHT_IMAGE;
	[self addSubview:calloutRight];
	[calloutRight release];
	
	calloutImage = [[UIImageView alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH,35, 55, 55)];
	calloutImage.image = CALLOUT_ITEM_IMAGE;
	calloutImage.backgroundColor=[UIColor clearColor];
	[self addSubview:calloutImage];
	[calloutImage release];
	
	
	calloutLabel = [[UILabel alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH+50,20, frame.size.width - - MIN_LEFT_IMAGE_WIDTH - BUTTON_WIDTH - MIN_RIGHT_IMAGE_WIDTH - 2 , LABEL_HEIGHT)];
	calloutLabel.font = [UIFont boldSystemFontOfSize:LABEL_FONT_SIZE];
	calloutLabel.textColor = [UIColor whiteColor];
	calloutLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:calloutLabel];
	[calloutLabel release];
	
	calloutLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH+50, 40, frame.size.width - - MIN_LEFT_IMAGE_WIDTH - BUTTON_WIDTH - MIN_RIGHT_IMAGE_WIDTH - 2 , LABEL_HEIGHT)];
	calloutLabel1.font = [UIFont systemFontOfSize:13];
	calloutLabel1.textColor = [UIColor whiteColor];
	calloutLabel1.backgroundColor = [UIColor clearColor];
	[self addSubview:calloutLabel1];
	[calloutLabel1 release];
	
	calloutLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(MIN_LEFT_IMAGE_WIDTH+50, 60, frame.size.width - - MIN_LEFT_IMAGE_WIDTH - BUTTON_WIDTH - MIN_RIGHT_IMAGE_WIDTH - 2 , LABEL_HEIGHT)];
	calloutLabel2.font = [UIFont systemFontOfSize:13];
	calloutLabel2.textColor = [UIColor whiteColor];
	calloutLabel2.backgroundColor = [UIColor clearColor];
	[self addSubview:calloutLabel2];
	[calloutLabel2 release];
	

}


- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGSize size = [calloutLabel.text sizeWithFont:calloutLabel.font];
	
	CGRect frame = self.frame;
	frame.size.width = size.width + MIN_LEFT_IMAGE_WIDTH + BUTTON_WIDTH + MIN_RIGHT_IMAGE_WIDTH + 3;
	frame.size.height = CALLOUT_HEIGHT;
	self.frame = frame;
	
	if (ANCHOR_X < MIN_ANCHOR_X) {
		ANCHOR_X =  MIN_ANCHOR_X;
	}
	
	float left_width = ANCHOR_X - CENTER_IMAGE_ANCHOR_OFFSET_X;
	float right_width = frame.size.width - left_width - CENTER_IMAGE_WIDTH-60;
	NSLog(@"left width =%f right width =%f center  %d",left_width,right_width,CENTER_IMAGE_WIDTH);
	calloutLeft.frame = CGRectMake(10, 20, left_width, CALLOUT_HEIGHT);
	calloutCenter.frame = CGRectMake(left_width+10, 20, CENTER_IMAGE_WIDTH, CALLOUT_HEIGHT);
	calloutRight.frame = CGRectMake(left_width+CENTER_IMAGE_WIDTH+10, 20, right_width, CALLOUT_HEIGHT);
	calloutLabel.frame = CGRectMake(MIN_LEFT_IMAGE_WIDTH+50,20, size.width, LABEL_HEIGHT);
	
}




-(void) setAnchorPoint:(CGPoint)pt {
	
	if(pt.x<20)
		ANCHOR_X = 0;
	else if (pt.x < 140.0f )
		ANCHOR_X = 32;
	
	else if (pt.x > 240.0f)
	{
		ANCHOR_X = 150;
	}
	else if (pt.x > 150)
	{
		ANCHOR_X = 80;
	}
	self.frame = CGRectMake(pt.x - ANCHOR_X, pt.y - ANCHOR_Y, self.frame.size.width, self.frame.size.height);
}

- (void) addButtonTarget:(id)target action:(SEL)selector
{
	[calloutButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


- (void)dealloc {
	[text release];
	text = nil;

    [super dealloc];
}


@end
