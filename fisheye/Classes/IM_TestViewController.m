//
//  IM_TestViewController.m
//  IM_Test
//
//  Created by Ayush goel
//

#import "IM_TestViewController.h"


@implementation IM_TestViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set the path so that IM can find the configuration files (*.xml files)
	NSString * path = [[NSBundle mainBundle] resourcePath];
	setenv("MAGICK_CONFIGURE_PATH", [path UTF8String], 1);
    myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,480)];
	myImage=[UIImage imageNamed:@"family.jpeg"];
	myImageView.image=myImage;
  //  [self.view setUserInteractionEnabled:NO];
    [myImageView setUserInteractionEnabled:YES];

    [self.view addSubview:myImageView];

}


- (UIImage*)posterizeImageWithCompression :(UIImage *)blurredImage1
{
	// Here we use JPEG compression.
	NSLog(@"posterizeImageWithCompression");
	
	MagickWandGenesis();// start api call
	
    magick_wand = NewMagickWand(); //creates new object
	NSData * dataObject = UIImagePNGRepresentation(blurredImage1); // converting image to data
	
    MagickBooleanType status;
    
	status = MagickReadImageBlob(magick_wand, [dataObject bytes], [dataObject length]);
	//status=MagickSepiaToneImage(magick_wand, 210);
  
  
	
  //status=MagickAdaptiveBlurImage(magick_wand ,3.0,3.0);
    status=MagickImplodeImage(magick_wand, -3);

	
	size_t my_size;
	unsigned char * my_image = MagickGetImageBlob(magick_wand, &my_size);
	NSData * data = [[NSData alloc] initWithBytes:my_image length:my_size];
	free(my_image);
	magick_wand = DestroyMagickWand(magick_wand);
	
    
    
    MagickWandTerminus(); // end api call
	
    UIImage * image = [[UIImage alloc] initWithData:data];
	[data release];
	
    return [image autorelease];
}





- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
   
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    myImageView.image=[self posterizeImageWithCompression:myImage];
   
    
    
    
    
}




- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {

    [super dealloc];
}

@end
