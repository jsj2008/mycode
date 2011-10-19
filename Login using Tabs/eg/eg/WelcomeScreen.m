//
//  WelcomeScreen.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WelcomeScreen.h"
#import "Login.h"

@implementation WelcomeScreen
@synthesize msg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
    self.title = @"Welcome Screen";
    if([chk stringForKey:@"Current"])
    {
        msg.text = [NSString stringWithFormat:@"%@ is Logged In",[chk stringForKey:@"Current"]];
    }
    else
    {
        msg.text = @"Error";
    }

    // Do any additional setup after loading the view from its nib.
}
-(IBAction) logOut
{
    NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
    [chk setObject:NULL forKey:@"Current"];
    [chk synchronize];
    Login *log = [[Login alloc] init];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:log]];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
