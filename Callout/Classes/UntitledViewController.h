//
//  UntitledViewController.h
//  Untitled
//
//  Created by Ayush on 10/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallOutView.h"

@interface UntitledViewController : UIViewController {
	
	NSTimer *timer;
	CGPoint touchPoint;
	CallOutView *callout;
	UIImageView *imageview;
	NSMutableArray *ButtonArray; 	

}
-(void) addbutton;
@end

