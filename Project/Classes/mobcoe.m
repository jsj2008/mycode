//
//  mobcoe.m
//  project
//
//  Created by Ayush Goel on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "projectAppDelegate.h"
#import "mobcoe.h"
#import "CustomCell.h"
#import "loginview.h"
#import "list.h"
#import "resource.h"



@implementation mobcoe


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
	nameArray = [[NSMutableArray alloc] initWithObjects:@"IPHONE",@"BLACKBERRY",@"ANDROID",@"SYMBIAN",nil];
	imageArray = [[NSMutableArray alloc] initWithObjects:@"iphone.jpg",@"blackberry.jpg",@"android.jpg",@"symbian.jpg",nil];
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
	[nameArray dealloc];
	[imageArray dealloc];
}

#pragma mark - UITableView delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [nameArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	projectAppDelegate *del=[UIApplication sharedApplication].delegate;
	switch(indexPath.row)
	{
		case 0:
		{
			resource *i = [[resource  alloc] init];
			del.idno=0;
			[self.navigationController pushViewController:i animated:YES];
			[i release];
			break;
		}
		case 1:
		{
			resource  *i = [[resource  alloc] init];
			del.idno=1;
			[self.navigationController pushViewController:i animated:YES];
			[i release];
			break;
		}
		case 2:
		{
			resource  *i = [[resource  alloc] init];
			del.idno=2;
			[self.navigationController pushViewController:i animated:YES];
			[i release];
			break;
			
		}
		case 3:
		{
			resource  *i = [[resource  alloc] init];
			del.idno=3;
			[self.navigationController pushViewController:i animated:YES];
			[i release];
			break;
			
		}
			
					
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCustomCellID = @"MyCellID";
	
	CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	
	if (cell == nil) 
	{
		cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.nameLbl.text = [[nameArray objectAtIndex:indexPath.row]capitalizedString];

	cell.checkImageView.image= [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
	return cell;
}


@end
