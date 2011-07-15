//
//  Graph.h
//  Graph_week
//
//  Created by sujeet on 12/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreInfo.h"
#import <math.h>

@interface Graph : UIView {
	
	NSString* storeName;
	NSNumber* storeRating;
	
	StoreInfo *myStore;
	StoreInfo *selectedStore;
	
	int xAxisYpos;

}

- (id)initWithFrame:(CGRect)frame WithStore:(StoreInfo *)mystore AndSelectedStore:(StoreInfo *)selectedstore;

/**
 *	@functionName	: DrawBackground
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: set the background color of the graphview
 */
-(void) DrawBackground;

/**
 *	@functionName	: DrawRating
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: set the ratings graphview
 */
-(void) DrawRating;

/**
 *	@functionName	: getSize
 *	@parameters		: (NSString*) string
 *	@return			: (CGSize)
 *	@description	: return the size of the string in CGSize
 */
- (CGSize) getSize:(NSString*) string;

/**
 *	@functionName	: DrawGraphAxis
 *	@parameters		: (CGRect)rect
 *	@return			: (void)
 *	@description	: Draw the x axis  month label rating star on the y axis and the graph of the selected and my store
 */
-(void) DrawGraphAxis:(CGRect)rect;

/**
 *	@functionName	: DrawGraphSecond
 *	@parameters		: (CGPoint[]) graphPosArray - array of the point coressponding to the rating per week
 *					: (UIColor*) color - color of the graph line 
 *					: (int)count - no of the points generated corresponding to the rating per week
 *	@return			: (void)
 *	@description	: draw the graph from the given array of CGPoint
 */
-(void) DrawGraphSecond:(CGPoint[]) graphPosArray graphcolor:(UIColor*) color withCount:(int)count;

/**
 *	@functionName	: DrawGraphWithGradent
 *	@parameters		: (CGPoint[]) graphPosArray - array of the point coressponding to the rating per week
 *					: (UIColor*) color - color of the graph line 
 *					: (int)count - no of the points generated corresponding to the rating per week
 *					: (int) selectedColor - to make a choice from the array of color
 *	@return			: (void)
 *	@description	: reload the graph of the selected store on the screen
 */
-(void) DrawGraphWithGradent:(CGPoint[]) graphPosArray graphcolor:(UIColor*) color  colorCh:(int) selectedColor withCount:(int)count;

@end
