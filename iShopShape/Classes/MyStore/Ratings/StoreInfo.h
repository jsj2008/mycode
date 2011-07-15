//
//  StoreInfo.h
//  Graph_week
//
//  Created by sujeet on 12/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoreInfo : NSObject {
	
	NSString *store_name;
	NSMutableDictionary *ratingPerWeek;
	NSNumber *avgRating;

}

@property(nonatomic,retain) NSString *store_name;
@property(nonatomic, retain) NSMutableDictionary *ratingPerWeek;
@property(nonatomic, retain) NSNumber *avgRating;


/**
 *	@functionName	: initWithStoreName
 *	@parameters		: (NSString *)name
 *					  (NSMutableDictionary *)ratings
 *	@return			: (NSNumber *)
 *	@description	: returns the StoreInfo object
 */
-(id)initWithStoreName:(NSString *)name AndRatingForWeek:(NSMutableDictionary *)rating;

@end
