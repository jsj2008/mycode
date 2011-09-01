//
//  detail.m
//  project
//
//  Created by Ayush Goel on 12/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "detail.h"
#import "projectAppDelegate.h"

@implementation detail
@synthesize fname;
@synthesize lname;
@synthesize desg;
@synthesize seat;
@synthesize dept;
@synthesize gender;
@synthesize ex;
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
	    [fname setUserInteractionEnabled:NO];
		[lname setUserInteractionEnabled:NO];
		[desg	setUserInteractionEnabled:NO];
		[seat setUserInteractionEnabled:NO];
		[dept setUserInteractionEnabled:NO];
		[ex setUserInteractionEnabled:NO];

	databaseName = @"project.sql";
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
    [super viewDidLoad];
	
	[self checkAndCreateDatabase];
	
	[self readFromDatabase];
	((UILabel *)[[[[[[gender subviews] lastObject] subviews] objectAtIndex:2] subviews] objectAtIndex:0]).text = @"Yes";
	((UILabel *)[[[[[[gender subviews] lastObject] subviews] objectAtIndex:2] subviews] objectAtIndex:1]).text = @"No";
	
	
	
 
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

}

#pragma mark - UITableView delegate methods



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
	const char *str=@"";
	projectAppDelegate *del=[UIApplication sharedApplication].delegate;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		NSLog(@"in detail %d",del.idno);
		switch(del.idno)
		{
			case 0:
			{
				str = "select * from iphone where id =";
				break;
			}
				
			case 1:
			{
				str = "select * from blackberry where id =";
				break;
			}
				
			case 2:
			{
				str = "select * from android where id =";
				break;
			}
				
			case 3:
			{
				str = "select * from symbian where id =";
				break;
			}
				
				
		}
		
		NSString *str2 = [NSString stringWithFormat:@"%s%@",str,indexNumber];
		const char *sqlStatement = [str2 cStringUsingEncoding:[NSString defaultCStringEncoding]];
		NSLog(@"%s",sqlStatement);
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) {
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) {
			
				NSLog(@"value == %s",(char *)sqlite3_column_text(compiledStatement1, 1));
				fname.exclusiveTouch=NO;
				
				fname.text=[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)] capitalizedString];
				lname.text=[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)] capitalizedString];
				desg.text=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
				seat.text=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
				//gender.transform text =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,5)];
			    NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,6)];
				int id = [aName intValue];
			    ex.value=id;
				dept.text=[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 7)]capitalizedString];


				
			}
		}
		sqlite3_finalize(compiledStatement1);
		
	}
	sqlite3_close(database);
	
	
}







@end
