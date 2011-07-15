//
//  PhotoHistoryCountCell.h
//  iShopShape
//
//  Created by Santosh B on 18/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoHistoryCountCell : UITableViewCell {
	UILabel *countLable;
}
@property(nonatomic,assign)UILabel *countLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier total:(int)total;
@end
