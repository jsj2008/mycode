//
//  mirroringViewController.m
//  mirroring
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mirroringViewController.h"
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@implementation mirroringViewController
@synthesize myView;
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    myView=[[CustomImageView alloc]initWithFrame:CGRectMake(50, 50,200, 200)];
    myImage=[UIImage imageNamed:@"try.jpeg"];
    origImage=[UIImage imageNamed:@"try.jpeg"];
    myView.image=myImage;
    [myView setUserInteractionEnabled:YES];
    [self.view addSubview:myView];
    [myView release];
    tran = CGAffineTransformIdentity;
    angle=0;
    [self createButton];
    

    [super viewDidLoad];
}



-(void) onantique
{  
    UIImage *temp=[self saturation:(-0.65)];
   myView.image=temp;
}

- (UIImage*) saturation:(CGFloat)s
{
  
}

-(void) onpopart
{
    NSLog(@"not possible");
  
}

-(void) onvivid
{
    

   
}
-(void) onBlackandWhite
{

    
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, myImage.size.width, myImage.size.height, 8, myImage.size.width, colorSapce, kCGImageAlphaNone);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, myImage.size.width, myImage.size.height), [myImage CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    
    UIImage *resultImage = [UIImage imageWithCGImage:bwImage]; // This is result B/W image.
    CGImageRelease(bwImage);
    myView.image=resultImage;

}
-(void) onSephia
{
   
        CGImageRef cgImage = [myImage CGImage];
        CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
        CFDataRef bitmapData = CGDataProviderCopyData(provider);
        UInt8* data = (UInt8*)CFDataGetBytePtr(bitmapData); 
        
        int width = myImage.size.width;
        int height = myImage.size.height;
        NSInteger myDataLength = width * height * 4;
        
        
        for (int i = 0; i < myDataLength; i+=4)
        {
            UInt8 r_pixel = data[i];
            UInt8 g_pixel = data[i+1];
            UInt8 b_pixel = data[i+2];
            
            int outputRed = (r_pixel * .393) + (g_pixel *.769) + (b_pixel * .189);
            int outputGreen = (r_pixel * .349) + (g_pixel *.686) + (b_pixel * .168);
            int outputBlue = (r_pixel * .272) + (g_pixel *.534) + (b_pixel * .131);
            
            if(outputRed>255)outputRed=255;
            if(outputGreen>255)outputGreen=255;
            if(outputBlue>255)outputBlue=255;
            
            
            data[i] = outputRed;
            data[i+1] = outputGreen;
            data[i+2] = outputBlue;
        }
        
        CGDataProviderRef provider2 = CGDataProviderCreateWithData(NULL, data, myDataLength, NULL);
        int bitsPerComponent = 8;
        int bitsPerPixel = 32;
        int bytesPerRow = 4 * width;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
        CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
        CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider2, NULL, NO, renderingIntent);
        
        CGColorSpaceRelease(colorSpaceRef); // YOU CAN RELEASE THIS NOW
        CGDataProviderRelease(provider2); // YOU CAN RELEASE THIS NOW
        CFRelease(bitmapData);
        
        UIImage *sepiaImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef); // YOU CAN RELEASE THIS NOW
         myView.image=sepiaImage;
}
-(void) createButton
{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(200,350,100,20);
    [btn setTitle:@"antique" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onantique) 
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0,400,120,20);
    [btn setTitle:@"vivid" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onvivid) 
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(200,400,120,20);
    [btn setTitle:@"popart" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onpopart) 
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn]; 
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20,300,120,20);
    [btn setTitle:@"sephia" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSephia) 
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(150,300,120,20);
    [btn setTitle:@"black and white" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBlackandWhite) 
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
