//
//  InstructionsCutomCell.h
//  iShopShape
//
//  Created by Santosh B on 16/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instruction.h"
#import "ImageDownloader.h"
#import "HTTPServicePOSTHandler.h"
#import "ImageDownloaderBackground.h"

@interface InstructionsCutomCell : UITableViewCell <ImageDownloaderDelegate, HTTPServicePOSTHandlerDelegate> {
	UILabel *instructionNameLbl;
	UILabel *dueStatusLbl;
	UIImageView *instructionImageView;
	UIImageView *instructionBorderImageView;
	UIActivityIndicatorView *activityIndicator;
	UIButton *statusDoneButton;
	Instruction *instruction;
	ImageDownloader *imgDownloader;
	ImageDownloaderBackground *imgDownloaderBg;
	BOOL isDownloading;
	BOOL isActualImageDownloading;
	HTTPServicePOSTHandler *HTTPServicePOSTHandlerObj;
}
@property(nonatomic,retain)UILabel *instructionNameLbl;
@property(nonatomic,retain)UILabel *dueStatusLbl;
@property(nonatomic,retain)UIImageView *instructionImageView;
@property(nonatomic,retain)UIButton *statusDoneButton;
@property(nonatomic,retain)ImageDownloader *imgDownloader;

/**
 *	@functionName	: setCellData
 *	@parameters		: Instruction
 *	@return			: void
 *	@description	: This method will populate instruction summay to table cell.
 */
-(void) setCellData :(Instruction*)localInstruction;

/**
 *	@functionName	: isInstructionImageExistInCache
 *	@parameters		: 
 *	@return			: (BOOL)
 *	@description	: check if Instruction Images Exist In Cache
 */
- (BOOL) isInstructionImageExistInCache;

- (void) setButtonCurrentStatus;
@end
