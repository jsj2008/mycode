//
//  frontbackViewController.h
//  frontback
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@interface frontbackViewController : UIViewController <CustomImageViewDelegate>
{
    CustomImageView *topImage;
    CustomImageView *backImage;
    
}

@end
