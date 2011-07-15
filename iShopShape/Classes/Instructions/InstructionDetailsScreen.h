//
//  InstructionDetailsScreen.h
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstructionMessageStreamCell.h"
#import "Instruction.h"

@interface InstructionDetailsScreen : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,InstructionMessageStreamCellDelegate>{
	Instruction *instruction;
	IBOutlet UITableView *instructionDetailsTable;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instruction: (Instruction*) aInstruction;

/**
 *	@functionName	: saveFileInResourcesFolder
 *	@parameters		: (UIImage *)image
 *	@return			: (void)
 *	@description	: save File In Resources Folder
 */
- (void) saveFileInResourcesFolder:(UIImage *)image;
@end
