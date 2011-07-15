//
//  SettingsScreen.h
//  iShopShape
//
//  Created by Santosh B on 05/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HTTPServicePOSTHandler.h"

@interface SettingsScreen : UIViewController <HTTPServicePOSTHandlerDelegate>
{
	HTTPServicePOSTHandler *HTTPServicePOSTHandlerObj;
	IBOutlet UITableView *settingTable;
	NSArray *tableTitlArray;
}
///**
// *	@functionName	: clearCacheButtonAction
// *	@parameters		: (id)sender
// *	@return			: (IBAction)
// *	@description	: clear the old insrtruction from the cache
// */
//- (IBAction) clearCacheButtonAction : (id)sender;
//
///**
// *	@functionName	: unregisterUserButtonAction
// *	@parameters		: (id)sender
// *	@return			: (IBAction)
// *	@description	: unregister the IPhone device
// */
//- (IBAction) unregisterUserButtonAction : (id)sender;
@end
