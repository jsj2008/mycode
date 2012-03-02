//
//  testViewController.h
//  test
//
//  Created by Ayush on 01/03/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"

@interface testViewController : UIViewController <UISplitViewControllerDelegate, ADBannerViewDelegate,UIWebViewDelegate>
{

    UIView *_contentView;
    id _adBannerView;
    BOOL _adBannerViewIsVisible;
    IBOutlet UIWebView *customWebView;
    BOOL added;

}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;
- (void)fixupAdView ;

@end

