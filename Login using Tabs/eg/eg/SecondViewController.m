//
//  SecondViewController.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "LoginToContinue.h"
#import "Brain.h"

@implementation SecondViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
    [chk synchronize];
    if([chk stringForKey:@"Current"])
    {
        [logi.view removeFromSuperview];
        Brain * br = [[Brain alloc] init];
        name.text = [br getData:@"name"];
        age.text = [br getData:@"age"];
        addr.text = [br getData:@"addr"];
        //[super viewWillAppear:NO];
    }
    else
    {
        logi = [[LoginToContinue alloc] init];
        [self.view addSubview:logi.view];
    }
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end
