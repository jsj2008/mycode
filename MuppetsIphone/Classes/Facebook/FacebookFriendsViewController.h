//
//  FacebookFriendsViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/18/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "FacebookFriendCell.h"

@protocol FacebookFriendSelector
@required
- (void)facebookFriendsSelected;

@end

@interface FacebookFriendsViewController : UIBaseViewController <FacebookFriendCellUpdateListener, UIGestureRecognizerDelegate> {
    NSArray *data;
    NSArray *originalData;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    UILabel *selectionDetailsLabel;
    UIImageView *backgroundImage;
    id delegate;
    UIView *alphabetScrubber;
    
    NSMutableArray *selectedFriends;
    
    int _currentAlphabetIndex;
}

@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSArray *originalData;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UILabel *selectionDetailsLabel;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIView *alphabetScrubber;
@property (nonatomic, retain) id <FacebookFriendSelector>delegate;
@property (nonatomic, retain) NSMutableArray *selectedFriends;

- (IBAction)doneClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;
- (IBAction)selectEverybody:(id)sender;
- (IBAction)selectNobody:(id)sender;
- (IBAction)showAllButtonClicked:(id)sender;

- (NSArray *)selectedFriends;
- (void)update;
- (void)enumerateGridElementsUsingBlock:(void (^)(id obj, NSUInteger idx))block;

@end
