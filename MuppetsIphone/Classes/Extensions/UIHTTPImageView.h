//
//  UIHTTPImageView.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface UIHTTPImageView : UIImageView {
    ASIHTTPRequest *request;
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
