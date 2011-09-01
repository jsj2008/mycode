//
//  Physics.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/4/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chipmunk.h"

@interface Physics : NSObject {
    cpSpace *space;
    NSTimer *gameTimer;
    BOOL gameTimerDisabled;
    UIView *rootView;
}

@property (nonatomic, assign) UIView *rootView;

+ (Physics*)shared;
- (void)addPhysicalObject:(UIView *)viewObject;

@end
