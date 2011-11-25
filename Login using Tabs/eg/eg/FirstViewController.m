//
//  FirstViewController.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "Brain.h"
@implementation FirstViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
     
    [super viewDidLoad];
   
}

-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"HEREEE");
    NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
    [chk synchronize];
    if([chk stringForKey:@"Current"])
    {
        [logi.view removeFromSuperview];
        Brain *br = [[Brain alloc] init];
        UIImage *imgg = [UIImage imageNamed:[br getData:@"img"]];
        imgview.image = imgg; 
        [imgview setFrame:CGRectMake(80, 90,imgg.size.width , imgg.size.height)];

    }
    else
    {
        logi = [[LoginToContinue alloc] init];
        [self.view addSubview:logi.view];
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
