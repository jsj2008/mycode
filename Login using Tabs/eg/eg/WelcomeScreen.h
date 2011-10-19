//
//  WelcomeScreen.h
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WelcomeScreen : UIViewController {
    IBOutlet UILabel *msg;
}
-(IBAction) logOut;
@property(nonatomic,retain) IBOutlet UILabel *msg;

@end
