//
//  SimpleTableViewController.h
//  SimpleTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableViewController : UIViewController {
	IBOutlet UITableViewController *tableViewController;
	NSMutableArray *dataArray;
	int selectedIndex;
	BOOL isSearching;
}

@end

