//
//  frontbackViewController.m
//  frontback
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "frontbackViewController.h"

@implementation frontbackViewController

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
    backImage=[[CustomImageView alloc]initWithFrame:CGRectMake(50, 50,200, 200)];
    backImage.image=[UIImage imageNamed:@"a1.jpeg"];
    [backImage setUserInteractionEnabled:YES];
    [self.view addSubview:backImage];
    backImage.tag=1;
    [backImage release];
	[backImage setDelegate:self];
    
    topImage=[[CustomImageView alloc]initWithFrame:CGRectMake(100,100,200, 200)];
    topImage.image=[UIImage imageNamed:@"a2.jpeg"];
    [topImage setUserInteractionEnabled:YES];
    [self.view addSubview:topImage];
     topImage.tag=2;
    [topImage release];
    [topImage setDelegate:self];
    
    
    [super viewDidLoad];
}

-(void)imagetouched:(int) tagid
{	
  
    
    if(tagid==1)
     {
         [backImage removeFromSuperview];
      [self.view addSubview:backImage];
    
     }
    
    else
    {
        [topImage removeFromSuperview];
        [self.view addSubview:topImage];
    }
    
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
