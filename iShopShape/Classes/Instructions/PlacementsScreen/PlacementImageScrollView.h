/*

 
 */

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@protocol PlacementImageScrollViewDelegate
- (void) dismissCallout;
@end

@interface PlacementImageScrollView : UIScrollView <UIScrollViewDelegate, CustomImageViewDelegate> {
    id <PlacementImageScrollViewDelegate> delegateOne;
	CustomImageView        *imageView;
    NSUInteger     index;
}
@property (nonatomic, assign) id <PlacementImageScrollViewDelegate> delegateOne;
@property (assign) NSUInteger index;
@property (assign) CustomImageView *imageView;
- (void)displayImage:(UIImage *)image;
- (void)configureForImageSize:(CGSize)imageSize;

@end
