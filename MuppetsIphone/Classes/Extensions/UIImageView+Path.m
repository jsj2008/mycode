//
//  UIImageView+Path.m
//  Muppets
//
//  Created by Achal Aggarwal on 14/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "UIImageView+Path.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

@implementation UIImageView(Path)

static char url_key;

- (void)setUrl:(NSString *)url {
    objc_setAssociatedObject(self,&url_key,url ,OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)url {
    return objc_getAssociatedObject(self,&url_key);
}

- (void) setImageWithPath:(NSString *) path placeholderImage:(UIImage *)placeholder {
    if ([path rangeOfString:@"http"].location != NSNotFound) {
        [self setImageWithURL:[NSURL URLWithString:path] placeholderImage:placeholder];
        [self setUrl:path];
        return;
    }
    if ([[path componentsSeparatedByString:@"/"] count] > 1) {
        UIImage *_image = [UIImage imageWithContentsOfFile:path];
        [self setFrame:CGRectMake(0, 0, _image.size.width, _image.size.height)];
        [self setImage:_image];
        [self setUrl:path];
        return;
    }
    
    UIImage *_image = [UIImage imageNamed:path];
    [self setUrl:path];
    if (CGRectIsEmpty(self.frame)) {
        [self setFrame:CGRectMake(0, 0, _image.size.width, _image.size.height)];
    }
    [self setImage:_image];
}

@end
