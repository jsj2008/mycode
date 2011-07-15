//
//  RootViewController.h
//  SMS Bubbles
//
//  Created by Santosh B on 1/12/10.
//  Copyright Cybage 2010. All rights reserved.
//
#import "Database.h"
#import "Message.h"

@interface RootViewController : UIViewController {
	IBOutlet UITableView *tbl;
	IBOutlet UITextField *field;
	IBOutlet UIToolbar *toolbar;
	NSMutableArray *messagearray;
	Database *DatabaseHandler;
	Message *m;
	int count;
}

- (IBAction)add;

@property (nonatomic, retain) UITableView *tbl;
@property (nonatomic, retain) UITextField *field;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) NSMutableArray *messagearray;

@end
