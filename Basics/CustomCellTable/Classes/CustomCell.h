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
	UILabel *nameLbl;
	UILabel *ageLbl;
}
@property(nonatomic,assign)UILabel *nameLbl;
@property (nonatomic,assign)UILabel *ageLbl;
@end
