//
//  ProjectNameEditViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 21/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "ProjectNameEditViewController.h"
#import "Project.h"
#import "BaseGridElementView.h"

@implementation ProjectNameEditViewController
@synthesize image;
@synthesize nameField;
@synthesize saveButton;
@synthesize sourceView;
@synthesize delegate;
@synthesize project;

- (id)initSourceView:(BaseGridElementView *)aSourceView{
    self = [super initWithNibName:@"ProjectNameEditView" bundle:nil];
    if (self) {
        self.sourceView = aSourceView;
        self.project    = (Project *)[aSourceView data];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.image.image    = project.thumbnail;
    self.nameField.text = project.name;
}

- (void)viewDidUnload
{
    [self setImage:nil];
    [self setNameField:nil];
    [self setSaveButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [nameField becomeFirstResponder];
}

- (void)dealloc {
    [image release];
    [nameField release];
    [saveButton release];
    [super dealloc];
}

- (IBAction)saveClicked:(id)sender {
    project.name = nameField.text;
    [project update];

    if ([delegate respondsToSelector:@selector(projectPropertiesSaved:)]) {
        [delegate projectPropertiesSaved:self];
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
