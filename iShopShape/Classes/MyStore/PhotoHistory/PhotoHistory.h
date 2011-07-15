//
//  PhotoHistory.h
//  iShopShape
//
//  Created by Santosh B on 03/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostumCell.h"
#import "StoreImageObj.h"

@interface PhotoHistory : UIViewController <CostumCellDelegate>{
	
	IBOutlet UITableView *photoHistoryTableView;
	
	
	NSMutableArray *pics;
	NSArray *sortedArrayPic;
	NSArray *sortedPicDicKey ;
	NSDate *refdate;
	int totalTableHeight;
	
}
@property(nonatomic, retain)NSMutableArray *pics;
@property(nonatomic, retain) NSArray *sortedArrayPic;
@property(nonatomic, assign) NSMutableDictionary *picDictionary;
@property(nonatomic,retain) NSArray * sortedPicDicKey;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil picArray:(NSMutableArray*)pictures;

/**
 *	@functionName	: arrayOfImageFrom
 *	@parameters		: (NSDate *)fromdatepage 
 : (NSDate *)tilldate 
 *	@return			: (NSMutableArray *)
 *	@description	: Returns the array of image between the date
 */
-(NSMutableArray *)arrayOfImageFrom:(NSDate *)fromdate till:(NSDate *)tilldate;

/**
 *	@functionName	: arrayOfImageForWeek
 *	@parameters		: (int)week
 *	@return			: (NSMutableArray *)
 *	@description	: Returns the array of image for the given date
 */
-(NSMutableArray *)arrayOfImageForWeek:(int)week;

/**
 *	@functionName	: weekday
 *	@parameters		: (NSDate *)from
 *	@return			: (NSInteger )
 *	@description	: return the weekday no of the date
 */
-(NSInteger )weekday:(NSDate *)from;

/**
 *	@functionName	: setDate
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: set the reference date
 */
-(void) setDate;

@end
