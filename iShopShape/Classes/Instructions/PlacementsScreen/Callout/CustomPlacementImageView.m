//
//  CustomPlacementImageView.m
//  iShopShape
//
//  Created by Santosh B on 07/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "CustomPlacementImageView.h"


@implementation CustomPlacementImageView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	if(delegate)
	{
		[delegate touchDetected];
	}
}

- (void)dealloc {
	delegate = nil;
    [super dealloc];
}


@end
