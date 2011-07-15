//
//  iphone.h
//  project
//
//  Created by Ayush Goel on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> 

@interface list : UIViewController {
	UIWindow *window;
	IBOutlet UITableViewController *tableViewController;
	 UINavigationController *navigationController;
	NSMutableArray *nameArray;
	NSMutableArray *desgArray;
	NSMutableArray *idArray;
	NSString *databaseName;
	NSString *databasePath;
	int indexNumber;


}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *desgArray;
@property (nonatomic, retain) NSMutableArray *idArray;
@property (nonatomic, assign) int indexNumber;
-(IBAction) checkAndCreateDatabase;
-(IBAction) readFromDatabase;
@end







