//
//  ThumbnailCreater.h
//  iShopShape
//
//  Created by Santosh B on 16/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ThumbnailCreater : NSObject {

}
+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize rect:(CGRect)rect;
//+ (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
+ (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
@end
