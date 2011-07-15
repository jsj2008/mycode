//
//  TestView.h
//  CallOutView


#import <UIKit/UIKit.h>
#import "CallOutView.h"

@interface TestView : UIView {
	
	NSTimer *timer;
	CGPoint touchPoint;
	CallOutView *callout;
	NSMutableArray *ButtonArray;

}
- (void) createButtons;
@end
