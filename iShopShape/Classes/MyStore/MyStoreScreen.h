//
//  MyStoreScreen.h
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServiceHandler.h"

@interface MyStoreScreen : UIViewController<HTTPServiceHandlerDelegate> {
	IBOutlet UITableView *myStoreTableView;
	int currentWeekRatings;
	HTTPServiceHandler *HTTPServiceHandlerObj;
	NSMutableDictionary *picDictionary;
}

@end
