//
//  GuidesDetails.m
//  iShopShape
//
//  Created by Santosh B on 19/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "GuidesDetails.h"


@implementation GuidesDetails
@synthesize stepName, stepImageName;

- (void)dealloc
{
	[stepName release];
	[stepImageName release];
	[super dealloc];
}
@end
