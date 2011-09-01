//
//  ProjectNameEditViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 21/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"

@class Project;
@class BaseGridElementView;
@class ProjectNameEditViewController;

@protocol ProjectEditHandler

- (void)projectPropertiesSaved:(ProjectNameEditViewController *)editor;

@end

@interface ProjectNameEditViewController : UIBaseViewController {
    UIImageView *image;
    UITextField *nameField;
    UIButton *saveButton;
    
    BaseGridElementView *sourceView;
    Project *project;
    id delegate;
}

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;

@property (nonatomic, retain) BaseGridElementView *sourceView;
@property (nonatomic, retain) Project *project;
@property (nonatomic, assign) id <ProjectEditHandler>delegate;

- (IBAction)saveClicked:(id)sender;

- (id)initSourceView:(BaseGridElementView *)aSourceView;

@end
