//
//  CustomImageView.m
//  iShopShape
//
//  Created by Ayush on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
		
    }
    return self;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
 }

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
       
    
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    CGRect newFrame=self.frame;
    newFrame.origin.x=location.x;
    newFrame.origin.y=location.y;
    self.frame=newFrame;
    
 
}



- (void)dealloc {
    [super dealloc];
}


@end
