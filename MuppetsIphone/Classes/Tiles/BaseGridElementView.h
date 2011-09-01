//
//  BaseGridElement.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/20/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseGridElementView;

@protocol BaseGridElementViewUpdateListener

- (void)gridItemSingleTapped:(BaseGridElementView *)cell;
- (void)gridItemDoubleTapped:(BaseGridElementView *)cell;
- (void)gridItemlongPressed:(BaseGridElementView *)cell;

@end


@interface BaseGridElementView : UIView <UIGestureRecognizerDelegate> {
    UIImageView *image;
    UIImageView *backgroundImage;
    UILabel *label;
    id delegate;
    NSDictionary *data;
    BOOL _gestureAdded;
    
    CAShapeLayer *selection;
}
@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, assign) id <BaseGridElementViewUpdateListener>delegate;
@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic, assign, getter = isSelected) BOOL selected;

- (void)hideLabel;

@end