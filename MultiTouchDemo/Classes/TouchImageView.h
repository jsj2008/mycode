//
//  TouchImageView.h
//  MultiTouchDemo
//
//  Created by Jason Beaver on 5/29/08.
//  Copyright 2008 Apple Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiTouchDemoViewController.h"

@interface TouchImageView : UIImageView {
    CGAffineTransform originalTransform;
    CFMutableDictionaryRef touchBeginPoints;
	MultiTouchDemoViewController *parent;
	
}
@property (nonatomic,retain) MultiTouchDemoViewController *parent;
-(void)deleteSelectedImage;
-(BOOL)checkFrameinBounds:(TouchImageView *)t;
@end
