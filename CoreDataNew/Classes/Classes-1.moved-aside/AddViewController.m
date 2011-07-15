    //
//  AddViewController.m
//  CoreDataNew
//
//  Created by Dev1 on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import "AddViewController.h"
#import "Items.h"

@implementation AddViewController

//@synthesize delegate;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	[super viewDidLoad];
    // Override the DetailViewController viewDidLoad with different navigation bar items and title.
    self.title = @"New Item";
    //self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
//																						   target:self action:@selector(cancel:)] autorelease];
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
//																							target:self action:@selector(save:)] autorelease];
//	
//	// Set up the undo manager and set editing state to YES.
//	[self setUpUndoManager];
//	self.editing = YES;
}


- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any properties that are loaded in viewDidLoad or can be recreated lazily.
	//[self cleanUpUndoManager];	
}


#pragma mark -
#pragma mark Save and cancel operations

//- (IBAction)cancel:(id)sender {
//	[delegate addViewController:self didFinishWithSave:NO];
//}
//
//- (IBAction)save:(id)sender {
//	[delegate addViewController:self didFinishWithSave:YES];
//}


@end

