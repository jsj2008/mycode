//
//  GravityBehaviour.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/4/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "GravityBehaviour.h"


@implementation GravityBehaviour

@synthesize target;

- (void)dealloc{
    [target release];
    [super dealloc];
}

+ (void)applyTo:(UIView *)object{
    GravityBehaviour *_behaviour    = [GravityBehaviour new];
    _behaviour.target               = object;
    [_behaviour apply];
}

- (void)apply{
    UIAccelerometer *accel  = [UIAccelerometer sharedAccelerometer];
	accel.delegate          = self;
	accel.updateInterval    = 1.0f/10.0f;	
}

- (void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)acceleration {
    
}


@end
