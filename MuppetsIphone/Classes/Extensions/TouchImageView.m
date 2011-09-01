//
//  TouchImageView.m
//  MultiTouchDemo
//
//  Created by Manish Nath on 2/8/11.
//  Copyright 2008 Apple Inc.. All rights reserved.
//

#import "TouchImageView.h"
#import "TouchImageView_Private.h"
#include <execinfo.h>
#include <stdio.h>

@implementation TouchImageView
@synthesize selected;
- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame] == nil) {
        return nil;
    }

    originalTransform = CGAffineTransformIdentity;
    touchBeginPoints = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    self.exclusiveTouch = YES;

    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    NSMutableSet *currentTouches = [[[event touchesForView:self] mutableCopy] autorelease];
    [currentTouches minusSet:touches];
    if ([currentTouches count] > 0) {
        [self updateOriginalTransformForTouches:currentTouches];
        [self cacheBeginPointForTouches:currentTouches];
    }
    [self cacheBeginPointForTouches:touches];
}
-(BOOL)checkFrameinBounds:(TouchImageView *)t
{
	if(t.frame.origin.x < [t superview].frame.origin.x || t.frame.origin.x+t.frame.size.width > [t superview].frame.origin.x + [t superview].frame.size.width
	   || t.frame.origin.y < [t superview].frame.origin.y || t.frame.origin.y+t.frame.size.height > [t superview].frame.origin.y + [t superview].frame.size.height)
		return NO;
	return YES;
	   
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	CGAffineTransform incrementalTransform = [self incrementalTransformWithTouches:[event touchesForView:self]];
    self.transform = CGAffineTransformConcat(originalTransform, incrementalTransform);
	

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//if ([self checkFrameinBounds:self]) {
    for (UITouch *touch in touches) {
        if (touch.tapCount >= 2) {
            [self.superview bringSubviewToFront:self];
        }
    }
		
	
    [self updateOriginalTransformForTouches:[event touchesForView:self]];
    [self removeTouchesFromCache:touches];

    NSMutableSet *remainingTouches = [[[event touchesForView:self] mutableCopy] autorelease];
    [remainingTouches minusSet:touches];
    [self cacheBeginPointForTouches:remainingTouches];
	//}
}

-(void)deleteSelectedImage
{
	NSLog(@"deleteSelectedImage");
	[self removeFromSuperview];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)dealloc
{
    CFRelease(touchBeginPoints);
    
    [super dealloc];
}

- (void)layoutSubviews
{
    
        
                
        selection                   = [[CAShapeLayer layer] retain];
        selection.fillColor         = [[UIColor clearColor] CGColor];
        selection.strokeColor       = [[UIColor yellowColor] CGColor];
        selection.lineWidth         = 2.0f;
        selection.lineJoin          = kCALineJoinRound;
        selection.lineDashPattern   = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:10], nil];
        selection.position          = CGPointMake(0, 0);
        selection.hidden            = YES;
        
        [[self layer] addSublayer:selection];
    }


-(void)showSelection {
    if (![selection actionForKey:@"linePhase"]) {
        CABasicAnimation *dashAnimation;
        dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
        [dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
        [dashAnimation setToValue:[NSNumber numberWithFloat:20.0f]];
        [dashAnimation setDuration:0.25f];
        [dashAnimation setRepeatCount:HUGE_VALF];
        [selection addAnimation:dashAnimation forKey:@"linePhase"];
    }
    
    [selection setBounds:CGRectMake(0, 0, 0, 0)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    [selection setPath:path];
    CGPathRelease(path);
}

- (void)setSelected:(BOOL)isselected{
    selected = isselected;
    if (selected) {
        [self showSelection];
    }
    selection.hidden = !isselected;
}


@end
