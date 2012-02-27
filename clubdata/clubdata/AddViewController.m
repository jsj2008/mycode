//
//  AppDelegate.h
//  clubdata
//
//  Created by Ayush Goel on 2/20/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "AddViewController.h"
#import "User.h"


@implementation AddViewController {
    
    __weak IBOutlet UITextField *fName;
    __weak IBOutlet UITextField *lName;
    __weak IBOutlet UITextField *email;
    __weak IBOutlet UITextField *mob;
    __weak IBOutlet UITextField *bbm;
    __weak IBOutlet UITextField *birthday;
     __weak IBOutlet UISegmentedControl *gender;
    __weak IBOutlet UISegmentedControl *color;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (IBAction)doDoneButton:(id)sender {

    NSManagedObjectContext *context1 =[[AppDelegate getAppDelegate] managedObjectContext];
    User *userDetails = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"User" 
                                            inManagedObjectContext:context1];
    userDetails.email=email.text;
    userDetails.fname=fName.text;
    userDetails.lname=lName.text;
    userDetails.mobile=mob.text;
    userDetails.bbm=bbm.text;
    userDetails.birthday=[NSDate date];
    userDetails.gender=[NSNumber numberWithInt:gender.selectedSegmentIndex];
    userDetails.color=[NSNumber numberWithInt:color.selectedSegmentIndex];
    
    NSError *error;
    [context1 save:&error];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doReturnButton:(UITextField*)sender {

    switch (sender.tag) {
        case 100:
            [lName becomeFirstResponder];
            break;
        case 101:
            [email becomeFirstResponder];
            break;
        case 102:
            [mob becomeFirstResponder];
            break;
        case 103:
            [bbm becomeFirstResponder];
            break;
        case 104:
            [birthday becomeFirstResponder];
            break;
        default:
            [sender resignFirstResponder];
            break;
    }
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    fName = nil;
    lName = nil;
    email = nil;
    mob = nil;
    bbm = nil;
    birthday = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
