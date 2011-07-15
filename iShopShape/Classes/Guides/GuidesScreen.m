//
//  GuidesScreen.m
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "GuidesScreen.h"
#import "GuidesCustomCell.h"
#import "Guides.h"
#import "GuidesDetails.h"
#import "GuideDetailsScreen.h"
#import "CustomMoviePlayerViewController.h"

@implementation GuidesScreen
@synthesize guidesTable;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self setTitle:@"Guides"];
    [super viewDidLoad];
	guideList = [[NSMutableArray alloc] init];
	
	videoGuideList = [[NSMutableArray alloc] init];
	
	[self getAllGuides];
	
	[self getVideoGuideList];

//	guide = [[Guides alloc] init];
//	guide.guideTitle = @"Pant fold";
//	guide.guideSubTitle = @"Folding technique";
//	guide.guideImage = [UIImage imageNamed:@"jeans_4.png"];
//	[(NSMutableArray *)guideList addObject:guide];
//	[guide release];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	NSLog(@"GuidesScreen --------------- Release");
	[guidesTable release];
	[guideList release];
	[videoGuideList release];
    [super dealloc];
}

/**
 *	@functionName	: getAllGuides
 *	@parameters		: void
 *	@return			: void
 *	@description	: This method will populate list of all guides.
 */
- (void) getAllGuides
{
	/*Jeans*/
	Guides *guide = [[Guides alloc] init];
	guide.guideTitle = @"Jeans fold";
	guide.guideSubTitle = @"Folding technique";
	guide.guideImage = [UIImage imageNamed:@"jeans_thumnail.png"];
	
	guide.guideNotes = @"Do not use tissue.\n\n"
	@"Stacks should be x 6.\n\n"
	@"Stack smallest on top to largest on bottom.";
	
	NSArray *guidDetailsArray = [[NSMutableArray alloc] init];
	
	for(int iLoop = 0; iLoop < 4; iLoop++)
	{
		GuidesDetails *guideDetails = [[GuidesDetails alloc] init];
		
		guideDetails.stepName = [NSString stringWithFormat:@"Step %d",iLoop+1];
		guideDetails.stepImageName = [NSString stringWithFormat:@"jeans_%d.png",iLoop+1];
		
		[(NSMutableArray*)guidDetailsArray addObject:guideDetails];
		[guideDetails release];
	}
	guide.guideDetailsArray = guidDetailsArray;
	
	[guidDetailsArray release];
	
	[(NSMutableArray *)guideList addObject:guide];
	[guide release];
	guide = nil;
	
	/*Pant*/
/*	guide = [[Guides alloc] init];
	guide.guideTitle = @"Pant fold";
	guide.guideSubTitle = @"Folding technique";
	guide.guideImage = [UIImage imageNamed:@"Pant_4.png"];
	
	guidDetailsArray = [[NSMutableArray alloc] init];
	
	for(int iLoop = 0; iLoop < 4; iLoop++)
	{
		GuidesDetails *guideDetails = [[GuidesDetails alloc] init];
		
		guideDetails.stepName = [NSString stringWithFormat:@"Step %d",iLoop+1];
		guideDetails.stepImageName = [NSString stringWithFormat:@"Pant_%d",iLoop+1];
		
		[(NSMutableArray*)guidDetailsArray addObject:guideDetails];
	}
	guide.guideDetailsArray = guidDetailsArray;
	
	[guidDetailsArray release];
	
	[(NSMutableArray *)guideList addObject:guide];
	[guide release];
	guide = nil;
*/	
	/*T-Shirt*/
	guide = [[Guides alloc] init];
	guide.guideTitle = @"T-shirt fold";
	guide.guideSubTitle = @"Folding technique";
	guide.guideImage = [UIImage imageNamed:@"tshirt_thumbnail.png"];
	
	guide.guideNotes = @"Do not use tissue.\n\n"
	@"Stacks should be x 10.\n\n"
	@"Stack smallest on top to largest on bottom.";
	
	guidDetailsArray = [[NSMutableArray alloc] init];
	
	for(int iLoop = 0; iLoop < 7; iLoop++)
	{
		GuidesDetails *guideDetails = [[GuidesDetails alloc] init];
		
		guideDetails.stepName = [NSString stringWithFormat:@"Step %d",iLoop+1];
		guideDetails.stepImageName = [NSString stringWithFormat:@"tshirt_%d.png",iLoop+1];
		
		[(NSMutableArray*)guidDetailsArray addObject:guideDetails];
		
		[guideDetails release];
	}
	guide.guideDetailsArray = guidDetailsArray;
	
	[guidDetailsArray release];
	
	[(NSMutableArray *)guideList addObject:guide];
	[guide release];
	guide = nil;
	
	/*Hooded Top*/
	guide = [[Guides alloc] init];
	guide.guideTitle = @"Hooded top fold";
	guide.guideSubTitle = @"Folding technique";
	guide.guideImage = [UIImage imageNamed:@"hoddedtop_thumbnail.png"];
	
	guide.guideNotes = @"Do not use tissue.\n\n"
	@"Stacks should be x 6.\n\n"
	@"Stack smallest on top to largest on bottom.";
	
	guidDetailsArray = [[NSMutableArray alloc] init];
	
	for(int iLoop = 0; iLoop < 7; iLoop++)
	{
		GuidesDetails *guideDetails = [[GuidesDetails alloc] init];
		
		guideDetails.stepName = [NSString stringWithFormat:@"Step %d",iLoop+1];
		guideDetails.stepImageName = [NSString stringWithFormat:@"hoddedtop_%d.png",iLoop+1];
		
		[(NSMutableArray*)guidDetailsArray addObject:guideDetails];
		[guideDetails release];
	}
	guide.guideDetailsArray = guidDetailsArray;
	
	[guidDetailsArray release];
	
	[(NSMutableArray *)guideList addObject:guide];
	[guide release];	
	guide = nil;
	
	/*Hanger*/
	guide = [[Guides alloc] init];
	guide.guideTitle = @"Hanger";
	guide.guideSubTitle = @"Hanging technique";
	guide.guideImage = [UIImage imageNamed:@"hanger_thumbnail.png"];
	
	guide.guideNotes = @"Group items by type and color.\n\n"
	@"Zipped track tops should not be covering other products.";
	
	guidDetailsArray = [[NSMutableArray alloc] init];
	
	for(int iLoop = 0; iLoop < 3; iLoop++)
	{
		GuidesDetails *guideDetails = [[GuidesDetails alloc] init];
		
		guideDetails.stepName = [NSString stringWithFormat:@"Step %d",iLoop+1];
		guideDetails.stepImageName = [NSString stringWithFormat:@"hanger_%d.png",iLoop+1];
		
		[(NSMutableArray*)guidDetailsArray addObject:guideDetails];
		[guideDetails release];
	}
	guide.guideDetailsArray = guidDetailsArray;
	
	[guidDetailsArray release];
	
	[(NSMutableArray *)guideList addObject:guide];
	[guide release];
	guide = nil;
	
	/*Accessories*/
	guide = [[Guides alloc] init];
	guide.guideTitle = @"Accessories";
	guide.guideSubTitle = @"Placement technique";
	guide.guideImage = [UIImage imageNamed:@"accessories_thumbnail.png"];
	
	guide.guideNotes = @"Accessory tower is used to display, watches & sunglasses.\n\n"
	@"Use each shelf to display either sunglasses or watches (do not mix the product on the same shelf)\n\n"
	@"Merchandise in symmetrical configurations ensuring that the customer can view items all the way round the tower.\n\n"
	@"Use 6 x sunglasses per shelf (2 rows of 3).\n\n"
	@"Watches should be a minimum of 8 and maximum of 10.\n\n"
	@"Watches should be displayed on the perspex stand.\n\n"
	@"Sunglasses should be displayed on a glasses stand.\n\n"
	@"Ensure that each item is priced correctly.";
	
	guidDetailsArray = [[NSMutableArray alloc] init];
	
	for(int iLoop = 0; iLoop < 4; iLoop++)
	{
		GuidesDetails *guideDetails = [[GuidesDetails alloc] init];
		
		guideDetails.stepName = [NSString stringWithFormat:@"Step %d",iLoop+1];
		guideDetails.stepImageName = [NSString stringWithFormat:@"accessories_%d.png",iLoop+1];
		
		[(NSMutableArray*)guidDetailsArray addObject:guideDetails];
		[guideDetails release];
	}
	guide.guideDetailsArray = guidDetailsArray;
	
	[guidDetailsArray release];
	
	[(NSMutableArray *)guideList addObject:guide];
	[guide release];
}


- (void) getVideoGuideList
{
	Guides *guide = [[Guides alloc] init];
	guide.guideTitle = @"Lighting";
	guide.guideSubTitle = @"Lighting technique";
	guide.guideImage = [UIImage imageNamed:@"lighting_thumbnail.png"];
	
	[(NSMutableArray *)videoGuideList addObject:guide];
	[guide release];
	guide = nil;
	
	guide = [[Guides alloc] init];
	guide.guideTitle = @"Mannequin Outfit";
	guide.guideSubTitle = @"Arrangment technique";
	guide.guideImage = [UIImage imageNamed:@"Mannequin_thumnail.png"];
	
	[(NSMutableArray *)videoGuideList addObject:guide];
	[guide release];
	guide = nil;
}
/**
 *	@functionName	: getSelectedGuideInformation
 *	@parameters		: void
 *	@return			: void
 *	@description	: This method will populate details of specific guide.
 */
- (void) getSelectedGuideInformation
{

}

- (void)playVideo : (NSString *)fileName
{
	NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath], fileName];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
	
	// Create custom movie player
	CustomMoviePlayerViewController *customMoviePlayerViewController = [[[CustomMoviePlayerViewController alloc] initWithURL:baseURL] autorelease];
	
	// Show the movie player as modal
	[self presentModalViewController:customMoviePlayerViewController animated:YES];
	
	// Prep and play the movie
	[customMoviePlayerViewController readyPlayer];
}

#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	switch (section) {
		case 0:
			return [guideList count];
		case 1:
			return 2;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	static NSString *identifier =@"Guides";
	
	GuidesCustomCell *cell = (GuidesCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[GuidesCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	if(indexPath.section == 0)
	{
		[cell.playButtonImageView setHidden:YES];
		Guides *guide = [guideList objectAtIndex:indexPath.row];
		[cell setCellData:guide];
	}
	else {
		[cell.playButtonImageView setHidden:NO];
		Guides *guide = [videoGuideList objectAtIndex:indexPath.row];
		[cell setCellData:guide];
	}

	return cell;
}	

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[self playVideo:@"Lighting.mp4"];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	switch (indexPath.section) {
		case 0:
		{			
			GuideDetailsScreen *guideDetailsScreen = [[GuideDetailsScreen alloc] initWithNibName:@"GuideDetailsScreen" bundle:[NSBundle mainBundle] guides:[guideList objectAtIndex:indexPath.row]];
			[self.navigationController pushViewController:guideDetailsScreen animated:YES];
			[guideDetailsScreen release];
		}
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
					[self playVideo:@"Lighting.mp4"];
					break;
				case 1:
					[self playVideo:@"Mannequin Outfit.mp4"];
					break;
				default:
					break;
			}
			break;
	}
}
@end
