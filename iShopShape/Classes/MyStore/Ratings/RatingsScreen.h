//
//  RatingsScreen.h
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoreInfo.h"
#import "Stores_Array.h"
#import "Graph.h"

@interface RatingsScreen : UIViewController {
	UIImageView *graphBackgroundView;
	IBOutlet UITableView *storesTable;
	Stores_Array *storesArray;
	Graph *graph ;
	CGRect frame ;
	NSIndexPath *selectedIndex;
}
@property (nonatomic, retain) Stores_Array *storesArray;

/**
 *	@functionName	: reload
 *	@parameters		: (int) choice 
 *	@return			: (void)
 *	@description	: reload the graph of the selected store on the screen
 */
-(void)  reload:(int) choice;

@end
