    //
//  MainViewController.m
//  PortraitGraph
//
//  Created by Seb Kade on 6/05/10.
//  Copyright 2010 SKADE Development. All rights reserved.
//

#import "MainViewController.h"
#import "GraphView.h"


@implementation MainViewController

@synthesize myGraph;

-(id) initWithFrame:(CGRect )frame;
{
	if (self = [super init])
	{
		//[self.view setBackgroundColor:[UIColor redColor]];
		[self.view setFrame:frame];
		
		//graph setup
		myGraph = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
		[self.view addSubview:myGraph];
		[myGraph release];
	}

	return self;

}




// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

 


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	if (interfaceOrientation !=UIInterfaceOrientationPortrait) {
		return TRUE;
	} else {
		return FALSE;
	}
	
}


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
	[myGraph release];
    [super dealloc];
}


@end
