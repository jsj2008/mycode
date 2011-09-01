    //
//  HomeViewController.m
//  MuppetsIphone
//
//  Created by Manish on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "OccasionsGridViewController.h"
#import "MuppetsGridViewController.h"
#import "ProjectsGridViewController.h"
#import "DataLoader.h"

#define kPreviewLimit 5

@interface HomeViewController (private)

- (void)showCharactersPreview;
- (void)showOccasionsPreview;

@end

@implementation HomeViewController
@synthesize charactersButton;
@synthesize occasionsButton;
@synthesize projectsButton;
@synthesize muppetMakerButton;

- (id)init{
    self = [super initWithNibName:@"HomeView" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [charactersButton release];
    [occasionsButton release];
    [projectsButton release];
    [muppetMakerButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showCharactersPreview];
    [self showOccasionsPreview];
}

- (void)viewDidUnload
{
    [self setCharactersButton:nil];
    [self setOccasionsButton:nil];
    [self setProjectsButton:nil];
    [self setMuppetMakerButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)showOccasions:(id)sender {
    OccasionsGridViewController *_occasions = [OccasionsGridViewController new];
    [self.navigationController pushViewController:_occasions usingTransition:kCATransitionFade];
    [_occasions release];
}

- (IBAction)showCharacters:(id)sender {
    MuppetsGridViewController *_muppets = [MuppetsGridViewController new];
    [self.navigationController pushViewController:_muppets usingTransition:kCATransitionFade];
    [_muppets release];
}

- (IBAction)showProjects:(id)sender {
    ProjectsGridViewController *_projects = [ProjectsGridViewController new];
    [self.navigationController pushViewController:_projects usingTransition:kCATransitionFade];
    [_projects release];
	
}

- (IBAction)showMuppetMaker:(id)sender {
}


// add images inside buttons for preview
- (void)showCharactersPreview{
}

- (void)showOccasionsPreview{
}

- (void)disneyNotificationReceived:(NSNotification *)notification{
    NSArray *_alerts = [notification object];
    
    for (NSDictionary *_alert in _alerts) {
        [self quickAlertViewWithTitle:[_alert objectForKey:@"name"] message:[_alert objectForKey:@"description"] button:@"ok"];
    }
    
}

- (void)facebookNotificationReceived:(NSNotification *)notification{
    NSArray *_alerts = [notification object];
    
    for (NSDictionary *_alert in _alerts) {
        [self quickAlertViewWithTitle:[_alert objectForKey:@"name"] message:[_alert objectForKey:@"description"] button:@"ok"];
    }
}


@end
