//
//  MessageStreamCellInst.h
//  iShopShape
//
//  Created by Santosh B on 04/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MessageStreamCellInst : UITableViewCell {
	UIImageView *imageView;
	UILabel *messageLabel;
}
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UILabel *messageLabel;
@end
