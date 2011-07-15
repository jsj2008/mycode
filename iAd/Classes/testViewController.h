//
//  testViewController.h
//  test
//
//  Created by Ayush on 28/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"

@interface testViewController : UIViewController <UISplitViewControllerDelegate, ADBannerViewDelegate>
{
	UILabel *_nameLabel;
    UILabel *_typeLabel;
    UITextView *_descrView;
    UILabel *_ratingLabel;
    id _popover;
    id _ratingPopover;
    UIView *_contentView;
    id _adBannerView;
    BOOL _adBannerViewIsVisible;

}


@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UITextView *descrView;
@property (nonatomic, retain) IBOutlet UILabel *ratingLabel;
@property (nonatomic, retain) id popover;
@property (nonatomic, retain) id ratingPopover;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;


@end

