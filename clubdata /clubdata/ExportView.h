//
//  ExportView.h
//  clubdata
//
//  Created by MacBookPro on 27/02/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ExportView : UITableViewController<MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController* mailComposer;
    NSManagedObjectContext *context;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;
    NSPredicate *predicate ;   
    NSArray *fetchedObjects;
    NSSortDescriptor * sortDescriptor;
    NSArray * sortDescriptors;
    
}

-(IBAction) ExportButton;
-(IBAction) cleardbButton;
@end
