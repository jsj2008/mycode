//
//  ExpandView.h
//  iShopShape
//
//  Created by Santosh B on 07/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ExpandView : UIView {

	UIImageView *calloutImageView;
	UIImageView *productImage;
	UILabel *productNameLabel;
	UILabel *productIdLabel;
	UILabel *quantityLabel;
	int currentTag;
}
@property(assign) int currentTag;
- (void) createCallout : (Product *)product;
@end
