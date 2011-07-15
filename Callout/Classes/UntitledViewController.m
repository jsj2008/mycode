//
//  UntitledViewController.m
//  Untitled
//
//  Created by Ayush on 10/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UntitledViewController.h"
#import "CallOutView.h"

@interface UntitledViewController()
-(void) showCalloutAt:(CGPoint)point;
@end



@implementation UntitledViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
/*2011-01-10 13:54:37.793 Untitled[8001:207] x== 81.000000 y==182.000000
2011-01-10 13:54:39.049 Untitled[8001:207] x== 165.000000 y==153.000000
2011-01-10 13:54:40.402 Untitled[8001:207] x== 227.000000 y==224.000000
2011-01-10 13:54:43.818 Untitled[8001:207] x== 231.000000 y==165.000000*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{ 
	ButtonArray =[[NSMutableArray alloc]init];
	
	imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320,480)];
	[imageview setImage:[UIImage imageNamed:@"details.png"]];
	[self.view addSubview:imageview];
	[super viewDidLoad];
	[ButtonArray addObject:[NSNumber numberWithInt:5]];
	[ButtonArray addObject:[NSNumber numberWithInt:182]];
	[ButtonArray addObject:[NSNumber numberWithInt:160]];
	[ButtonArray addObject:[NSNumber numberWithInt:153]];
	[ButtonArray addObject:[NSNumber numberWithInt:218]];
	[ButtonArray addObject:[NSNumber numberWithInt:224]];
	[ButtonArray addObject:[NSNumber numberWithInt:220]];
	[ButtonArray addObject:[NSNumber numberWithInt:165]];
	[self addbutton];
}

-(void) addbutton
{

	UIButton *ImageButton;
	for(int i=0;i<[ButtonArray count]-1;i+=2)
	{
	ImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
	ImageButton.frame = CGRectMake([[ButtonArray objectAtIndex:i] intValue],[[ButtonArray objectAtIndex:(i+1)] intValue],40,20);
	ImageButton.backgroundColor=[UIColor blackColor];
	[self.view addSubview:ImageButton];
	[ImageButton addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchDown];
	}
	
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
	
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (callout != nil) {
		[callout removeFromSuperview];
		callout = nil;
	}
}




-(void) expand:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	NSLog(@"x== %f y==%f",btn.frame.origin.x,btn.frame.origin.y);
	CGPoint myPoint = CGPointMake(btn.frame.origin.x,btn.frame.origin.y);
	[self showCalloutAt:myPoint];
	
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
	callout = [CallOutView addCalloutView:self.view text:@"Shirt Classic" point:point target:self action:@selector(handleCalloutClick:)];	

}


- (void)dealloc {
    [super dealloc];
}




@end
