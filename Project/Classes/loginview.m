//
//  loginview.m
//  project
//
//  Created by Ayush Goel on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "loginview.h"
#import "RootViewController.h"
#import "menu.h"
#import "createaccount.h"

@implementation loginview
@synthesize name;
@synthesize pass;
@synthesize submit;
@synthesize invalid;
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
    
 
	name.text=@"";
    pass.text=@"";
		
	[super viewDidLoad];
	
}




- (IBAction) next
{
	createaccount *c = [[createaccount alloc] init];
	[self.navigationController pushViewController:c animated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfafile://localhost/Users/ayushg/Documents/project/Classes/loginview.hceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
    
    // Release any cached data, images, etc that aren't in use.
}



- (void ) validate
{
	[name resignFirstResponder];
	[pass resignFirstResponder];
	 NSUserDefaults *s = [NSUserDefaults standardUserDefaults];
	 NSMutableArray *array = [s objectForKey:@"ROOT"];
    NSLog(@"array ==  %@",array);
	NSString *nameString=@"",*	passString=@"" ;
	 for(int iLoop = 0; iLoop<[array count] ; iLoop++)
	 {	
	 NSDictionary *dict = [array objectAtIndex:iLoop];
	nameString = [dict objectForKey:@"NAME"];
	passString = [dict objectForKey:@"PASS"];
		 if([name.text isEqualToString: nameString])		 
			 break;
	 }

	if(([name.text isEqualToString: nameString]) && ([pass.text isEqualToString: passString]))
	{
		menu *i = [[menu alloc] init];
		name.text=@"";
		pass.text=@"";
		invalid.text=@" ";
		[self.navigationController pushViewController:i animated:YES];
		
	}
	else
	{
		invalid.text=@"Invalid Username or password";
	}
	
}
- (void)viewDidUnload {
    [super viewDidUnload];
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
