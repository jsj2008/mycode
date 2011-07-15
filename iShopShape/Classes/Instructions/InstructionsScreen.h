//
//  InstructionsScreen.h
//  iShopShape
//
//  Created by Santosh B on 15/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServiceHandler.h"

@interface InstructionsScreen : UIViewController<HTTPServiceHandlerDelegate> {
	IBOutlet UITableView *instructionsTable;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSArray *instructionList;
	int noDays;
}
@property(nonatomic,retain)IBOutlet UITableView *instructionsTable;

/**
 *	@functionName	: getInstructionDetailsFromServer
 *	@parameters		: (NSString *)instructionID
 *	@return			: (void)
 *	@description	: get Instruction Details From Server for the first time
 */
- (void) getInstructionDetailsFromServer : (NSString *)instructionID;

/**
 *	@functionName	: loadInstructionFromLocalDatabase
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: load Instruction From Local Database when getting back to the same screen
 */
- (void) loadInstructionFromLocalDatabase;
@end
