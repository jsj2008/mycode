//
//  GetStoreLists.h
//  iShopShape
//
//  Created by Santosh B on 20/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServiceHandler.h"

@protocol GetStoreListDelegate
/**
 *	@functionName	: getStoreList
 *	@parameters		: (NSArray *)storeList
 *	@return			: (void)
 *	@description	: to pass the parsed list to get store list
 */
- (void) getStoreList : (NSArray *)storeList;
@end

@interface GetStoreLists : NSObject<HTTPServiceHandlerDelegate> {
	id <GetStoreListDelegate> delegate;
}
@property(nonatomic,assign) id <GetStoreListDelegate> delegate;

/**
 *	@functionName	: accessStoreList
 *	@parameters		:
 *	@return			: (void)
 *	@description	: to get the store list
 */
- (void) accessStoreList;
@end
