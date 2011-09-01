//
//  MupperBuilderViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "CanvasViewController.h"
#import "MuppetView.h"
#import "CharacterView.h"
#import "TouchImageView.h"

@class MuppetBuilderViewController;

@interface ProjectViewController : UIBaseViewController<CharacterimageDelegate,MuppetimageDelegate>
{
    UIView *canvasToolBarContainer;
    UIView *canvasContainer;
    CanvasViewController *canvasViewController;
    CAShapeLayer *selection;
    IBOutlet UIView *canvasObjectLayerControl;
    MuppetView *muppetControl;
    CharacterView *characterControl;
    MuppetBuilderViewController *muppetBuilder;
    UIButton *save_btn;
    UIButton *save_picture_btn;
    //count is tag count to add or remove characters
    int tagCount;
    NSMutableDictionary *characterTags;
    NSMutableArray *arrayOfSelected;
}
@property (nonatomic, retain) IBOutlet UIButton *save_btn;
@property (nonatomic, retain) IBOutlet UIButton *save_picture_btn;

@property (nonatomic, retain) CanvasViewController *canvasViewController;
@property (nonatomic, retain) IBOutlet UIView *canvasContainer;
@property (nonatomic, retain) IBOutlet UIView *canvasObjectLayerControl;
@property (nonatomic, retain) IBOutlet UIView *canvasToolBarContainer;



- (void)loadProject:(Project *) project;
- (void)loadImage:(UIImage *)myImage;
- (IBAction)saveProject:(id)sender;
- (IBAction)shareProject:(id)sender;

- (IBAction)gotoHome:(id)sender;
- (IBAction)gotoGrid:(id)sender;

- (IBAction)addMuppet:(UIButton *)sender;
- (IBAction)addCharacter:(UIButton *)sender;
- (IBAction)addBackground:(UIButton *)sender;
- (IBAction)addStamp:(UIButton *)sender;
- (IBAction)addSpeech:(UIButton *)sender;

- (void) loadMuppetBuilder:(NSNotification *) notification;




- (IBAction)moveForward:(id)sender;
- (IBAction)moveBackward:(id)sender;
- (IBAction)remove:(id)sender;

-(void)showSelection:(TouchImageView *)t;
- (void)layoutSubviews:(TouchImageView *)t;
@end
