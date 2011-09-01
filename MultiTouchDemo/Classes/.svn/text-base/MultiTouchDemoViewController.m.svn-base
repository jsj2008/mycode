//
//  MultiTouchDemoAppDelegate.m
//  MultiTouchDemo
//
//  Created by Jason Beaver on 5/29/08.
//  Copyright Apple Inc. 2008. All rights reserved.
//

#import "MultiTouchDemoViewController.h"
#import "TouchImageView.h"

#define IMAGE_WIDTH 200.0

@implementation MultiTouchDemoViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIImage *image = [UIImage imageNamed:@"Flowing Rock.png"];
    CGRect imageRect = CGRectMake(0.0, 0.0, IMAGE_WIDTH, 0.0);
    imageRect.size.height = IMAGE_WIDTH * image.size.height / image.size.width;
    TouchImageView *touchImageView = [[TouchImageView alloc] initWithFrame:imageRect];
    touchImageView.image = image;
    touchImageView.center = CGPointMake(160.0, 230.0);
    [self.view addSubview:touchImageView];
    [touchImageView release];


    image = [UIImage imageNamed:@"Clown Fish.png"];
    imageRect.size.height = IMAGE_WIDTH * image.size.height / image.size.width;
    touchImageView = [[TouchImageView alloc] initWithFrame:imageRect];
    touchImageView.image = image;
    touchImageView.center = CGPointMake(160.0, 85.0);
    [self.view addSubview:touchImageView];
    [touchImageView release];

    image = [UIImage imageNamed:@"Stones.png"];
    imageRect.size.height = IMAGE_WIDTH * image.size.height / image.size.width;
    touchImageView = [[TouchImageView alloc] initWithFrame:imageRect];
    touchImageView.image = image;
    touchImageView.center = CGPointMake(160.0, 375.0);
    [self.view addSubview:touchImageView];
    [touchImageView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
