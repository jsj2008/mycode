//
//  NotificationTableCell.h
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NotificationTableCell : UITableViewCell {
	UILabel *notificationLable;
	UIView *bgView;
}
@property(nonatomic,retain) UILabel *notificationLable;
@property(nonatomic,retain) UIView *bgView;

- (void) setCellData : (NSString*)aString;
@end
