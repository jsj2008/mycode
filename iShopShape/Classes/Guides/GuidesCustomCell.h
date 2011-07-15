//
//  GuidesCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guides.h"

@interface GuidesCustomCell : UITableViewCell {
	UILabel *title;
	UILabel *subTitle;
	UIImageView *guidesTumbnilImageView;
	UIImageView *playButtonImageView;
}
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *subTitle;
@property(nonatomic,retain)UIImageView *guidesTumbnilImageView;
@property(nonatomic,retain)UIImageView *playButtonImageView;

/**
 *	@functionName	: setCellData
 *	@parameters		: Guides
 *	@return			: void
 *	@description	: This method will populate guide summay to table cell.
 */
-(void) setCellData :(Guides*)localGuides;
@end
