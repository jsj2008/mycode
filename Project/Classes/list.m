//
//  iphone.m
//  project
//
//  Created by Ayush Goel on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "list.h"
#import "customcell1.h"
#import "detail.h"
#import "loginview.h"
#import "about.h"


@implementation list
@synthesize nameArray;
@synthesize desgArray;
@synthesize idArray;
@synthesize window;
@synthesize navigationController;
@synthesize indexNumber;


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
	databaseName = @"project.sql";
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    [super viewDidLoad];
	
	[self checkAndCreateDatabase];
	
	[self readFromDatabase];
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

	[navigationController release];
	[window release];
	[super dealloc];
	[nameArray release];
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


-(void) checkAndCreateDatabase{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:databasePath];
	if(success) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];

	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];

}

-(void) readFromDatabase {
	sqlite3 *database;
	nameArray = [[NSMutableArray alloc] init];
	desgArray = [[NSMutableArray alloc] init];
	idArray = [[NSMutableArray alloc] init];
	const char *sqlStatement;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		switch(indexNumber)
		{
			case 0:
			{
				sqlStatement = "select fname,desg,id from iphone";
				break;
			}
				
			case 1:
			{
				sqlStatement = "select fname,desg,id from blackberry";
				break;
			}
				
			case 2:
			{
				sqlStatement = "select fname,desg,id from android";
				break;
			}
				
			case 3:
			{
				sqlStatement = "select fname,desg,id from symbian";
				break;
			}
				
				
		}
		

		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *desg = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
			  NSString *id1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
		
		//	NSLog(@"%@%",id1);
				[nameArray addObject:aName ];
			    [desgArray addObject:desg];
				[idArray addObject:id1];
			
			}
		}
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

 
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	int i=(int)[idArray objectAtIndex:indexPath.row ];
			NSLog(@"%@%",i);
		    detail *d = [[detail alloc] init];
			d.indexNumber=i;
			[self.navigationController pushViewController:d animated:YES];
			[d release];

	NSLog(@"hiii");
			
		
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCustomCellID = @"MyCellID";
	
	
	customcell1 *cell = (customcell1*)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	
	if (cell == nil) 
	{
		cell = [[[customcell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.nameLbl.text = [nameArray objectAtIndex:indexPath.row];
	cell.desgn.text = [desgArray objectAtIndex:indexPath.row];
	return cell;
}


@end
