//
//  NotificationCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 15/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NotificationCustomCell : UITableViewCell {
	UILabel *menuNameLbl;
	UILabel *badgeNumberLbl;
	UIImageView *menuIconImageView;
	UIImageView *badgeNumberBackgroundView;
}
@property(nonatomic,retain)UILabel *menuNameLbl;
@property(nonatomic,retain)UIImageView *menuIconImageView;
@property(nonatomic,retain)UILabel *badgeNumberLbl;
@property(nonatomic,retain)UIImageView *badgeNumberBackgroundView;
@end
