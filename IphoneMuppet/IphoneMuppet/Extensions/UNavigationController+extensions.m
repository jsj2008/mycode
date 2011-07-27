//
//  UICustomNavigationController.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "UNavigationController+extensions.h"

@implementation UINavigationController (extension)

- (void)pushScaleAnimatedViewController:(UIViewController *)viewController fromSourceControl:(UIView *)source{
    [source animateToFullScreenWithRootView:self.view andBlock:^(id imageView){
        [viewController performSelector:@selector(setZoomOutAnimationImage:) withObject:source];
        [self pushViewController:viewController animated:NO];
    }];
}

- (void)popScaleAnimatedViewController{
    [[self.visibleViewController performSelector:@selector(zoomOutAnimationImage)] animateToOriginalPositionWithRootView:self.view andBlock:^(id imageView){
        [self popViewControllerAnimated:NO];
    }];
}

- (void)pushViewController:(UIViewController*)controller usingTransition:(NSString *)transition {
    [self pushViewController:controller animated:NO];
    [self.view animateWithTransition:transition];
}

- (void)popViewControllerUsingTransition:(NSString *)transition {
    [self popViewControllerAnimated:NO];
    [self.view animateWithTransition:transition];
}

- (void)popToRootViewControllerUsingTransition:(NSString *)transition {
    [self popToRootViewControllerAnimated:NO];
    [self.view animateWithTransition:transition];
}


@end
