//
//  EventHandler.h
//  iShopShape
//
//  Created by Santosh B on 28/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventHandler : NSObject {

}
- (void) insertEventInPendingList :guid category : (int)category;

- (void) updateBadgeNumber : (int)aNumber;

+ (int) getBadgeNumber;

@end
