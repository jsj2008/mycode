//
//  menu.m
//  project
//
//  Created by Ayush Goel on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "menu.h"
#import "mobcoe.h"
#import "introduction.h"

@implementation menu

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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void ) aboutus
{
	introduction *a = [[introduction alloc] init];
	a.index=0;
	[self.navigationController pushViewController:a animated:YES];
    
}

- (void ) contactus
{
	
	introduction *a = [[introduction alloc] init];
	a.index=1;
	[self.navigationController pushViewController:a animated:YES];
}

-(void) mob
{
mobcoe *m = [[mobcoe alloc] init];
[self.navigationController pushViewController:m animated:YES];
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




@end
