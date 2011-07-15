//
//  GridViewViewController.h
//  GridView
//
//  Created by Ayush on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface GridViewViewController : UIViewController 
{
	
	UIButton *button;
	NSMutableArray *buttonArray;

}
/**
 *	@functionName	: rowNo
 *	@parameters		: (int )count
 *	@return			: (int)
 *	@description	: return row number in integer format
 */
-(int)rowNo:(int ) count;
/**
 *	@functionName	: colNo
 *	@parameters		: (int )count
 *	@return			: (int)
 *	@description	: return column number in integer format
 */
-(int)colNo:(int ) count;
/**
 *	@functionName	: onButtonClick
 *	@parameters		: Generic Object
 *	@return			: (void)
 *	@description	: remove the clicked button and realingns the remaining button
 */
-(void) onButtonClick:(id) sender;

-(void) setAnimation :(int) position:(int) AnimationCounter:(UIButton *) tempButton;



@end

