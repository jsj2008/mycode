//
//  PlacementsScreen.h
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instruction.h"
#import "CallOutView.h"
#import "ExpandView.h"
#import "CustomPlacementImageView.h"
@interface PlacementsScreen : UIViewController  <UIScrollViewDelegate, CustomPlacementImageViewDelegate>{
	Instruction *instruction;
	
	IBOutlet UIScrollView *firstScrollView;
	UIView * imageViewHolder;
	CustomPlacementImageView *imageView;
	ExpandView *expandView;
	NSArray *buttonArray;
	CGFloat maxZoomLevel ;
	
	CGPoint someViewOriginalCenter;
	CGPoint someViewOriginalCenter1;
	CGPoint expandViewOriginalCenter;
	
	NSArray *originalXCenterArray;
	NSArray *originalYCenterArray;

	
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instruction:(Instruction*)aInstruction;
- (void) releaseExpandView;
@end
