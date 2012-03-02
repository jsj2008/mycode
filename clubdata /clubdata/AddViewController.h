//
//  AppDelegate.h
//  clubdata
//
//  Created by Ayush Goel on 2/20/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddViewController : UITableViewController<UITextFieldDelegate>
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
@property(nonatomic,) int check;
- (IBAction)doDoneButton:(id)sender;
- (IBAction)editButton:(id)sender;
-(void) setButtons;
@end
