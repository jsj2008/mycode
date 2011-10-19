//
//  SecondViewController.h
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginToContinue.h"

@interface SecondViewController : UIViewController {
       LoginToContinue * logi;
    IBOutlet UILabel *name;
    IBOutlet UILabel * age;
    IBOutlet UILabel * addr;
}

@end
