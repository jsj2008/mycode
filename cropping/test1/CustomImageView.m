//
//  CustomImageView.m
//  iShopShape
//
//  Created by Ayush on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame {
    NSLog(@"i m in");
    self = [super initWithFrame:frame];
    if (self) {
		
    }
    return self;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    startX=location.x;
    startY=location.y;
    NSLog(@"start X: %f",location.x);
    NSLog(@"start Y: %f",location.y);
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    endX=location.x;
    endY=location.y;
    NSLog(@"end X: %f",location.x);
    NSLog(@"end Y: %f",location.y);
   CGRect clippedRect = CGRectMake(startX, startY,endX,endY);
    UIImage *cropped = [self imageByCropping:self.image toRect:clippedRect];
    self.image=cropped;
    self.frame=CGRectMake(50, 50,abs(endX-startX),abs(endY-startY));
    
    
    
    
}

- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //create a context to do our clipping in
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //create a rect with the size we want to crop the image to
    //the X and Y here are zero so we start at the beginning of our
    //newly created context
    CGRect clippedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextClipToRect( currentContext, clippedRect);
    
    //create a rect equivalent to the full size of the image
    //offset the rect by the X and Y we want to start the crop
    //from in order to cut off anything before them
    CGRect drawRect = CGRectMake(rect.origin.x * -1,
                                 rect.origin.y * -1,
                                 imageToCrop.size.width,
                                 imageToCrop.size.height);
    
    //draw the image to our clipped context using our offset rect
    CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
    
    //pull the image from our cropped context
    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    //Note: this is autoreleased
    return cropped;
}




- (void)dealloc {
    [super dealloc];
}


@end
