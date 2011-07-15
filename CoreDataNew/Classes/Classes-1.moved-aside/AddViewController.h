//
//  AddViewController.h
//  CoreDataNew
//
//  Created by Dev1 on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"


//@protocol AddViewControllerDelegate;


@interface AddViewController : DetailViewController {
	//id <AddViewControllerDelegate> delegate;
}

//@property (nonatomic, assign) id <AddViewControllerDelegate> delegate;

//- (IBAction)cancel:(id)sender;
//- (IBAction)save:(id)sender;

@end


//@protocol AddViewControllerDelegate
//- (void)addViewController:(AddViewController *)controller didFinishWithSave:(BOOL)save;
@end