//
//  CommunityScreen.h
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StorePhotoInfo.h"
#import "StoreImageObj.h"
#import "PhotoHistory.h"

@interface CommunityScreen : UIViewController< UITableViewDelegate, UITableViewDataSource > {
	IBOutlet UITableView *communityTable;
	NSMutableArray *storeArray;
	NSMutableDictionary *storeDictonary;
	NSMutableArray *keyArray;
	NSMutableArray *namedickey;
}

@property(nonatomic,retain)IBOutlet UITableView *communityTable;
@property(nonatomic, retain) NSMutableArray *storeArray;

- (void) generateStoreDummyData;
/**
 *	@functionName	: stringToDate
 *	@parameters		:(NSString*) stringDate - date in string format
 *	@return			: (NSDate *)
 *	@description	: This method returns NSDate object for date in string format
 */
-(NSDate *)stringToDate:(NSString *)stringDate;
@end
