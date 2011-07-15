//
//  CallOutView.h
//  CallOutView


#import <UIKit/UIKit.h>


@interface CallOutView : UIView {

	UIImageView *calloutLeft;
	UIImageView *calloutCenter;
	UIImageView *calloutRight;
	UIImageView *calloutImage;
	UIButton *calloutButton;
	UILabel *calloutLabel;
	UILabel *calloutLabel1;
	UILabel *calloutLabel2;
	NSString *text;
	CGAffineTransform transform;
	

}

+ (CallOutView*) addCalloutView:(UIView*)parent text:(NSString*)text point:(CGPoint)pt target:(id)target action:(SEL)selector;

@property (nonatomic, copy) NSString *text;


@end
