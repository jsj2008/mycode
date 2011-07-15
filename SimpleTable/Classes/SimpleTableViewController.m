//
//  SimpleTableViewController.m
//  SimpleTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "SimpleTableViewController.h"

@implementation SimpleTableViewController



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
- (void)viewDidLoad 
{
	dataArray = [[NSMutableArray alloc] initWithObjects:@"Ayush",@"Basant",@"Rashi",@"Rajiv",@"Yogesh",@"Sujeet",@"Yogesh",@"Anilet",@"Dilip",nil];
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


#pragma mark - UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
	
	if (isSearching && indexPath.row == selectedIndex) {
		return 110;
	}
	else {
		return 40;		
	}
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    
	if (isSearching && indexPath.row == selectedIndex) {
		
		static NSString *CellIdentifier = @"CustomCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		UILabel *theText = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, cell.contentView.bounds.size.width, 22.0)];
		theText.text = @"some text here";
		[cell.contentView addSubview:theText];
		
		UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 44.0, cell.contentView.bounds.size.width - 10, 44.0)];
		textField.borderStyle = UITextBorderStyleLine;
        [cell.contentView addSubview:textField];		
		
		UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 88.0, cell.contentView.bounds.size.width, 22.0)];
		detailLabel.text = @"some detail text";														
		[cell.contentView addSubview:detailLabel];
		
		return cell; 
		
	} else {
		
		static NSString *CellIdentifier = @"Cell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		
		UILabel *theText = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, cell.contentView.bounds.size.width, 22.0)];
		theText.text = @"some text here";
		[cell.contentView addSubview:theText];
		
		return cell; 
	}
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:NO];	
	
	selectedIndex = indexPath.row;
	isSearching = YES;
	
	[tableView beginUpdates];
	[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
	[tableView endUpdates];
	
}
@end
