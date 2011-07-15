//
//  StoreImageObj.m
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StoreImageObj.h"


@implementation StoreImageObj

@synthesize imageName;
@synthesize imageDate;

-(id)initWithImageName:(NSString *)name onDate:(NSDate *)imgdate{
	
	self.imageName = name;//[name retain];
	self.imageDate = imgdate;//[imgdate retain];
	
	return self;
}

- (void) dealloc
{
	[imageName release];
	[imageDate release];
	[super dealloc];
}

-(NSString *)description{
	return [NSString stringWithFormat:@"Image name = %@ imagedate is = %@",imageName,imageDate];
}

@end
