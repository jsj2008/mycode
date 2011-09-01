//
//  CustomCell.h
//  CustomCellTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
	UIImageView *checkImageView;
	UILabel *titleLabel;

}
@property(nonatomic,assign)UILabel *titleLabel;
@property(nonatomic,assign)UIImageView *checkImageView;

@end
