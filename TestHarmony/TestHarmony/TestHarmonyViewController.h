//
//  TestHarmonyViewController.h
//  TestHarmony
//
//  Created by Ayush Goel on 22/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClickController.h"
#import "SearchTable.h"


@interface TestHarmonyViewController : UIViewController <UIScrollViewDelegate,ColorPickerDelegate,UIAlertViewDelegate,UIWebViewDelegate,UISearchBarDelegate,SearchDelegate>
{
    UIImageView *topView;
    UIImageView *labelBar;
    UIImageView *lableHighlighBar;
    UIImageView *backgroundImage;
    UIImageView *firstImageView;
    UIImageView *favImageView;
    
    UIImageView *childImage1;
    UIImageView *childImage2;
    UIImageView *childImage3;
    
    
    UIImageView *bottomview;
    UIImageView *loading;
    UIImageView *touchsurface1;
    UIImageView *touchsurface2;
    UIImageView *mute;
    UIImageView *play;
    UIImageView *reverse;
    UIImageView *forward; 
    UIImageView *plus;
    UIImageView *minus;
    UIImageView *alertView;
    
    UIImage *playImage;
    UIImage *volumeImage;
    UIImageView *color;
    
    UIScrollView *rootScroll;
    UIScrollView *labelScroll;
    UIScrollView *sideScroll;
    UIScrollView *child1;
    UIScrollView *child2;
    UIScrollView *child3;
    
    UIButton *Gina;
    UIButton *toby;
    UIButton *watchTV;
    UIButton *watchNet;
    UIButton *watchHulu;
    UIButton *Listen;
    UIButton *Playstation;
    UIButton *backButton;
    UIButton *powerButton;
    UIButton *watchNow;
    UIButton *MoreInfo;
    UIButton *thumbup;
    UIButton *thumbdown;
    UIButton *social;
    
    UIImageView *thumb;
   
   
    UILabel *mylabel;
    UILabel *Viewlabel;
    UILabel *activity;
   
    UIView *moreInfoView;
    UIView *socialView;
    
    UIView *moreInfoView1;
    UIView *socialView1;
    
    UISearchBar *mySearch;
    SearchTable *myClick;
    UIPopoverController *searchPopover;
    
    NSString *title;

    ClickController *_colorPicker;
    UIWebView *customWebView;
    UIPopoverController *myPopover;
    UINavigationController *nav;
    
    float startX;
    float endX;
    float labelScrollStartX;
    float labelScrollEndX;
    int posx;
    int posy;
    int  choice;
    int resume;
    
    int p;
    int v;
    int c;
    int newView;
    
  
}
@property(nonatomic,retain) UILabel *mylabel;
@property (nonatomic, retain) ClickController *colorPicker;
@property (nonatomic, retain) UIPopoverController *myPopover;



-(void) setting;
-(void) addButton;
- (void)setChilds;
-(void) setCustomViews;
- (void)MytableView:(UITapGestureRecognizer *)aGesture;


-(void) HideBegin;
-(void) HideStart;
-(void) HideEnd;
-(void) showBegin;
- (void)ShowFinish;
- (void)ShowStart;
- (void)ShowEnd;
-(void) left;
-(void) right;
-(void) bar;
- (void)ShowBarFinish;
-(void) showBeginthumb;
- (void)ShowStartthumb;
- (void)ShowFinishthumb;

-(void) setInfoView;
-(void) setSocialView;
-(void) setWebView;
-(void) ShowViewStart;
-(void) ShowViewEnd;
 -(void) onMoreInfo;

@end
