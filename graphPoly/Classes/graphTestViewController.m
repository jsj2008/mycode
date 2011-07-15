//
//  graphTestViewController.m
//  graphTest
//
//  Created by Yogesh Bhople on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "graphTestViewController.h"
#import "RawData.h"
#import "GraphView.h"


@implementation graphTestViewController



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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSMutableArray *myArray = [[NSMutableArray alloc]init];
	
	RawData* obj = [[RawData alloc]init];
	
	obj.month  = 1;	
	NSMutableArray* weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:5 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:5 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	obj = [[RawData alloc]init];	
	obj.month  = 2;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:5 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:5 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	obj = [[RawData alloc]init];	
	obj.month  = 3;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:2 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	obj = [[RawData alloc]init];	
	obj.month  = 4;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:5 ]];
	[weekRate addObject:[NSNumber numberWithInt:2 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	
	obj = [[RawData alloc]init];	
	obj.month  = 5;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	
	obj = [[RawData alloc]init];	
	obj.month  = 6;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	CGRect curRect = [self.view frame];
	
	int width = curRect.size.width;//200;
	int ht = 200;//curRect.size.width;//curRect.size.height;//100;
	
	
	NSMutableArray* secArr = [[NSMutableArray alloc]init];
	[secArr addObject:[NSNumber numberWithInt:4 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:1 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:1 ]];
	
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:4 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:4 ]];
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	
	GraphView* vw = [[GraphView alloc]initWithFrame:CGRectMake(0,0,width,ht) graphdata:myArray CountryName:@"South Africa NA" Rating:5 secongraph:secArr];
	[self.view addSubview:vw];
	[secArr release];
	[vw release];
	
//	GpTableViewController* gpTable = [[GpTableViewController alloc]init];
//	[self.view addSubview:gpTable.view];
//	[gpTable release];
	
//	ResourceListViewController* vwCon = [[ResourceListViewController alloc]init];
//	[self.view addSubview:vwCon.view];
	//[vwCon release];
	[super viewDidLoad];
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

// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations
//	if (interfaceOrientation !=UIInterfaceOrientationPortrait) {
//		return TRUE;
//	} else {
//		return FALSE;
//	}
//	
//}

@end
