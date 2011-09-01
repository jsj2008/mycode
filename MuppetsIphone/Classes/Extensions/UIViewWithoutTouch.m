//
//  UIViewWithoutTouch.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/15/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "UIViewWithoutTouch.h"


@implementation UIViewWithoutTouch

- (UIView *)hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return [hitView isKindOfClass:[UIViewWithoutTouch class]] ? nil : hitView;
}

- (void)dealloc {
    [super dealloc];
}

@end
