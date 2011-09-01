//
//  moveImageViewController.m
//  moveImage
//
//  Created by Ayush Goel on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "moveImageViewController.h"
#import "CustomImageView.h"
@implementation moveImageViewController

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    myView=[[CustomImageView alloc]initWithFrame:CGRectMake(50, 50,200, 200)];
    myView.image=[UIImage imageNamed:@"a2.jpeg"];
    [myView setUserInteractionEnabled:YES];
    [self.view addSubview:myView];
    [myView release];

    [super viewDidLoad];
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
    return YES;
}

@end
