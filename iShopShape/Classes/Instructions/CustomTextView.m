//
//  CustomTextView.m
//  iShopShape
//
//  Created by Santosh B on 17/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "CustomTextView.h"


@implementation CustomTextView

-(void)setContentOffset:(CGPoint)s
{
	[self setBackgroundColor:[UIColor clearColor]];
	if(self.tracking || self.decelerating){
		//initiated by user...
		self.contentInset = UIEdgeInsetsMake(0, -5, 0, 0);
	} else {
		
		float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);
		if(s.y < bottomOffset && self.scrollEnabled){
			self.contentInset = UIEdgeInsetsMake(0, 0, 8, 0); //maybe use scrollRangeToVisible?
		}
		
	}
	
	[super setContentOffset:s];
}

-(void)setContentInset:(UIEdgeInsets)s
{
	UIEdgeInsets insets = s;
	
	if(s.bottom>8) insets.bottom = 0;
	insets.top = -3;
	
	[super setContentInset:insets];
}


- (void)dealloc {
    [super dealloc];
}


@end
