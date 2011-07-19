//
//  CameraControlViewController.h
//  CameraControl
//
//  Created by basant on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraControlViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
	IBOutlet UIImageView *i;
}

@property (nonatomic , retain)UIImageView *i;
-(IBAction)Click;
@end

