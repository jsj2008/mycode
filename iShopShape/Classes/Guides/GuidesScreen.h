//
//  GuidesScreen.h
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GuidesScreen : UIViewController {
	IBOutlet UITableView *guidesTable;
	NSArray *guideList;
	NSArray *videoGuideList;
}
@property(nonatomic,retain)IBOutlet UITableView *guidesTable;

/**
 *	@functionName	: getAllGuides
 *	@parameters		: void
 *	@return			: void
 *	@description	: This method will populate list of all guides.
 */
- (void) getAllGuides;

/**
 *	@functionName	: getSelectedGuideInformation
 *	@parameters		: void
 *	@return			: void
 *	@description	: This method will populate details of specific guide.
 */
- (void) getSelectedGuideInformation;

- (void) getVideoGuideList;
@end
