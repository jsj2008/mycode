//
//  APNSEventHandler.h
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APNSEventHandler : NSObject {
	UIAlertView *alert;
}
- (void) decideNotificationHandler : (NSDictionary*)dict;
- (void) updateApplicationBadgeNumber;

- (void) handleDemoNotification:(NSMutableArray *)aArray;
@end
