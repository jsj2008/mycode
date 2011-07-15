//
//  CustomCalendarEvent.h
//  iShopShape
//
//  Created by Ayush on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarTouch.h"

@interface CustomCalendarEvent : UITableViewCell 
{
	UIImageView *ImageView;
	UILabel *titlename;
	UILabel *description;
}
@property(nonatomic,assign)UILabel *titlename;
@property(nonatomic,assign)UILabel *description;
@property(nonatomic,assign)UIImageView *ImageView;

/**
 *	@functionName	: setCellData
 *	@parameters		: (GuidesDetails*)localGuides
 *	@return			: void
 *	@description	: set the cell data
 */
- (void) setCellData: (NSString*)imageName size:(NSString *)sizeTitle;
@end

