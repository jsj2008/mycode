//
//  MuppetBuilderViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/5/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasObjectMuppet.h"
#import "UIBaseViewController.h"

@class MuppetFeatureDataProvider;

@interface MuppetBuilderViewController : UIBaseViewController {
    UIImageView *body;
    UIImageView *face;
    UIImageView *hair;
    UIImageView *shirt;
    UIImageView *pant;
    UIImageView *mouth;
    
    NSString *faceImageName;
    NSString *hairImageName;
    NSString *shirtImageName;
    NSString *pantImageName;

    
    MuppetFeatureDataProvider *muppetFeatureDataProvider;
    UIPopoverController *muppetFeatureDataProviderPopup;
    
    CanvasObjectMuppet *canvasObjectMuppet;
    
    IBOutlet UIView *muppetView;
}

@property (nonatomic, retain) IBOutlet UIImageView *body;
@property (nonatomic, retain) IBOutlet UIImageView *face;
@property (nonatomic, retain) IBOutlet UIImageView *hair;
@property (nonatomic, retain) IBOutlet UIImageView *shirt;
@property (nonatomic, retain) IBOutlet UIImageView *pant;
@property (nonatomic, retain) IBOutlet UIImageView *mouth;

@property (nonatomic, retain) IBOutlet UIImageView *background;


@property (nonatomic, retain) NSString *faceImageName;
@property (nonatomic, retain) NSString *hairImageName;
@property (nonatomic, retain) NSString *shirtImageName;
@property (nonatomic, retain) NSString *pantImageName;

@property (nonatomic, assign) CanvasObjectMuppet *canvasObjectMuppet;

- (IBAction)pickHair:(id)sender;
- (IBAction)pickFace:(id)sender;
- (IBAction)pickShirt:(id)sender;
- (IBAction)pickPant:(id)sender;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

- (void)loadMuppet;

@end
