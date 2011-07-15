//
//  StoreLayoutScreen.h
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreImageScrollView.h"

@interface StoreLayoutScreen : UIViewController <UIScrollViewDelegate>{
	StoreImageScrollView *storeLayoutImageView;
	IBOutlet UIScrollView *scrollView;
}

@end
