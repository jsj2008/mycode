//
//  CallOutView.h
//  CallOutView


#import <UIKit/UIKit.h>
#import "Product.h"

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
	float left_width ;
	float right_width;
	CGSize size;
	float width;

}

+ (CallOutView*) addCalloutView:(UIView*)parent product:(Product*)product point:(CGPoint)pt target:(id)target action:(SEL)selector;

@property (nonatomic, copy) NSString *text;


@end
