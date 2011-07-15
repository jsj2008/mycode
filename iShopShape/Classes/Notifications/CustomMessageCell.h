//
//  CustomCell.h
//  SMS Bubbles
//
//  Created by Ayush Goel on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomMessageCell : UITableViewCell {

	UIImageView *balloonView;
	UIImageView *ImageView;
	UIView *message;
	UILabel *label;
	
}

@property(nonatomic,assign)UIImageView *balloonView;
@property(nonatomic,assign)UIImageView *ImageView;
@property(nonatomic,assign)UIView *message;
@property(nonatomic,assign)UILabel *label;




@end
