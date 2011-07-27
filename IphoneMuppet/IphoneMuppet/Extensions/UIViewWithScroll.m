//
//  UIViewWithScroll.m
//  HarmonyPrototype
//
//  Created by Gaurav Sharma on 4/18/11.
//  Copyright 2011 Vinsol. All rights reserved.
//

#import "UIViewWithScroll.h"


@implementation UIViewWithScroll

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return [self.subviews objectAtIndex:0];
    }
    return nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
