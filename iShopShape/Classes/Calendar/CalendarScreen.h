//
//  CalendarScreen.h
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"
#import "CalendarTouchEvent.h"

@interface CalendarScreen : UIViewController<UIScrollViewDelegate,CustomImageViewDelegate> {
	
	IBOutlet UIScrollView * WeekNoBar;
	IBOutlet UIScrollView * ImageBar;
	IBOutlet UIScrollView* LabelBar;
	IBOutlet UIImageView* strip;
	UIImageView *stripImageView;
	IBOutlet UIImageView *verticalstripImageView;
	UILabel * year;
	
	CustomImageView *customeview;
	CustomImageView *topview;
	CustomImageView *bottomview;
	
	
	UIImage *topImage;
	UIImage *middleImage;
	UIImage *bottomImage;
	
//	NSMutableArray *eventarray;
	NSMutableArray *keyArray;
	NSMutableArray *calanderEventDetailsArray;
	NSString *imagename;
	NSDate *globaldate;

	float startweek;
	float endweek;
	int globalweek;
		
	int currentyear;
	int yearcounter;

	int scrollDirection;

	CGPoint startPos;
}
@property(nonatomic,retain) UIScrollView  *WeekNoBar;
@property(nonatomic,retain) UIScrollView  *ImageBar;
@property(nonatomic,retain) UIScrollView *LabelBar;
@property(nonatomic) float ly2;

/**
 *	@functionName	: stringToDate
 *	@parameters		: (NSString *)stringDate
 *	@return			: (NSDate *)
 *	@description	: return NSDate from the date in string format
 */
-(NSDate *)stringToDate:(NSString *)stringDate;

/**
 *	@functionName	: weekno
 *	@parameters		: (NSDate *)from
 *					: (NSDate *)end
 *	@return			: (float)
 *	@description	: return the weekno in which the end date will fall
 */
-(float)weekno:(NSDate *)from and:(NSDate *)end;

/**
 *	@functionName	: weekday
 *	@parameters		: (NSDate *)from 
 *	@return			: (NSInteger)
 *	@description	: return the weekday of the given date
 */
-(NSInteger )weekday:(NSDate *)from;

/**
 *	@functionName	: createdatabase
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: create database of the events
 */
-(void) createdatabase;

/**
 *	@functionName	: settings
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: configuring the view of scroll indicators, contentsize, background color of the different view
 */
-(void) settings;

/**
 *	@functionName	: weeklabel
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: draw the weeklabel
 */
-(void) weeklabel;



@end
