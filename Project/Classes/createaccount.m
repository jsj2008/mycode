//
//  createaccount.m
//  project
//
//  Created by Ayush Goel on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "createaccount.h"
#import "loginview.h"

@implementation createaccount
@synthesize name;
@synthesize pass;


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
- (void ) create
{
    //[[NSUserDefaults standardUserDefaults] ]
	[name resignFirstResponder];
	[pass resignFirstResponder];	

	if(([name.text isEqualToString: @""])||([pass.text isEqualToString: @""]))
	{
		lbl.text=@"Username or Password cannot be empty";
	}
	
	else 
	{
		NSUserDefaults *s = [NSUserDefaults standardUserDefaults];
        [ [s dictionaryRepresentation] allKeys];
		NSMutableArray *array = [s objectForKey:@"ROOT"];
		NSString *nameString; 
		NSInteger i=-1;
		for(int iLoop = 0; iLoop<[array count] ; iLoop++)
		{	
			NSDictionary *dict = [array objectAtIndex:iLoop];
			nameString = [dict objectForKey:@"NAME"];
			if([name.text isEqualToString: nameString])	
			{
				lbl.text=@"Username already exist!!!";
				i=0;
			}
		}
		
		if(i==-1)
		{
		NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:array];
		NSDictionary *dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:name.text,pass.text,nil] forKeys:[NSArray arrayWithObjects:@"NAME",@"PASS",nil]];
			name.text=@"";
			pass.text=@"";
			[array1 addObject:dict];
		[s setValue:array1 forKey:@"ROOT"];
            [s synchronize];
		[dict release]; 
		[array1 release];
	    lbl.text=@"";
	    loginview *l = [[loginview alloc] init];
        [self.navigationController pushViewController:l animated:YES];
	    [l release];
		}
	
	}
	

	
}
- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	
    [super dealloc];
}


@end
