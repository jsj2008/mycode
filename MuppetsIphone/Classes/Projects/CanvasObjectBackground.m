//
//  CanvasObjectBackground.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CanvasObjectBackground.h"

@implementation CanvasObjectBackground
@synthesize background;
-(void) setup {
    if (background == nil) {
        background = [[UIImageView alloc] init];
    }
    [background setImageWithPath:[projectPath stringByAppendingPathComponent:[content objectForKey:@"path"]] placeholderImage:nil];
    [self addSubview:background];
}

- (void) setupAfterCanvas {
    [self setFrame:self.superview.bounds];
    [background setFrame:self.bounds];
    [self.superview sendSubviewToBack:self];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

-(NSDictionary *)serialize {
    NSMutableDictionary *_dictionary = [super serialize];
    [_dictionary setObject:[NSNumber numberWithInt:-1] forKey:@"z-index"];
    [_dictionary setObject:[NSDictionary dictionaryWithObject:[[background url] lastPathComponent] forKey:@"path"] forKey:@"content"];
    return _dictionary;
}

- (NSDictionary *) file {
    NSMutableDictionary *_dictionary = [[[NSMutableDictionary alloc] init] autorelease];
    NSData *imageData = UIImagePNGRepresentation([background image]);
    if (imageData == nil) {
        imageData = UIImageJPEGRepresentation([background image], 1.0f);
    }
    if (imageData != nil) {
        [_dictionary setObject:imageData forKey:[[background url] lastPathComponent]];
    }
    else {
        _dictionary = nil;
    }
    
    return _dictionary;
}

@end
