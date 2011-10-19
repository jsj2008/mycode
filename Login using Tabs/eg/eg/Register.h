//
//  Register.h
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Register : UIViewController {
    IBOutlet UITextField * uid;
    IBOutlet UITextField * pwd;
    IBOutlet UITextField * name;
    IBOutlet UITextField * age;
    IBOutlet UITextField * add;
    IBOutlet UITextField * img;
    
}
-(IBAction) regiUser;
@end
