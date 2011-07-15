//
//  StoreInfo.m
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StorePhotoInfo.h"


@implementation StorePhotoInfo
@synthesize storeName;
@synthesize photohistoryArray;

-(id)initWithStoreName:(NSString *)storename withPhotoHistory:(NSMutableArray *)photohistory{
	
	self.storeName = storename;
	self.photohistoryArray = photohistory;//[photohistory retain];
	return self;
}

- (void) dealloc
{
	[storeName release];
	[photohistoryArray release];
	[super dealloc];
}

@end
