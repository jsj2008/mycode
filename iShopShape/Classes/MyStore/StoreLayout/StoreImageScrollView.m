

#import "StoreImageScrollView.h"
@implementation StoreImageScrollView
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;        
    }
    return self;
}

- (void)dealloc
{
    [imageView release];
	imageView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Override layoutSubviews to center content

- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    // center the image as it becomes smaller than the size of the screen

    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = imageView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
	{
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
	else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
    {
		frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
	else
        frameToCenter.origin.y = 0;
    
    imageView.frame = frameToCenter;
}

#pragma mark -
#pragma mark UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

#pragma mark -
#pragma mark Configure scrollView to display new image (tiled or not)

- (void)displayImage:(UIImage *)image
{
    
    // reset our zoomScale to 1.0 before doing any further calculations
    self.zoomScale = 1.0;

    // make a new UIImageView for the new image
    imageView = [[UIImageView alloc] initWithImage:image];
	//NSLog(@"%f %f", imageView.frame.size.width,imageView.frame.size.height );
    [self addSubview:imageView];
    
    [self configureForImageSize:[image size]];
}


- (void)configureForImageSize:(CGSize)imageSize 
{
	//CGSize boundsSize = CGSizeMake(320, 420);
    CGSize boundsSize = [self bounds].size;
                
    // set up our content size and min/max zoomscale
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    self.contentSize = imageSize;
    self.maximumZoomScale = 1;//maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;  // start out with the content fully visible
}

@end
