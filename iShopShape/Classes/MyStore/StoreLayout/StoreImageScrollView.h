/*

 
 */

#import <UIKit/UIKit.h>

@interface StoreImageScrollView : UIScrollView <UIScrollViewDelegate> {
    UIView        *imageView;
    NSUInteger     index;
}
@property (assign) NSUInteger index;

/**
 *	@functionName	: displayImage
 *	@parameters		:(UIImage *) image - image to be displayed
 *	@return			: (void)
 *	@description	: This method Configure scrollView to display new image
 */
- (void)displayImage:(UIImage *)image;

/**
 *	@functionName	: configureForImageSize
 *	@parameters		:(CGSize)imageSize - size of the image to be dislayed
 *	@return			: (void)
 *	@description	: To scale image needed to perfectly fit the image width-wise and height wise
 */
- (void)configureForImageSize:(CGSize)imageSize;

@end
