//
//  Guides.m
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "Guides.h"


@implementation Guides
@synthesize guideTitle, guideSubTitle, guideImage, guideDetailsArray,guideNotes;

-(void)dealloc
{
	NSLog(@"Guides -------------- Release");
	[guideTitle release];
	[guideSubTitle release];
	[guideImage release];
	[guideDetailsArray release];
	[guideNotes release];
	[super dealloc];
}
@end
