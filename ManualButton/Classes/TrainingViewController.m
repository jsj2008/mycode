//
//  TrainingViewController.m
//  Training
//
//  Created by Sujit Kumar on 11/30/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TrainingViewController.h"

@implementation TrainingViewController




// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(IBAction) myfunc:(id)sender
{
    NSLog(@"hii");
    
}
-(IBAction) onNext:(id)sender
{
	newView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,480)];
	newView.backgroundColor = [UIColor blackColor];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame = CGRectMake(100,100,150,50);

	
	[btn setTitle:@"BACK" forState:UIControlStateNormal];

	//[btn setTitle:@"UP" forState:UIControlStateHighlighted];
	[btn addTarget:self action:@selector(onBack) 
	 forControlEvents:UIControlEventTouchUpInside];
	    
	// btn.titleLabel.textColor=[UIColor blackColor];
	[newView addSubview:btn];
	
	[self.view addSubview:newView];
	
	
	//[btn release];
	[newView release];
    
    NSString *hi="hiii";
    NSString *hii=[NSString alloc];
    hii="hii";
    [hii release];
    
   
}

-(void) onBack
{
	[newView removeFromSuperview];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	label.textColor =[UIColor redColor];
/*	
	//UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 50)];
	UILabel *label = [[UILabel alloc]init];
	label.text = @"Hello World";
	label.layer.cornerRadius = 20;
	label.layer.borderWidth =3;
	label.layer.borderColor = [UIColor purpleColor].CGColor;
	[self.view addSubview:label];
	label.frame = CGRectMake(0,0,300,50);
	//label.textAlignment = UITextAlignmentCenter;
	//label.center = CGPointMake(0,800);
	
	[label release];
 */
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
