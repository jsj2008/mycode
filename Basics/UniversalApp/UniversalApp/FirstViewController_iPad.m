//
//  FirstViewController_iPad.m
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "FirstViewController_iPad.h"
#import "FirstViewControllerDetails_iPad.h"

@implementation FirstViewController_iPad
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
    NSLog(@"didSelectRowAtIndexPath");
    
    FirstViewControllerDetails_iPad *detailView = [[FirstViewControllerDetails_iPad alloc] initWithNibName:@"FirstViewControllerDetails_iPad" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:detailView animated:YES];
    [detailView release];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
   [detailView setTexts:cell.textLabel.text];
}


#pragma -
- (void)my
{
     NSLog(@"My");
}
@end
