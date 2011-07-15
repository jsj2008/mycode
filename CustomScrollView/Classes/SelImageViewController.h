//
//  SelImageViewController.h
//  SelImage
//
//  Created by ayush on 25/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageDelegate.h"
@interface SelImageViewController : UIViewController <UIScrollViewDelegate,CustomImageDelegate>
{
	UIScrollView *scrollview;
	//id <CustomImageDelegate> delegate;
}

@property (nonatomic , retain)UIScrollView *scrollview;
//@property(nonatomic, retain) id <CustomImageDelegate> delegate;
@end

