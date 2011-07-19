//
//  zomminViewController.h
//  zommin
//
//  Created by Ayush Goel on 18/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zomminViewController : UIViewController <  UIScrollViewDelegate>
{
    UIScrollView *imagescroll;
    UISlider *mySlider;   
    UIImageView *myView;
    NSMutableArray *imageArray;
}

@end
