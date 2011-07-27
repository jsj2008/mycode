//
//  UICustomNavigationController.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UINavigationController (extension)

- (void)pushScaleAnimatedViewController:(UIViewController *)viewController fromSourceControl:(UIView *)source;
- (void)popScaleAnimatedViewController;

- (void)pushViewController:(UIViewController*)controller usingTransition:(NSString *)transition;
- (void)popViewControllerUsingTransition:(NSString *)transition;
- (void)popToRootViewControllerUsingTransition:(NSString *)transition;

@end
