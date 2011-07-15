//
//  test1ViewController.h
//  test1
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureDevice.h>
#import "CustomImageView.h"




@interface test1ViewController : UIViewController {
    CustomImageView *myView;
   
}
@property(nonatomic,retain) CustomImageView *myView;
@end
