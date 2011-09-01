//
//  IM_TestViewController.h
//  IM_Test
//
//  Created by Ayush goel
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagickWand.h"

@interface IM_TestViewController : UIViewController {
    UIImageView *myImageView;
	int startX,startY,endX,endY;
	MagickWand * magick_wand;
    UIImage *myImage;
    UIImage *blurredImage;
}


- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
- (UIImage*)posterizeImageWithCompression:(UIImage *)blurredImage ;


@end

