//
//  UIVBoxScrollView.h
//  OpenTable
//
//  Created by Gaurav Sharma on 7/26/10.
//  Copyright 2010 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (UIView_extensions)
- (void)relayoutChildrenHorizontally;
- (void)relayoutChildrenHorizontallyWithMargin:(float)margin;
- (UIImage *)captureImage;
- (void)animateToFullScreenWithRootView:(UIView *)rootView andBlock:(void (^)(id))block;
- (void)animateToOriginalPositionWithRootView:(UIView *)rootView andBlock:(void (^)(id))block;
- (void)bounceToIdentityTransfromWithBlock:(void (^)(void))block;
- (BOOL)arrangeChildrenInGridWithRows:(int)rows andColumns:(int)columns animated:(BOOL)animated;
- (void)animateWithTransition:(NSString *)transition;
@end
