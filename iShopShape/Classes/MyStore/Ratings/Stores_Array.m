//
//  Stores_Array.m
//  Graph_week
//
//  Created by sujeet on 12/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Stores_Array.h"

@implementation Stores_Array
@synthesize storeArray;


-(id)initWithStores{
	storeArray=[[NSMutableArray alloc]init];
	[self createStoreData];
	
	return self;
}

- (void) createStoreData
{
	NSMutableDictionary *dicRatingPerWeek = [[NSMutableDictionary alloc]init];
	NSString *ratedate=@"01-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"08-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"15-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"22-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"29-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"07-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"14-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"21-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"28-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	StoreInfo *store = [[StoreInfo alloc]initWithStoreName:@"New York City" 
										  AndRatingForWeek: dicRatingPerWeek];
	store.avgRating = [self calCulateAvgRating:dicRatingPerWeek];
	[storeArray addObject:store];
	[store release];
	[dicRatingPerWeek release];
	//----------------------------------------
	dicRatingPerWeek = [[NSMutableDictionary alloc]init];
	ratedate=@"01-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"08-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"15-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"22-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"29-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"07-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"14-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"21-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"28-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	store = [[StoreInfo alloc]initWithStoreName:@"Bangkok" 
							   AndRatingForWeek: dicRatingPerWeek];
	store.avgRating = [self calCulateAvgRating:dicRatingPerWeek];
	[storeArray addObject:store];
	[store release];
	[dicRatingPerWeek release];
	//----------------------------------------
	dicRatingPerWeek = [[NSMutableDictionary alloc]init];
	ratedate=@"01-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"08-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"15-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"22-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"29-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"07-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"14-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"21-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"28-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	store = [[StoreInfo alloc]initWithStoreName:@"Berlin" 
							   AndRatingForWeek: dicRatingPerWeek];
	store.avgRating = [self calCulateAvgRating:dicRatingPerWeek];
	[storeArray addObject:store];
	[store release];
	[dicRatingPerWeek release];
	//----------------------------------------
	dicRatingPerWeek = [[NSMutableDictionary alloc]init];
	ratedate=@"01-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"08-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"15-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"22-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"29-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"07-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"14-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"21-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"28-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	store = [[StoreInfo alloc]initWithStoreName:@"Miami" 
							   AndRatingForWeek: dicRatingPerWeek];
	store.avgRating = [self calCulateAvgRating:dicRatingPerWeek];
	[storeArray addObject:store];
	[store release];
	[dicRatingPerWeek release];
	//----------------------------------------
	dicRatingPerWeek = [[NSMutableDictionary alloc]init];
	ratedate=@"01-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"08-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"15-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"22-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:2] forKey:[self stringToDate:ratedate]];
	ratedate=@"29-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:1] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"07-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"14-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"21-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"28-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	store = [[StoreInfo alloc]initWithStoreName:@"Moscow" 
							   AndRatingForWeek: dicRatingPerWeek];
	store.avgRating = [self calCulateAvgRating:dicRatingPerWeek];
	[storeArray addObject:store];
	[store release];
	[dicRatingPerWeek release];
	//----------------------------------------
	dicRatingPerWeek = [[NSMutableDictionary alloc]init];
	ratedate=@"01-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"08-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"15-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"22-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"29-08-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-09-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-10-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"07-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"14-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"21-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"28-11-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"05-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"12-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:3] forKey:[self stringToDate:ratedate]];
	ratedate=@"19-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"26-12-2010";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"03-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"10-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"17-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:5] forKey:[self stringToDate:ratedate]];
	ratedate=@"24-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	ratedate=@"31-01-2011";
	[dicRatingPerWeek setObject:[NSNumber numberWithInt:4] forKey:[self stringToDate:ratedate]];
	store = [[StoreInfo alloc]initWithStoreName:@"Paris" 
							   AndRatingForWeek: dicRatingPerWeek];
	store.avgRating = [self calCulateAvgRating:dicRatingPerWeek];
	[storeArray addObject:store];
	[store release];
	[dicRatingPerWeek release];
	
}

-(NSDate *)stringToDate:(NSString *)stringDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];  
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;
}
//-----------------------------------------------------------

-(NSNumber *)calCulateAvgRating:(NSMutableDictionary *)dic{
	float avg = 0;
	int count = [dic count];
	NSNumber * num ;
	NSMutableArray *keyArray = [ [NSMutableArray alloc]initWithArray:[dic allKeys] ];
	for (int i = 0; i < count; i++) 
	{
		avg = avg + [ [dic objectForKey:[keyArray objectAtIndex:i]] intValue];
	}
	int avgRound = 0;
	if(count != 0)
	{
		avg = avg/count;
		avgRound = round(avg);
	}
	num =  [NSNumber numberWithInt:avgRound];
	[keyArray release];
	return num;
}

-(void)dealloc{
	NSLog(@"Stores_Array---------------------Release");
	[storeArray release];
	[super dealloc];
}

@end

