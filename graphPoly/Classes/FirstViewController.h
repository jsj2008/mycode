//
//  FirstViewController.h
//  graphTest
//
//  Created by Yogesh Bhople on 30/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	NSMutableArray* secArr;
	NSMutableArray* firArr;
	NSMutableArray *myArray;
	GraphView* vw;
	CGRect gpRect;
}
-(void)  reload:(int) choice;
//@property (assign) IBOutlet UITableView* myTableView;

@end
