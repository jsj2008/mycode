//
//  MultiTouchDemoAppDelegate.m
//  MultiTouchDemo
//
//  Created by Manish Nath on 5/29/08.
//  Copyright Vinsol. All rights reserved.
//

#import "MultiTouchDemoViewController.h"
#import "TouchImageView.h"

#define IMAGE_WIDTH 100.0

@implementation MultiTouchDemoViewController
TouchImageView *touchImageView1,*touchImageView2,*touchImageView3;
int tagToRemove = -1;
- (void)viewDidLoad
{
	[super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
	
    UIImage *image = [UIImage imageNamed:@"1.png"];
    CGRect imageRect = CGRectMake(0.0, 0.0, IMAGE_WIDTH, 0.0);
    imageRect.size.height = IMAGE_WIDTH * image.size.height / image.size.width/2;
	CFShow(image);
	//NSLog(@"image rect %@ %f",imageRect,image.size.height);
	touchImageView1 = [[TouchImageView alloc] initWithFrame:imageRect];
    touchImageView1.image = image;
	touchImageView1.tag = 1;
    touchImageView1.center = CGPointMake(160.0, 230.0);
	touchImageView1.parent = self;
    [self.view addSubview:touchImageView1];
	 
    


    image = [UIImage imageNamed:@"2.png"];
    imageRect.size.height = IMAGE_WIDTH * image.size.height / image.size.width;
    touchImageView2 = [[TouchImageView alloc] initWithFrame:imageRect];
    touchImageView2.image = image;
	touchImageView2.tag = 2;
	touchImageView2.parent = self;
    touchImageView2.center = CGPointMake(160.0, 85.0);
    [self.view addSubview:touchImageView2];
    

    image = [UIImage imageNamed:@"3.png"];
    imageRect.size.height = IMAGE_WIDTH * image.size.height / image.size.width;
    touchImageView3 = [[TouchImageView alloc] initWithFrame:imageRect];
    touchImageView3.image = image;
	touchImageView3.tag = 3;
	touchImageView3.parent = self;
    touchImageView3.center = CGPointMake(160.0, 375.0);
    [self.view addSubview:touchImageView3];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    NSLog(@"points == %f   %f",location.x,location.y);
    

}

-(void)setLastTouchTag:(int)tag
{
	tagToRemove = tag;
}
-(IBAction)deleteImage:(id)sender
{
	for (TouchImageView *t in [self.view subviews]) {
		if(tagToRemove == t.tag)
			[t removeFromSuperview];
	}
	
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)dealloc
{
	[touchImageView1 release];
	[touchImageView2 release];
	[touchImageView3 release];
	[super dealloc];
}

@end
