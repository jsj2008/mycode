//
//  CanvasObjectMuppet.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CanvasObjectMuppet.h"

@implementation CanvasObjectMuppet

@synthesize muppet;
@synthesize speech;

-(id) initWithDictionary:(NSDictionary *) dictionary andPath:(NSString *) path{
    self = [super initWithDictionary:dictionary andPath:path];
    if (self) {
        self.speech = [dictionary objectForKey:@"speech"];
    }
    return self;
}

-(void) setup {
    muppet = [[Muppet alloc] initWithPath:[content objectForKey:@"path"]];
    
    NSArray *abc = [[NSBundle mainBundle] loadNibNamed:@"CanvasObjectMuppet" owner:self options:nil];
    for (UIView *v in [[abc objectAtIndex:0] subviews]) {
        [self addSubview:v];
    }
    
    head = (UIImageView *)[self viewWithTag:1];
    eyes = (UIImageView *)[self viewWithTag:2];
    body = (UIImageView *)[self viewWithTag:3];
    shirt = (UIImageView *)[self viewWithTag:4];
    mouth = (UIImageView *)[self viewWithTag:5];
    
    [self update];
}

-(void) update {
    [head setImageWithPath:muppet.head placeholderImage:nil];
    [body setImageWithPath:muppet.body placeholderImage:nil];
    [eyes setImageWithPath:muppet.eyes placeholderImage:nil];
    [shirt setImageWithPath:muppet.shirt placeholderImage:nil];
    [mouth setImageWithPath:muppet.mouth placeholderImage:nil];
    [super autoresize];
}

-(void)doubleTap:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMuppetBuilder" object:self];
}

-(void) dealloc {
    [speech release];
    [muppet release];
    [super dealloc];
}

- (void)speak{
    if (_speaking) {
        mouth.image = _mouthOpen ? [UIImage imageNamed:@"mouth-close.png"] : [UIImage imageNamed:@"mouth-open.png"];
        _mouthOpen = !_mouthOpen;
        [self performSelector:@selector(speak) withObject:nil afterDelay:0.2f];
    }
}

-(NSDictionary *)serialize {
    NSMutableDictionary *_dictionary = [super serialize];
    [_dictionary setObject:[NSDictionary dictionaryWithObject:[[muppet muppetPath] lastPathComponent] forKey:@"path"] forKey:@"content"];
    [muppet save];
    return _dictionary;
}

- (NSDictionary *) file {
    return nil;
}

// animated uiimage is not rendered in the video
// so changing images manually
- (void)startSpeaking{
    _speaking = YES;
    _mouthOpen = NO;
    [self speak];
}

- (void)stopSpeaking{
    _speaking = NO;
    mouth.image = [UIImage imageNamed:@"mouth-close.png"];
}

@end
