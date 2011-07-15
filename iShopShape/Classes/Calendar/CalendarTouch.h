//
//  CalendarTouch.h
//  iShopShape
//
//  Created by Ayush on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CalendarTouch : NSObject 
{
	int tagid;
	NSString *TitleLabel;
	NSString *eventname;
	NSString *Imagename;
	NSString *descrption;
	NSString *HeaderLabel;
	NSString *StartDate;
	NSString *EndDate;
	NSString *theme;

	NSArray *imageNameArray;
	NSArray *imageTitleArray;
	NSArray *imageSizeLableArray;
}

@property(nonatomic )int tagid;
@property(nonatomic,retain)NSString *TitleLabel;
@property(nonatomic,retain) NSString *Imagename;
@property(nonatomic,retain) NSString *descrption;
@property(nonatomic,retain) NSString *HeaderLabel;
@property(nonatomic,retain) NSString *eventname;
@property(nonatomic,retain) NSString *StartDate;
@property(nonatomic,retain) NSString *EndDate;
@property(nonatomic,retain) NSString *theme;

@property(nonatomic,retain) NSArray *imageNameArray;
@property(nonatomic,retain) NSArray *imageTitleArray;
@property(nonatomic,retain) NSArray *imageSizeLableArray;

@end
