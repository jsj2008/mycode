//
//  iShopShapeViewController.h
//  iShopShape
//
//  Created by Santosh B on 14/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

enum HOME_MENU {
		NOTIFICATIONS,
		INSTRUCTIONS,
		CALENDAR,
		GUIDES,
		MYSTORE,
		COMMUNITY
};

enum ROWS_PER_SECTION {
	FIRST,
	SECOND,
	THIRD,
	FOURTH
};

@interface iShopShapeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> 
{
	IBOutlet UITableView *homeMenuTable;
}
@property(nonatomic,retain) IBOutlet UITableView *homeMenuTable;

/**
 *	@functionName	: settingsButtonAction
 *	@parameters		:
 *	@return			: (IBAction)
 *	@description	: To perform action corresponding to setting button touch event
 */
-(IBAction) settingsButtonAction :(id) sender;
@end

