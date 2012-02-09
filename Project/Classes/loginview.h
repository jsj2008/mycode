//
//  loginview.h
//  project
//
//  Created by Ayush Goel on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface loginview : UIViewController {
	IBOutlet UIButton *submit;
	IBOutlet UITextField *name;
	IBOutlet UITextField *pass;
	IBOutlet UILabel *invalid;

	

}
 
-(IBAction) validate;
//- (IBAction) writePlistFile : (id)sender;
-(IBAction) next;

@property (nonatomic, strong) IBOutlet UIButton *submit;
@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *pass;
@property (nonatomic, strong) IBOutlet UILabel *invalid;

@end

