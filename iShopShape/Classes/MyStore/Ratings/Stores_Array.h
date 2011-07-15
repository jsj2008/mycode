//
//  Stores_Array.h
//  Graph_week
//
//  Created by sujeet on 12/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StoreInfo.h"


@interface Stores_Array : NSObject {
	NSMutableArray * storeArray;
}

@property(nonatomic, retain) NSMutableArray * storeArray;

/**
 *	@functionName	: initWithStores
 *	@parameters		: void
 *	@return			: (id)
 *	@description	: returns the Store_Array object
 */
-(id)initWithStores;

/**
 *	@functionName	: calCulateAvgRating
 *	@parameters		: (NSMutableDictionary *)dic
 *	@return			: (NSNumber *)
 *	@description	: returns the average rating of the store
 */
-(NSNumber *)calCulateAvgRating:(NSMutableDictionary *)dic;

-(NSDate *)stringToDate:(NSString *)stringDate;

- (void) createStoreData;
@end
