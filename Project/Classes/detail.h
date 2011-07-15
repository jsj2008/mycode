//
//  detail.h
//  project
//
//  Created by Ayush Goel on 12/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> 

@interface detail : UIViewController {
	UIWindow *window;
	UINavigationController *navigationController;
	NSString *databaseName;
	NSString *databasePath;
	int indexNumber;
	IBOutlet UITextField *fname;
	IBOutlet UITextField *lname;
	IBOutlet UITextField *desg;
	IBOutlet UITextField *seat;
	IBOutlet UITextField *dept;
	IBOutlet UISwitch *gender;
	IBOutlet UISlider *ex;

}

@property (nonatomic, retain) IBOutlet UITextField *fname;
@property (nonatomic, retain) IBOutlet UITextField *lname;
@property (nonatomic, retain) IBOutlet UITextField *desg;
@property (nonatomic, retain) IBOutlet UITextField *seat;
@property (nonatomic, retain) IBOutlet UITextField *dept;
@property (nonatomic, retain) IBOutlet UISlider *ex;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISwitch *gender;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, assign) int indexNumber;
-(IBAction) checkAndCreateDatabase;
-(IBAction) readFromDatabase;


@end
