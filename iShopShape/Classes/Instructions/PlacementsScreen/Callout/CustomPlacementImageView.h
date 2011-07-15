//
//  CustomPlacementImageView.h
//  iShopShape
//
//  Created by Santosh B on 07/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPlacementImageViewDelegate
- (void) touchDetected;
@end

@interface CustomPlacementImageView : UIImageView {
	id <CustomPlacementImageViewDelegate> delegate;
}
@property(nonatomic, assign)id <CustomPlacementImageViewDelegate> delegate;
@end
