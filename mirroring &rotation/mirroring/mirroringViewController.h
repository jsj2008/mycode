//
//  mirroringViewController.h
//  mirroring
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@interface mirroringViewController : UIViewController <CustomImageViewDelegate>
{
    CustomImageView *myView;
    UIImage *myImage;
    CGAffineTransform tran;
    CGFloat angle;
}
@property(nonatomic,retain) CustomImageView *myView;
-(void) createButton;

@end
