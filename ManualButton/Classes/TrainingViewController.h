//
//  TrainingViewController.h
//  Training
//
//  Created by Sujit Kumar on 11/30/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface TrainingViewController : UIViewController {

	IBOutlet UILabel *label;
	IBOutlet UIButton *button;
    IBOutlet UIButton *mynewbutton;
	UIView *newView;
}
-(IBAction) onNext:(id)sender;
-(IBAction)myfunc:(id)sender;
@end

