//
//  ProjectsGridViewController.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseGridViewController.h"
#import "ProjectNameEditViewController.h"

@class SettingsViewController;
@class WEPopoverController;


@interface ProjectsGridViewController : BaseGridViewController <ProjectEditHandler> {
    
    UIButton *settingsButton;
    UIButton *deleteButton;
    UIButton *selectAllButton;
    UIButton *selectNoneButton;
    UIButton *charactersButton;
    UIButton *cardsButton;
    
    SettingsViewController *settingsViewController;
    WEPopoverController *settingsPopoverController;

    int _selectedProjectsCount;
}

@property (nonatomic, retain) IBOutlet UIButton *cardsButton;
@property (nonatomic, retain) IBOutlet UIButton *charactersButton;
@property (nonatomic, retain) IBOutlet UIButton *settingsButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
@property (nonatomic, retain) IBOutlet UIButton *selectAllButton;
@property (nonatomic, retain) IBOutlet UIButton *selectNoneButton;

- (IBAction)cardsButtonClicked:(id)sender;
- (IBAction)charactersButtonClicked:(id)sender;
- (IBAction)settingsButtonClicked:(id)sender;
- (IBAction)selectAllClicked:(id)sender;
- (IBAction)selectNoneClicked:(id)sender;
- (IBAction)deleteClicked:(id)sender;

@end
