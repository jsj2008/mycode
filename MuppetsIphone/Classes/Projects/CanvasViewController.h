//
//  CanvasViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "CanvasDrawView.h"
#import "Project.h"

@interface CanvasViewController : UIBaseViewController <UIActionSheetDelegate> {
    IBOutlet CanvasDrawView *canvas;
    Project *currentProject;
    NSString *sharePath;
    UIImageView *newView;
}

@property (nonatomic, retain) IBOutlet CanvasDrawView *canvas;

@property (nonatomic, retain) IBOutlet UIImageView *newView;
@property (nonatomic, retain) NSString *sharePath;


- (void)loadProject:(Project *)project;
- (void)loadImage:(UIImage *)myImage;
- (BOOL)saveProject;
- (BOOL)renderProject;
- (void)saveToPictures;

- (void)render;
- (void)share;

- (NSString *)videoPath;
- (NSString *)thumbnailPath;
- (NSString *)previewPath;
- (NSString *)pathForResourceType:(NSString *)resourceType;

@end
