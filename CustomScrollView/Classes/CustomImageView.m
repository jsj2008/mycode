//
//  CustomImageView.m
//  ImageTouch
//
//  Created by ayush on 25/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"



@implementation CustomImageView

//@synthesize imageView1;
@synthesize delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Call super to make sure you don't lose any functionality
	
	//[imageView1 setUserInteractionEnabled:YES]; 
	
    [super touchesBegan:touches withEvent:event];
	//UITouch *touch = [touches anyObject]; 
    NSLog(@"tag %d",self.tag); 
    if(delegate) 
	{ 
		[delegate CustomImageTouchEvent:self.image];
        
		//Do Something 
	} 
    // Perform the actions you want to perform with the tap.
	}


/*
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	
	// Move relative to the original touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
	frame.origin.y += pt.y - startLocation.y;
	[self setFrame:frame];
}




*/


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];

}


/// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
