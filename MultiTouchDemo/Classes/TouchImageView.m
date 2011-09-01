//
//  TouchImageView.m
//  MultiTouchDemo
//
//  Created by Manish Nath on 5/29/08.
//  Copyright 2008 Apple Inc.. All rights reserved.
//

#import "TouchImageView.h"
#import "TouchImageView_Private.h"


@implementation TouchImageView
@synthesize parent;
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
	
    for (UITouch *touch in touches) {
        if (touch.tapCount >= 2) {
            [self.superview bringSubviewToFront:self];
        }
    }
	[parent setLastTouchTag:self.tag];
	
	
    [self updateOriginalTransformForTouches:[event touchesForView:self]];
    [self removeTouchesFromCache:touches];

    NSMutableSet *remainingTouches = [[[event touchesForView:self] mutableCopy] autorelease];
    [remainingTouches minusSet:touches];
    [self cacheBeginPointForTouches:remainingTouches];

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

@end
