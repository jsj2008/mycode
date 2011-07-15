//
//  MyStoreCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 15/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyStoreCustomCell : UITableViewCell {
	UIImageView *menuIconImageView;
	UILabel *menuNameLbl;
	UIImageView *ratingStarImageView;
}
@property(nonatomic,retain)UILabel *menuNameLbl;
@property(nonatomic,retain)UIImageView *menuIconImageView;
@property(nonatomic,retain)UIImageView *ratingStarImageView;
@end
