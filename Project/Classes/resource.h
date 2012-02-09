//
//  resource.h
//  project
//
//  Created by Ayush Goel on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> 


@interface resource : UIViewController {
	
	UIWindow *window;
	IBOutlet UITableViewController *tableViewController;
	NSMutableArray *nameArray;
	NSMutableArray *desgArray;
	NSMutableArray *idArray;
	NSString *databaseName;
	NSString *databasePath;
		
}
@property (nonatomic, strong) IBOutlet UIWindow *window;
-(IBAction) checkAndCreateDatabase;
-(IBAction) readFromDatabase;

@end
