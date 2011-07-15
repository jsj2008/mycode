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
    
    self = [super initWithFrame:frame];
    if (self) {
		//eventname=[[UILabel alloc] initWithFrame:CGRectMake(0, 40,130,20)];
    }
    return self;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
	if (delegate) {
		[delegate imagetouched:self.tag];
	}
	
}

- (void)dealloc {
	NSLog(@"CustomImageView -------------- Release");
	delegate = nil;

    [super dealloc];
}


@end
