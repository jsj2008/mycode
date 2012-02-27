//
//  AppDelegate.h
//  clubdata
//
//  Created by Ayush Goel on 2/20/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddViewController : UITableViewController
{
    NSManagedObjectContext *context;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;
    NSPredicate *predicate ;   
    NSArray *fetchedObjects;
    NSSortDescriptor * sortDescriptor;
    NSArray * sortDescriptors;
    NSMutableArray *list;
  
    UIImageView *datePickerImage;
    UIDatePicker *datePicker;
    
}
-(void) setButtons;
@end
