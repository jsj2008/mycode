//
//  introduction.m
//  project
//
//  Created by Ayush Goel on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "introduction.h"


@implementation introduction
@synthesize index;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if(index==0)
	{
		l1.text=@"Cybage is a leading name in the global IT industry with a proven track record of over 14 years." 
		@"We have been consistently adding value to the business bottom line of a crème-de-la-crème global clientele."
		@"Cybage provides a wide array of software services within the models of offshore, onsite and combinations of the two." 
		@"Our operational excellence ensures that each dollar that our clients spend on an outsourcing engagement" 
		@"provides them an enhanced ROI, which is both tangible and measurable.";
	}
	else 
	{
		l1.text=@"Cybage Software Pvt. Ltd. West Avenue, Kalyani Nagar"
		@" Pune - 411006" 
		@" Ph: 91-20-66041700"
		@" Fax: 91-20-66041701";
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
