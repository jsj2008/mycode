//
//  DurationDetailsCell.h
//  iShopShape
//
//  Created by Santosh B on 04/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DurationDetailsCell : UITableViewCell {
	UILabel *durationLbl;
	UILabel *startDateLbl;
	UILabel *endDateLbl;
}
@property (nonatomic, retain) UILabel *durationLbl;
@property (nonatomic, retain) UILabel *startDateLbl;
@property (nonatomic, retain) UILabel *endDateLbl;

/**
 *	@functionName	: setDurationData
 *	@parameters		: (NSString *)startDate
 *					: (NSString*)endDate
 *	@return			: (void)
 *	@description	: set duration data with end date and start date
 */
- (void) setDurationData: (NSString *)startDate endDate:(NSString*)endDate;

/**
 *	@functionName	: setCommentsData
 *	@parameters		: (NSString *)comments
 *	@return			: (void)
 *	@description	: set the content of the costum cell with comments details
 */
//- (void) setCommentsData: (NSString *)comments;
@end
