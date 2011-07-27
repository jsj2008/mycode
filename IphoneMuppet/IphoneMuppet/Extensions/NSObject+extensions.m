//
//  NSObject+extensions.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "NSObject+extensions.h"


@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block 
          afterDelay:(NSTimeInterval)delay 
{
    block = [[block copy] autorelease];
    [self performSelector:@selector(fireBlockAfterDelay:) 
               withObject:block 
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}


@end
