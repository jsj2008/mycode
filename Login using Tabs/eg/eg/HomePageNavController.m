//
//  HomePageNavController.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomePageNavController.h"
#import "Login.h"
#import "WelcomeScreen.h"
@implementation HomePageNavController

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
    
//        Login *log = [[Login alloc] init];
//        [self pushViewController:log animated:YES];

    NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
   // NSLog(@"%@",[chk stringForKey:@"Current"]);
    //[chk setObject:NULL forKey:@"Current"];
    //[chk synchronize];
    if(![chk stringForKey:@"Current"])
    { 
        //add login screen
        Login * log = [[Login alloc] init];
        [self pushViewController:log animated:YES];
    }
    else
    {
        //add welcome screen
        WelcomeScreen *welcome = [[WelcomeScreen alloc] init];
        [self pushViewController:welcome animated:YES];
        
    }
    // Do any additional setup after loading the view from its nib.
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
