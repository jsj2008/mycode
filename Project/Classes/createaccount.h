//
//  createaccount.h
//  project
//
//  Created by Ayush Goel on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface createaccount : UIViewController {


    IBOutlet UILabel *lbl;
	IBOutlet UITextField *name;
	IBOutlet UITextField *pass;



}
-(IBAction) create;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *pass;

@end
