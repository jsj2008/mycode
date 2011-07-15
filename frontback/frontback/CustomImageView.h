//
//  CustomImageView.h
//  iShopShape
//
//  Created by Ayush on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomImageViewDelegate
-(void)imagetouched:(int) d;
@end

@interface CustomImageView : UIImageView
{
	id <CustomImageViewDelegate> delegate;

	UILabel *titleLable;
	UILabel *dateLable;
}

@property(nonatomic,retain)id <CustomImageViewDelegate> delegate;

/**
 *	@functionName	: setLabelProperty
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: set the label property
 */



@end
