//
//  TestView.m
//  CallOutView
//

#import "TestView.h"


@interface TestView()
-(void) stopTimer;
-(void) showCalloutAt:(CGPoint)point;
@end


@implementation TestView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
	

		
		ButtonArray=[[NSMutableArray alloc]init];
		[ButtonArray addObject:[NSNumber numberWithInt:82]];
		[ButtonArray addObject:[NSNumber numberWithInt:178]];
		[ButtonArray addObject:[NSNumber numberWithInt:233]];
		[ButtonArray addObject:[NSNumber numberWithInt:212]];
		[ButtonArray addObject:[NSNumber numberWithInt:168]];
		[ButtonArray addObject:[NSNumber numberWithInt:148]];
		[ButtonArray addObject:[NSNumber numberWithInt:220]];
		[ButtonArray addObject:[NSNumber numberWithInt:162]];
		
    }
				   
				

//[next setImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
//[next addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchDown];
					
    return self;
}

- (void) createButtons
{
	UIButton  *next = [UIButton buttonWithType:UIButtonTypeCustom];
	next.backgroundColor=[UIColor blackColor];
	next.frame = CGRectMake(10,80,100,100);
	[next setTitle:@"hiii" forState:UIControlStateNormal];	
	[self addSubview:next];
	[next release];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	

	[self stopTimer];
	
	if (callout != nil) {
		[callout removeFromSuperview];
		callout = nil;
	}

	touchPoint = [[touches anyObject] locationInView:self];

	timer = [[NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(expand:) userInfo:nil repeats:NO] retain];
	[super touchesBegan:touches withEvent:event];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

	[self stopTimer];
	[super touchesMoved:touches withEvent:event];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

	[self stopTimer];
	[super touchesCancelled:touches withEvent:event];	
	
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	[super touchesEnded:touches withEvent:event];
}


-(void) stopTimer
{
	if (timer != nil) {
		if ([timer isValid]) {
			[timer invalidate];
		}
		timer = nil;
	}	
}

-(void) expand:(NSTimer*)timer
{
	

	NSLog(@"x== %f y==%f",touchPoint.x,touchPoint.y);
		[self showCalloutAt:touchPoint];
}

-(void) handleCalloutClick:(UIControl*)control {
	
	if (callout != nil) {
		[callout removeFromSuperview];
		callout = nil;
	}
}

-(void) showCalloutAt:(CGPoint)point
{
	if (callout != nil) {
		[callout removeFromSuperview];
		callout = nil;
	}
	callout = [CallOutView addCalloutView:self text:@"Shirt Classic" point:point target:self action:@selector(handleCalloutClick:)];	
}


- (void)dealloc {
    [super dealloc];
}


@end
