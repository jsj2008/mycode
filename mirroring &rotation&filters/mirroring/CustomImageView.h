//
//  CustomImageView.h
//  iShopShape
//
//  Created by Ayush on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomImageViewDelegate
-(void)choice:(int) d;
@end

@interface CustomImageView : UIImageView
{
  id <CustomImageViewDelegate> delegate;
	
}

@property(nonatomic,retain)id <CustomImageViewDelegate> delegate;

@end
