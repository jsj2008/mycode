//
//  TestView.h
//  CallOutView


#import <UIKit/UIKit.h>
#import "CallOutView.h"

@interface Test111View : UIView {
	
	NSTimer *timer;
	CGPoint touchPoint;
	CallOutView *callout;
	NSMutableArray *ButtonArray;

}
- (void) createButtons;
@end
