//
//  RatingsScreen.m
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "RatingsScreen.h"
#import "RatingCustomCell.h"

@implementation RatingsScreen

@synthesize storesArray;

- (void)viewDidLoad {
	
	[self setTitle:@"Ratings"];
	
	[storesTable setBackgroundColor:[UIColor clearColor]];
	storesTable.showsVerticalScrollIndicator = NO;
	storesTable.showsHorizontalScrollIndicator = NO;
	graphBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"darken_bg.png"]];
	frame = CGRectMake(0, 0, 320, 160);
	graphBackgroundView.frame =frame;

	[self.view addSubview:graphBackgroundView];
	
	storesArray = [[Stores_Array alloc]initWithStores];	
	
	frame = CGRectMake(0, 0, 320, 180);
	
	graph = [[Graph alloc]initWithFrame:frame WithStore:[storesArray.storeArray objectAtIndex:0]
					   AndSelectedStore:[storesArray.storeArray objectAtIndex:0]];
	[graph setBackgroundColor:[UIColor clearColor]];
	
	[self.view addSubview:graph];
	
	[graph release];
	
	[super viewDidLoad];
	
}

-(void)  reload:(int) choice{
	
	[graph removeFromSuperview];

	graph = [[Graph alloc] initWithFrame:frame WithStore:[storesArray.storeArray objectAtIndex:0]
					   AndSelectedStore:[storesArray.storeArray objectAtIndex:choice]];
	[graph setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:graph];
	[graph release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"Ratings------------------Release");
	[graphBackgroundView release];
	[storesTable release];
	[storesArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(![selectedIndex isEqual:indexPath])
	{
	  selectedIndex = indexPath;
	  [self reload:indexPath.row+1];
	}
	else 
	{
		selectedIndex = nil;
		[self reload:0];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}

}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	return [storesArray.storeArray count]-1; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *identifier =@"RATINGS_MENU";
	
	RatingCustomCell *cell = (RatingCustomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[RatingCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	
	UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@stars.png",[[storesArray.storeArray objectAtIndex:indexPath.row+1] avgRating] ] ];
	[cell.starImageView setImage:img];
	[cell.nameLbl setText:[NSString stringWithFormat:@"%@",[[storesArray.storeArray objectAtIndex:indexPath.row+1] store_name]] ];
	return cell;
}



@end
