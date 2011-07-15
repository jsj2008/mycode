//
//  GuideNoteCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 20/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "GuideNoteCustomCell.h"


@implementation GuideNoteCustomCell
@synthesize textView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		textView = [[UITextView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:textView];
		[textView setBackgroundColor:[UIColor clearColor]];
		[textView setFont:[UIFont systemFontOfSize:16]];
    }
    return self;
}

- (void)layoutSubviews 
{
	[super layoutSubviews];
	[textView setUserInteractionEnabled:NO];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[textView release];
    [super dealloc];
}


@end
