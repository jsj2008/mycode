//
//  CustomCell.h
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostumImageView.h"
@protocol CostumCellDelegate

/**
 *	@functionName	: CostumCellImageTouchEvent
 *	@parameters		: (int)aIndex 
 *					: (int)weekKey
 *	@return			: (void)
 *	@description	: method to pass the indexno and weekKey to the delegate object of the CostumCell
 */
- (void) CostumCellImageTouchEvent: (int)aIndex weekKey : (int)weekKey;
@end

@interface CostumCell : UITableViewCell <CostumImageTouchedDelegate> {
	
	NSMutableArray *arrayOfImageView;
	NSMutableArray *imagesArray;
	id <CostumCellDelegate> delegate;
	int weekKey;
}
@property(nonatomic,retain) NSMutableArray *arrayOfImageView;
@property(nonatomic,assign)id <CostumCellDelegate> delegate;
@property(nonatomic)int weekKey;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withImageArray:(NSMutableArray *)images withkey:(int)key;
- (void) setCellData : (NSArray *)array withKey:(int)key;
@end
