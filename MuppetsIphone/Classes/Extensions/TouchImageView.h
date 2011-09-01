//
//  TouchImageView.h
//  MultiTouchDemo
//
//  Created by   on 2/8/11.
//  Copyright 2008 Apple Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchImageView : UIImageView {
    CGAffineTransform originalTransform;
    CFMutableDictionaryRef touchBeginPoints;
	
	CAShapeLayer *selection;

}

-(void)deleteSelectedImage;
-(BOOL)checkFrameinBounds:(TouchImageView *)t;
- (void)layoutSubviews;
-(void)showSelection;
- (void)setSelected:(BOOL)isselected;
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@end
