//
//  CustomImageView.m
//  iShopShape
//
//  Created by Ayush on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame {
    NSLog(@"i m in");
    self = [super initWithFrame:frame];
    if (self) {
		
    }
    return self;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
    NSLog(@"start");
    if (delegate) {
		[delegate choice:self.tag];
	}

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"end");
}



- (void)dealloc {
    [super dealloc];
}


@end
