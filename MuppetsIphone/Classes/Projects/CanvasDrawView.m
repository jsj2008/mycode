//
//  CanvasDrawView.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CanvasDrawView.h"
#import "CanvasObjectMuppet.h"

@implementation CanvasDrawView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CanvasObjectMuppet *)speakingMuppet{
    for (id _view in self.subviews) {
        if ([_view isMemberOfClass:[CanvasObjectMuppet class]])
            return _view;
    }
    return nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
