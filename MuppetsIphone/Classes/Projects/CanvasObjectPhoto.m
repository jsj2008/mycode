//
//  CanvasObjectPhoto.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CanvasObjectPhoto.h"

@implementation CanvasObjectPhoto

-(void) setup {
    if (image == nil) {
        image = [[UIImageView alloc] init];
    }
    
    [image setImageWithPath:[projectPath stringByAppendingPathComponent:[content objectForKey:@"name"]] placeholderImage:nil];
    
    [self addSubview:image];
    [super autoresize];
}

-(NSDictionary *)serialize {
    NSMutableDictionary *_dictionary = [super serialize];
    [_dictionary setObject:[NSDictionary dictionaryWithObject:[[image url] lastPathComponent] forKey:@"name"] forKey:@"content"];
    return _dictionary;
}

- (NSDictionary *) file {
    NSMutableDictionary *_dictionary = [[[NSMutableDictionary alloc] init] autorelease];
    NSData *imageData = UIImagePNGRepresentation([image image]);
    [_dictionary setObject:imageData forKey:[[image url] lastPathComponent]];
    return _dictionary;
}

@end
