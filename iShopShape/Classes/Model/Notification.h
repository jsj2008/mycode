//
//  Notification.h
//  iShopShape
//
//  Created by Santosh B on 17/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Notification : NSObject {
	NSString *notificationId;
	NSString *notificationTitle;
	NSString *notificationImage;
	int position;
}
@property(nonatomic, retain) NSString* notificationId;
@property(nonatomic, retain) NSString *notificationTitle;
@property(nonatomic,retain) NSString *notificationImage;
@property(nonatomic)int position;
@end
