//
//  FacebookFriendCell.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/18/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FacebookFriendCell;

@protocol FacebookFriendCellUpdateListener

- (void)friendCellSelectionUpdated:(FacebookFriendCell *)cell;

@end


@interface FacebookFriendCell : UIView <UIGestureRecognizerDelegate> {
    UIImageView *image;
    UILabel *nameLabel;
    UILabel *birthdayLabel;
    UIImageView *checkBox;
    NSString *identifier;
    
    BOOL selected;
    BOOL _gestureAdded;
    
    NSDictionary *data;
    
    id <FacebookFriendCellUpdateListener>delegate;
}
@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, retain) IBOutlet UIImageView *checkBox;

@property (nonatomic, assign, getter = iSSelected) BOOL selected;
@property (nonatomic, retain) NSString *identifier;

@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) NSDictionary *data;

@end