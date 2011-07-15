//
//  ThumbnailCreater.m
//  iShopShape
//
//  Created by Santosh B on 16/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "ThumbnailCreater.h"


@implementation ThumbnailCreater


+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize rect:(CGRect)rect
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//UIImage *myImage = [self imageByCropping:newImage toRect:CGRectMake(0, 20, 90, 90)];
	UIImage *myImage = [ThumbnailCreater imageByCropping:newImage toRect:rect];
	return myImage;
	//return newImage;
}

+ (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
	CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
	
	UIImage *cropped = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	return cropped;
	
}

@end
