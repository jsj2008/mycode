//
//  CanvasObjectText.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CanvasObjectText.h"

@implementation CanvasObjectText

-(void) setup {
    if (text == nil) {
        text = [[UILabel alloc] init];
        [self addSubview:text];
        text.numberOfLines = 0;
    }
    
    NSString *_text = [content objectForKey:@"text"];
    text.text = _text;
    
    [text setFont:[UIFont fontWithName:[content objectForKey:@"font"] size:[[content valueForKey:@"font-size"] floatValue]]];
    
    CGSize size = [_text sizeWithFont:[UIFont fontWithName:[content objectForKey:@"font"] size:[[content valueForKey:@"font-size"] floatValue]]];
    
    [text setFrame:CGRectMake(0, 0, size.width, size.height)];
    [super autoresize];
}

-(NSDictionary *)serialize {
    NSMutableDictionary *_dictionary = [super serialize];
    [_dictionary setObject:
     [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:text.text, [[text font] fontName], [NSNumber numberWithFloat:[[text font] pointSize]], nil] 
                                 forKeys:[NSArray arrayWithObjects:@"text", @"font", @"font-size", nil]] 
                    forKey:@"content"];
    return _dictionary;
}

- (NSDictionary *) file {
    return nil;
}

@end
