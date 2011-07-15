//
//  IM_TestViewController.m
//  IM_Test
//
//  Created by Claudio Marforio on 7/9/09.
//  Copyright Claudio Marforio 2009. All rights reserved.
//

#import "IM_TestViewController.h"

#define NUM_OF_ROUNDS 10
#define DO_BENCHMARKS
// comment this line if you want to do benchmarks
#undef DO_BENCHMARKS

// if you are benchmarking this one isn't taken into account!
#define USE_JPEG_COMPRESSION
// comment this line if you want to use JPEG compression
// #undef USE_JPEG_COMPRESSION

// if you want to use the new method for images with unusual number of bits per component
// thank you to Jon Keane: kean.jon@gmail.com
#define UNUSUAL_NUMBER_OF_BITS
// comment this line if you want to use the new method
#undef UNUSUAL_NUMBER_OF_BITS

// if you want to test PNG files rather than TIFF ones comment this line
#define USE_PNG

#define ThrowWandException(wand) { \
char * description; \
ExceptionType severity; \
\
description = MagickGetException(wand,&severity); \
(void) fprintf(stderr, "%s %s %lu %s\n", GetMagickModule(), description); \
description = (char *) MagickRelinquishMemory(description); \
exit(-1); \
}

@implementation IM_TestViewController

@synthesize imageViewButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set the path so that IM can find the configuration files (*.xml files)
	NSString * path = [[NSBundle mainBundle] resourcePath];
	setenv("MAGICK_CONFIGURE_PATH", [path UTF8String], 1);
	
	// printout ImageMagick version
	NSLog(@"Start:%s End ", GetMagickVersion(nil));

}

- (void)posterizeImageWithCompression 
{
	// Here we use JPEG compression.
	NSLog(@"posterizeImageWithCompression");
	
	MagickWandGenesis();// start api call
	
    magick_wand = NewMagickWand(); //creates new object
	NSData * dataObject = UIImagePNGRepresentation([UIImage imageNamed:@"iphone.png"]); // converting image to data
	
    MagickBooleanType status;
    
	status = MagickReadImageBlob(magick_wand, [dataObject bytes], [dataObject length]);
	
    if (status == MagickFalse) {
		ThrowWandException(magick_wand);
	}
	
	// posterize the image, this filter uses a configuration file, that means that everything in IM should be working great
	//status = MagickOrderedPosterizeImage(magick_wand,"h8x8o");
    status=MagickAdaptiveResizeImage(magick_wand ,200,200);
  //  status=MagickAdaptiveSharpenImage(magick_wand ,200.0,200.0);
   // status=MagickAdaptiveBlurImage(magick_wand ,1.0,1.0);
//status=MagickBrightnessContrastImage(magick_wand ,50.0,50.0);
   // status=MagickFlipImage(magick_wand);
   	if (status == MagickFalse) {
		ThrowWandException(magick_wand);
	}
	
	size_t my_size;
	unsigned char * my_image = MagickGetImageBlob(magick_wand, &my_size);
	NSData * data = [[NSData alloc] initWithBytes:my_image length:my_size];
	free(my_image);
	magick_wand = DestroyMagickWand(magick_wand);
	
    
    
    MagickWandTerminus(); // end api call
	
    UIImage * image = [[UIImage alloc] initWithData:data];
	[data release];
	
	[imageViewButton setImage:image forState:UIControlStateNormal];
	[image release];
}


- (IBAction)posterizeImage 
{
	[self posterizeImageWithCompression];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
	[self.imageViewButton release];
    [super dealloc];
}

@end
