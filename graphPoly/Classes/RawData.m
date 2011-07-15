//
//  RawData.m
//  graphTest
//
//  Created by Yogesh Bhople on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RawData.h"


@implementation RawData

@synthesize weekRatingData;
@synthesize month;

- (void)dealloc {
	[weekRatingData release];
    [super dealloc];
} 

@end
