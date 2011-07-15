//
//  iShopShapeAppDelegate.h
//  iShopShape
//
//  Created by Santosh B on 14/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServiceHandler.h"
#import "HTTPServicePOSTHandler.h"
#import "GetStoreLists.h"

@class iShopShapeViewController;
@class DatabaseHandler;
@interface iShopShapeAppDelegate : NSObject <UIApplicationDelegate, HTTPServiceHandlerDelegate,HTTPServicePOSTHandlerDelegate, GetStoreListDelegate> {
    UIWindow *window;
    iShopShapeViewController *viewController;
	UINavigationController *navigationController;
	DatabaseHandler *databaseHandler;
	GetStoreLists *getStoreLists;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iShopShapeViewController *viewController;
@property (nonatomic, retain) UINavigationController *navigationController;

/**
 *	@functionName	: handleAPNSNotification
 *	@parameters		: (NSDictionary *)aDict
 *	@return			: (void)
 *	@description	: handle APNS Notifications
 */
- (void) handleAPNSNotification:(NSDictionary *)aDict;

/**
 *	@functionName	: handleDemoNotification
 *	@parameters		: (NSDictionary *)aDict
 *	@return			: (void)
 *	@description	: handle Demo Notifications
 */
- (void) handleDemoNotification:(NSDictionary *)aDict;

/**
 *	@functionName	: continousPingToServer
 *	@parameters		:
 *	@return			: (void)
 *	@description	: continous Ping to Server to check for new instruction or notification
 */
- (void) continousPingToServer;

/**
 *	@functionName	: deleteDueInstructions
 *	@parameters		:
 *	@return			: (void)
 *	@description	: delete due Instructions
 */
- (void) deleteDueInstructions;

/**
 *	@functionName	: getDeviceIdentifier
 *	@parameters		:
 *	@return			: (NSString *)
 *	@description	: TO get the device indentifier
 */
- (NSString *) getDeviceIdentifier;
@end

