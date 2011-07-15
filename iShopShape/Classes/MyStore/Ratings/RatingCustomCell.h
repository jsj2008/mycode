//
//  RatingCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 31/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RatingCustomCell : UITableViewCell {
	UILabel *nameLbl;
	UIImageView *starImageView;
}
@property(nonatomic,retain) UILabel *nameLbl;
@property(nonatomic,retain) UIImageView *starImageView;
@end
