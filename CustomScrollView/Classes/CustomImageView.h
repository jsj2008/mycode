//
//  CustomImageView.h
//  ImageTouch
//
//  Created by ayush on 25/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelImageViewController.h"
#import "CustomImageDelegate.h"

//@protocol CustomImageDelegate;

@interface CustomImageView : UIImageView 
{
	
	id <CustomImageDelegate> delegate;
}



@property(nonatomic, retain) id <CustomImageDelegate> delegate;



@end

