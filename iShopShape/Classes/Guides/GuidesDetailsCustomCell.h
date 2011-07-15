//
//  GuidesDetailsCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 19/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuidesDetails.h"

@interface GuidesDetailsCustomCell : UITableViewCell {
	UILabel *subTitle;
	UIImageView *guidesTumbnilImageView;
}
@property(nonatomic,retain)UILabel *subTitle;
@property(nonatomic,retain)UIImageView *guidesTumbnilImageView;

/**
 *	@functionName	: setCellData
 *	@parameters		: (GuidesDetails*)localGuides
 *	@return			: void
 *	@description	: set the cell data
 */
-(void) setCellData :(GuidesDetails*)localGuides;
@end
