//
//  BaseGridViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "BaseGridElementView.h"

@interface BaseGridViewController : UIBaseViewController <UIGestureRecognizerDelegate, BaseGridElementViewUpdateListener> {
    NSArray *_rotations;
    UIScrollView *scrollView;
    NSArray *data;
    UIPageControl *pageControl;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSArray *data;

- (IBAction)gotoHome:(id)sender;

- (void)layoutGridElements;
- (void)enumerateGridElementsUsingBlock:(void (^)(id obj, NSUInteger idx))block;

@end
