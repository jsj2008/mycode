//
//  AppDelegate.h
//  clubdata
//
//  Created by Ayush Goel on 2/20/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "MasterViewController.h"
#import "User.h"

@implementation MasterViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //#warning Incomplete method implementation

    return [list count];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *Data=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"myid"];
  
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"loadMyData"
                                      object:nil
                                    userInfo:Data];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseid = @"clubbercell";

    //get cell reference, customize, and return
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];

    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    
    return cell;    
}

#pragma mark - Xcode Template Defs

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error;

    
    
     context  =[[AppDelegate getAppDelegate] managedObjectContext];
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"User" 
                         inManagedObjectContext:context];
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fname"
                                                 ascending:YES];
    
    sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
  //  predicate = [NSPredicate predicateWithFormat:@"selected =%d",1];
    [fetchRequest setSortDescriptors: sortDescriptors];
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:predicate];
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];   
    list=[[NSMutableArray alloc]init];
    [list removeAllObjects];
    for(int i=0;i<[fetchedObjects count];i++)
    {
        User *info=[fetchedObjects objectAtIndex:i];
        NSString *clickName=[NSString stringWithFormat:@"%@ %@",info.fname,info.lname];
           [list addObject:clickName];
    }


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
