//
//  UIVBoxScrollView.m
//  OpenTable
//
//  Created by Gaurav Sharma on 7/26/10.
//  Copyright 2010 Sequence. All rights reserved.
//

#import "UIView+extensions.h"

#define kUIVBoxViewVerticalMargin   10.0f
#define kScaleAnimationDuration     0.5f
#define kScreenWidth                1024.0f
#define kScreenHeight               748.0f
#define kNavigationAnimationTransitionDuration 0.5f

@implementation UIView (UIView_extensions)

- (void)relayoutChildrenHorizontally{
	[self relayoutChildrenHorizontallyWithMargin:kUIVBoxViewVerticalMargin];
}

- (void)relayoutChildrenHorizontallyWithMargin:(float)margin{
	float _controlPosition	= margin;
	CGRect _frame;

	for (UIView *_child in [self subviews]) {
		if (!_child.hidden && _child.alpha != 0.0f) {
			_frame				= _child.frame;
			_frame.origin.x		= _controlPosition;
			_child.frame		= _frame;
			_controlPosition    += margin + _frame.size.width;
		}
	}

	if ([self isKindOfClass:[UIScrollView class]])
		[(UIScrollView *)self setContentSize:CGSizeMake(_controlPosition, self.frame.size.height)];
}

- (UIImage *)captureImage { 
	CGRect screenRect = self.frame;
	UIGraphicsBeginImageContext(screenRect.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext(); 
	[[UIColor clearColor] set]; 
	CGContextFillRect(ctx, screenRect);
	[self.layer renderInContext:ctx];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return [newImage retain]; 
}

- (void)fullScreenTranfrom{
    float _scaleX       = kScreenWidth/self.frame.size.width * 1.3f;
    float _scaleY       = kScreenHeight/self.frame.size.height * 1.3f;
    float _translateX   = kScreenWidth/2 - self.center.x;
    float _translateY   = kScreenHeight/2 - self.center.y;
    float _rotation     = 0.0f;

    CGAffineTransform _new_transform    = CGAffineTransformMakeRotation(degreesToRadian(_rotation));
    _new_transform                      = CGAffineTransformTranslate(_new_transform, _translateX, _translateY);
    _new_transform                      = CGAffineTransformScale(_new_transform, _scaleX, _scaleY);

    self.transform = _new_transform;
}

- (void)animateToFullScreenWithRootView:(UIView *)rootView andBlock:(void (^)(id))block{
    CGAffineTransform _transform = self.transform;
    self.transform               = CGAffineTransformIdentity;

    UIImage *_image         = [self captureImage];
    UIView *_parentView     = self.superview;
    UIImageView *_imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.frame        = [_parentView convertRect:self.frame toView:rootView];
    _imageView.transform    = self.transform = _transform;
    [rootView addSubview:_imageView];
    self.hidden = YES;

    [UIView animateWithDuration:kScaleAnimationDuration animations:^{
                         [_imageView fullScreenTranfrom];
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:kScaleAnimationDuration/2
                                          animations:^{
                                              _imageView.alpha = 0.0f;
                                              block(_imageView); 
                                              [_imageView release];
                                          } completion:^(BOOL finished){
                                              [_imageView removeFromSuperview];
                                              _imageView.alpha      = 1.0f;
                                              _imageView.hidden     = YES;
                                              _imageView.transform  = _transform;
                                              self.hidden           = NO;
                                          }];
                     }];
}

- (void)animateToOriginalPositionWithRootView:(UIView *)rootView andBlock:(void (^)(id))block{
    UIImageView *_imageView         = (UIImageView *)self;
    CGAffineTransform _transform    = _imageView.transform;
    _imageView.hidden               = NO;
    _imageView.alpha                = 0.0f;
    [_imageView fullScreenTranfrom];

    [UIView animateWithDuration:kScaleAnimationDuration/2
                     animations:^{
                         _imageView.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:kScaleAnimationDuration
                                          animations:^{
                                              _imageView.transform = _transform;
                                              block(_imageView); 
                                          }];
                     }];
}

- (void)bounceToIdentityTransfromWithBlock:(void (^)(void))block{
    [UIView animateWithDuration:kScaleAnimationDuration/2
                          delay:0.0f 
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:kScaleAnimationDuration
                                               delay:0.0f 
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              self.transform = CGAffineTransformIdentity;
                                          } completion:^(BOOL finished){
                                              block();
                                          }];
                     }];
}

- (BOOL)arrangeChildrenInGridWithRows:(int)rows andColumns:(int)columns animated:(BOOL)animated{
    if ([self.subviews count] > rows*columns) {
        return NO;
    }

    int width           = self.frame.size.width;
    int height          = self.frame.size.height;
    int tileWidth       = width/columns;
    int tileHeight      = height/rows;

    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    }
    
    int _childIndex = 0;

    for (int row=0; row < rows; row++) {
        for (int col=0; col < columns; col++) {
            if (_childIndex < [self.subviews count]) {
                UIView *_view   = [self.subviews objectAtIndex:_childIndex];
                int _centerX    = tileWidth*col + tileWidth/2;
                int _centerY    = tileHeight*row + tileHeight/2;
                _view.center    = CGPointMake(_centerX, _centerY);
            }
            _childIndex ++;
        }
    }

    if (animated) {
        [UIView commitAnimations];
    }

    return YES;
}

- (void)animateWithTransition:(NSString *)transition{
    if (!animationsDisabled()) {
        CATransition *_transition	= [CATransition animation];
        _transition.duration		= kNavigationAnimationTransitionDuration;
        _transition.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _transition.type			= transition;
        [[self layer] addAnimation:_transition forKey:nil];
    }
}

@end