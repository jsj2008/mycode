    //
//  SecondClass.m
//  Training
//
//  Created by Sujit Kumar on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecondClass.h"


@implementation SecondClass

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	label.textColor =[UIColor blueColor];
	
	//UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 50)];
	//UILabel *label = [[UILabel alloc]init];
//	label.text = @"Hello World";
//	label.layer.cornerRadius = 20;
//	label.layer.borderWidth =3;
//	label.layer.borderColor = [UIColor purpleColor].CGColor;
//	[self.view addSubview:label];
//	label.frame = CGRectMake(0,100,300,50);
//	//label.textAlignment = UITextAlignmentCenter;
//	//label.center = CGPointMake(0,800);
//	
//	[label release];
//	
	self.view.backgroundColor =[UIColor blackColor];
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
