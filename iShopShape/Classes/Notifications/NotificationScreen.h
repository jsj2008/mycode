//
//  NotificationScreen.h
//  iShopShape
//
//  Created by Santosh B on 22/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServiceHandler.h"

@interface NotificationScreen : UIViewController <HTTPServiceHandlerDelegate>{
	IBOutlet UITableView *notificationsTable;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSArray *notificationList;
	NSDictionary *statusDictionary;
	NSMutableArray *titleArray;
}
@property(nonatomic,retain)IBOutlet UITableView *notificationsTable;

/**
 *	@functionName	: loadNotificationsFromLocalDatabase
 *	@parameters		:
 *	@return			: (void)
 *	@description	: load notifications from local database
 */
- (void) loadNotificationsFromLocalDatabase;

/**
 *	@functionName	: getNotificationDetailsFromServer
 *	@parameters		: (NSString *)instructionID
 *	@return			: (void)
 *	@description	: get notification details from server
 */
- (void) getNotificationDetailsFromServer : (NSString *)instructionID;
@end
