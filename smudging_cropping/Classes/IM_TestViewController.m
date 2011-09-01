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
	
  
	
  // status=MagickAdaptiveBlurImage(magick_wand ,3.0,3.0);
   // status=MagickImplodeImage(magick_wand, -2);
    PixelWand *myWand=NewPixelWand();
    PixelSetColor(myWand, "#FFFBFF");
    status=MagickSetImageColor(magick_wand,myWand);
  
   
	
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
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    startX=location.x;
    startY=location.y;

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    endX=location.x;
    endY=location.y;
   NSLog(@"start =%d %d end =%d %d",startX,startY,endX,endY);
    if(startX>endX)
    {
        int t;
        t=startX;
        startX=endX;
        endX=t;
    }
    
    if(startY>endY)
    {
        int t;
        t=startY;
        startY=endY;
        endY=t;
    }
    NSLog(@"start =%d %d end =%d %d",startX,startY,endX,endY);
    CGRect clippedRect = CGRectMake(startX, startY,abs(endX-startX),abs(endY-startY));
    UIImage *cropped = [self imageByCropping:myImage toRect:clippedRect];
    blurredImage=[self posterizeImageWithCompression:cropped];
    UIImageView *newView=[[UIImageView alloc]initWithFrame:CGRectMake(startX, startY,abs(endX-startX),abs(endY-startY))];
    newView.image=blurredImage;
  [self.view addSubview:newView];
    
    
    
    
}

- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect1
{
    
    CGImageRef cgImg = CGImageCreateWithImageInRect(imageToCrop.CGImage, rect1);
    UIImage* part = [UIImage imageWithCGImage:cgImg];
    return part;

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
