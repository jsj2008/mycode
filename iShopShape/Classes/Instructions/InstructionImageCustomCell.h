//
//  InstructionImageCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instruction.h"
#import "ImageDownloader.h"
#import "CustomPlacementImageView.h"

@interface InstructionImageCustomCell : UITableViewCell<ImageDownloaderDelegate> {
	UIImageView *imageView;
	UIImageView *arrowImageView;
	ImageDownloader *imgDownloader;
	Instruction *instruction;
	UIActivityIndicatorView *activityIndicator;
	BOOL isDownloading;
	
	UIScrollView *firstScrollView;
	UIView * imageViewHolder;
	CustomPlacementImageView *customImageView;
	CGRect imageViewHolderFrame;
	BOOL done;
}
@property(nonatomic,retain) UIImageView *imageView;

/**
 *	@functionName	: setCellData
 *	@parameters		: Instruction*)localInstruction
 *	@return			: (void)
 *	@description	: set the content of the costum cell with instruction details
 */
-(void) setCellData :(Instruction*)localInstruction;

- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
