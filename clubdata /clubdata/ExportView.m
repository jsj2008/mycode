//
//  ExportView.m
//  clubdata
//
//  Created by MacBookPro on 27/02/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "ExportView.h"
#import "User.h"


@implementation ExportView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
-(IBAction) cleardbButton
{
       UIAlertView *myAlertView=[[UIAlertView alloc] initWithTitle:@"Are you Sure" message:@"All your Entries will be deleted" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [myAlertView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==1)
    {
        NSError *error;
        context  =[[AppDelegate getAppDelegate] managedObjectContext];
        fetchRequest = [[NSFetchRequest alloc] init];
        entity = [NSEntityDescription entityForName:@"User" 
                             inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        fetchedObjects = [context executeFetchRequest:fetchRequest error:&error]; 
        for(int i=0;i<[fetchedObjects count];i++)
        {
            User *info=[fetchedObjects objectAtIndex:i];
            [context deleteObject:info];
            [context save:&error];
        }
        
    [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(IBAction) ExportButton
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES); 
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *root = [documentsDir stringByAppendingPathComponent:@"UserData.csv"];
    NSError *error;
    context  =[[AppDelegate getAppDelegate] managedObjectContext];
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"User" 
                         inManagedObjectContext:context];
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fname"
                                                 ascending:YES];
    
    sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
    [fetchRequest setSortDescriptors: sortDescriptors];
    [fetchRequest setEntity:entity];

    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error]; 
    NSString *temp=[[NSString alloc]init];
     temp=[NSString stringWithFormat:@"FirstName,LastName,Email,Mobile,BBM,BirthDate,SEX,COLOR"]; 
    for(int i=0;i<[fetchedObjects count];i++)
    {
        User *info=[fetchedObjects objectAtIndex:i];
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *birthday=[outputFormatter stringFromDate:info.birthday];
        NSString *sex;
        NSString *color;
        if(info.gender==0)
            sex=@"male";
        else
            sex=@"female";
        if([info.color intValue]==0)
            color=@"GEN";
        else if([info.color intValue]==1)
            color=@"TB";
        else
            color=@"TF";
        temp=[NSString stringWithFormat:@"%@\n%@,%@,%@,%@,%@,%@,%@,%@",temp,info.fname,info.lname,info.email,info.mobile,info.bbm,birthday,sex,color];
        
    }
    
    [temp writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];

    //[[fetchedObjects componentsJoinedByString:@","] writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    
    if ([MFMailComposeViewController canSendMail]) 
    {
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:root]
                               mimeType:@"application/csv" fileName:@"UserData.csv"];
        
        
        NSString *subjectString=[NSString stringWithFormat:@"User Data– "]; 
        [mailComposer setSubject:subjectString];
        NSString *emailBody = @"User Details";
        
        
        [mailComposer setMessageBody:emailBody isHTML:NO];
        
        [self.navigationController presentModalViewController:mailComposer animated:YES ];
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error 
{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"YES"] forKey:@"emailOpen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *message;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            message = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Result: failed";
            break;
        default:
            message= @"Result: not sent";
            break;
    }
      [self.navigationController dismissModalViewControllerAnimated:YES];
    

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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
