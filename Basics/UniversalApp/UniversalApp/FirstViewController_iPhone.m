//
//  FirstViewController_iPhone.m
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "FirstViewController_iPhone.h"
#import "FirstViewControllerDetails_iPhone.h"

@implementation FirstViewController_iPhone
@synthesize listTableView;

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
    [listTableView release];
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
    [self setTitle:@"First"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setListTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  10;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierFirst = @"Cell";
    
    UITableViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifierFirst];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierFirst] autorelease];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"String - %d", indexPath.row]];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    FirstViewControllerDetails_iPhone *detailView = [[FirstViewControllerDetails_iPhone alloc] initWithNibName:@"FirstViewControllerDetails_iPhone" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:detailView animated:YES];
    
    [detailView release];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [detailView.myTitle setText:cell.textLabel.text];
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        //[self loadImagesForOnscreenRows];
    }
}




@end
