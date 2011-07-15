//
//  NotificationStatus.h
//  iShopShape
//
//  Created by Santosh B on 15/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NotificationStatus : NSObject {
	NSString *notificationId;
	int status;
}
@property (nonatomic,retain)NSString *notificationId;
@property (nonatomic) int status;
@end
