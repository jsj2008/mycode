//
//  Login.h
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Login : UIViewController {
    IBOutlet UITextField * uid;
    IBOutlet UITextField * pwd;
}

-(IBAction) loginChk:(id) sender;
-(IBAction) regiUser:(id) sender;

@end
