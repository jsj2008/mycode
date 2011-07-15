//
//  InstructionMessageStreamCell.h
//  iShopShape
//
//  Created by Santosh B on 29/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InstructionMessageStreamCellDelegate
-(void) cameraButtonActionDelegate;
@end

@interface InstructionMessageStreamCell : UITableViewCell {
	id <InstructionMessageStreamCellDelegate> delegate;
	UIButton *cameraButton;
	UIImageView *imageView;
	UIImageView *bgView;
}
@property(nonatomic,retain) UIButton *cameraButton;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,assign) id <InstructionMessageStreamCellDelegate> delegate;
@end
