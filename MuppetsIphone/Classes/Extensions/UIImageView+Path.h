//
//  UIImageView+Path.h
//  Muppets
//
//  Created by Achal Aggarwal on 14/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImageView(Path)

- (NSString *)url;
- (void) setImageWithPath:(NSString *) path placeholderImage:(UIImage *)placeholder;

@end
