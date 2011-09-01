//
//  ProjectsGridViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "ProjectsGridViewController.h"
#import "Project.h"
#import "ProjectViewController.h"
#import "SettingsViewController.h"
#import "WEPopoverController.h"

@implementation ProjectsGridViewController
@synthesize cardsButton;
@synthesize charactersButton;
@synthesize settingsButton;
@synthesize deleteButton;
@synthesize selectAllButton;
@synthesize selectNoneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.data = [[Project all] retain];
    }
    return self;
}

- (void)dealloc
{
    [settingsPopoverController release];

    [cardsButton release];
    [charactersButton release];
    [settingsButton release];

    [deleteButton release];
    [selectAllButton release];
    [selectNoneButton release];
    [super dealloc];
}

- (UIImage *)thumbnailForObject:(Project *)project{
    return [[project thumbnail] transparentBorderImage:2.0f];
}

- (UIView *)viewForIndex:(NSUInteger)index{
    Project *_data = [data objectAtIndex:index];
    
    BaseGridElementView *_cell  = [BaseGridElementView new];
    _cell.delegate              = self;
    _cell.label.text            = _data.name;
    _cell.data                  = _data;
    _cell.image.image           = [self thumbnailForObject:_data];
    
    return _cell;
}

- (void)gridItemSelected:(id)details{
    ProjectViewController *_project = [[ProjectViewController alloc] init];
    [self.navigationController pushViewController:_project usingTransition:kCATransitionFade];
    [_project loadProject:details];
    [_project release];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    cardsButton.selected = YES;
    deleteButton.enabled = NO;
    
    [cardsButton applyThemeForLeftButton];
    [charactersButton applyThemeForMiddleButton];
    [settingsButton applyThemeForRightButton];
    
    [selectAllButton applyThemeForLeftButton];
    [selectNoneButton applyThemeForRightButton];

    [deleteButton applyTheme];
}

- (void)viewDidUnload {
    [self setSettingsButton:nil];
    [self setCharactersButton:nil];
    [self setCardsButton:nil];
    [self setDeleteButton:nil];
    [self setSelectAllButton:nil];
    [self setSelectNoneButton:nil];
    [super viewDidUnload];
}
- (IBAction)cardsButtonClicked:(id)sender {
    cardsButton.selected = YES;
    charactersButton.selected = NO;
}

- (IBAction)charactersButtonClicked:(id)sender {
    cardsButton.selected = NO;
    charactersButton.selected = YES;
}

- (IBAction)settingsButtonClicked:(UIButton *)sender {
 
        settingsViewController          = [SettingsViewController new];
        [self.navigationController pushViewController:settingsViewController animated:YES];
        [settingsViewController release];
         settingsButton.selected = YES;
}

- (IBAction)selectAllClicked:(id)sender {
    _selectedProjectsCount = 0;
    
    [self enumerateGridElementsUsingBlock:^(id _tile, NSUInteger idx) {
        [_tile setSelected:YES];
        _selectedProjectsCount ++;
    }];

    deleteButton.enabled = (_selectedProjectsCount > 0);
}

- (IBAction)selectNoneClicked:(id)sender {
    _selectedProjectsCount = 0;
    
    [self enumerateGridElementsUsingBlock:^(id _tile, NSUInteger idx) {
        [_tile setSelected:NO];
    }];
    
    deleteButton.enabled = NO;
}

- (IBAction)deleteClicked:(id)sender {
    [self enumerateGridElementsUsingBlock:^(id _tile, NSUInteger idx) {
        if ([_tile isSelected]){
            [(Project *)[_tile data] remove];
        }
    }];

    if (data) {
        [data release], data = nil;
    }
    data = [[Project all] retain];
    
    [self layoutGridElements];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    settingsButton.selected = NO;
}

- (void)gridItemSingleTapped:(BaseGridElementView *)cell{
    cell.selected = !cell.selected;

    if (cell.selected) 
        _selectedProjectsCount ++;
    else 
        _selectedProjectsCount --;
    
    deleteButton.enabled = (_selectedProjectsCount > 0);
}

- (void)gridItemDoubleTapped:(BaseGridElementView *)cell{
    [self gridItemSelected:cell.data];
}

- (void)gridItemlongPressed:(BaseGridElementView *)cell{
    ProjectNameEditViewController *_editor = [[ProjectNameEditViewController alloc] initSourceView:cell];
    [self presentModalViewController:_editor animated:YES];
    [_editor setDelegate:self];
    [_editor release];
}

- (void)projectPropertiesSaved:(ProjectNameEditViewController *)editor{
    editor.sourceView.label.text = editor.project.name;
}

@end
