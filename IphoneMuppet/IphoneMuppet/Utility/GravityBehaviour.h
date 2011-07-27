//
//  GravityBehaviour.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/4/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GravityBehaviour : NSObject <UIAccelerometerDelegate> {
    UIView *target;
}

@property (nonatomic, retain) UIView *target;

+ (void)applyTo:(UIView *)object;

- (void)apply;

@end
