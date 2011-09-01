//
//  FirstViewControllerDetails_iPad.m
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "FirstViewControllerDetails_iPad.h"


@implementation FirstViewControllerDetails_iPad
@synthesize navigationBar;
@synthesize myTitle;

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
    NSLog(@"FirstViewControllerDetails_iPad ---------- Release");
    [navigationBar release];
    [myTitle release];
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
    [self.myTitle setText:@"string"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [self setMyTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma -

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem 
{
    [navigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
}

- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem ;
{
    [navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
}

- (void) setTexts : (NSString *)text
{
    NSLog(@"setText -- %@", myTitle);
    [myTitle setText:text];
}
@end
