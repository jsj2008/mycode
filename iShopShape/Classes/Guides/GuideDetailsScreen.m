//
//  GuideDetailsScreen.m
//  iShopShape
//
//  Created by Santosh B on 19/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "GuideDetailsScreen.h"
#import "GuidesDetailsCustomCell.h"
#import "GuideNoteCustomCell.h"


@implementation GuideDetailsScreen

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil guides:(Guides*)aGuide{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		guide = aGuide;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setTitle:guide.guideTitle];
	
	[guideDetailsTable setBackgroundColor:[UIColor clearColor]];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackground.png"]]];
	
    [super viewDidLoad];
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
	NSLog(@"GuideDetailsScreen -------------------- Release");
    [super dealloc];
}



-(float) calculateHeightForCell
{
	CGSize size = [guide.guideNotes sizeWithFont:[UIFont systemFontOfSize:20.0] constrainedToSize:CGSizeMake(280,400) lineBreakMode:UILineBreakModeWordWrap];
	
	NSLog(@"Height == %f", size.height);
	if(size.height > 350)
	{
		return size.height + 100;
	}
	return size.height + 15;
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
	if(section==0)
	return [guide.guideDetailsArray count];
	
	if(section==1)
		return 1;
	return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section==1)
	 return @"Notes";
	return NULL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	if(indexPath.section==0)
	{
	static NSString *identifier =@"Guides";
	
	GuidesDetailsCustomCell *cell = (GuidesDetailsCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[GuidesDetailsCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	
	/*Storing temporary data*/
	
	GuidesDetails *guides = [guide.guideDetailsArray objectAtIndex:indexPath.row];
	[cell setCellData:guides];
	
	return cell;
	}	
	
	
	if(indexPath.section==1)
	{
		static NSString *identifier =@"Guidesnote";
		
		GuideNoteCustomCell *cell = (GuideNoteCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
		
		if(nil == cell)
		{
			cell =[[[GuideNoteCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
		}
		[cell.textView setFrame:CGRectMake(10, 10, 280, [self calculateHeightForCell])];
		[cell.textView setText:guide.guideNotes];
		return cell;
	}	
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	float height = 0;
	switch (indexPath.section) {
		case 0:
		{
			GuidesDetails *guides = [guide.guideDetailsArray objectAtIndex:indexPath.row];
			UIImage *image = [UIImage imageNamed:guides.stepImageName];
			height = image.size.height + 40;
		}
			break;
		case 1:
			height =[self calculateHeightForCell];
			NSLog(@"Height == %f",height);
			break;
	}
	return height;
	
}


@end
