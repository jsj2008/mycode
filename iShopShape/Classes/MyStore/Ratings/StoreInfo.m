//
//  StoreInfo.m
//  Graph_week
//
//  Created by sujeet on 12/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StoreInfo.h"


@implementation StoreInfo

@synthesize store_name;
@synthesize ratingPerWeek;
@synthesize avgRating;

-(void)dealloc{

	[store_name release];
	//[ratingPerWeek release];
	[avgRating release];
	[super dealloc];
}

-(id)initWithStoreName:(NSString *)name AndRatingForWeek:(NSMutableDictionary *)rating{
	
	self.store_name = name;
	self.ratingPerWeek = rating;
	return self;
}

@end
