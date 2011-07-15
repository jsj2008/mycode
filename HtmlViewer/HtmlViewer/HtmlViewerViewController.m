//
//  HtmlViewerViewController.m
//  HtmlViewer
//
//  Created by Ayush Goel on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HtmlViewerViewController.h"

@implementation HtmlViewerViewController

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
   UIWebView *myWebView =[[UIWebView alloc] initWithFrame:CGRectMake(100,130,500,500)];
    myWebView.delegate = self;
    [myWebView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:myWebView];
    [myWebView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/~Ayush/"]]];
    [myWebView release];
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
