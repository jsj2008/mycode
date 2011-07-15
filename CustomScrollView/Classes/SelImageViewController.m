//
//  SelImageViewController.m
//  SelImage
//
//  Created by ayush on 25/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelImageViewController.h"
#import "CustomImageView.h"

@implementation SelImageViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

@synthesize scrollview;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[self.view setBackgroundColor:[UIColor blackColor]];
	
	scrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(20,340,280,70)];
	[scrollview setContentSize:CGSizeMake(670, 70)];
	[scrollview setBackgroundColor:[UIColor grayColor]];
	[self.view addSubview:scrollview];
	
	
	

	for (int i=0; i<=10; i++) {
	//	NSLog(@"%d",i);
	
	UIImage* image1 = [UIImage imageNamed:@"1.jpg"];
	CustomImageView *imageView = [[CustomImageView alloc] initWithImage:image1];	
	imageView.frame = CGRectMake(15+60*i,12,50,50);
		[imageView setUserInteractionEnabled:YES]; 
		imageView.tag=i;
		imageView.delegate=self;
	[scrollview addSubview:imageView];
	[imageView release];
	}
}

- (void) CustomImageTouchEvent:(UIImage *)view1
{
	NSLog(@"in custom image view");
	NSLog(@"%@",view1);
	UIImageView *bigImage=[[UIImageView alloc]initWithImage:view1];
	[bigImage setBackgroundColor:[UIColor blueColor]];
	bigImage.frame=CGRectMake(50, 50, 200, 200);
	[self.view addSubview:bigImage];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
