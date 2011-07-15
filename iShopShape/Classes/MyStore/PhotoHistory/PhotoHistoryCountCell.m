//
//  PhotoHistoryCountCell.m
//  iShopShape
//
//  Created by Santosh B on 18/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "PhotoHistoryCountCell.h"


@implementation PhotoHistoryCountCell
@synthesize countLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier total:(int)total {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		countLable = [[UILabel alloc] initWithFrame:CGRectZero];
		[countLable setBackgroundColor:[UIColor clearColor]];
		[countLable setTextColor:[UIColor grayColor]];
		[countLable setText:[NSString stringWithFormat:@"%d Photos", total]];
		[countLable setTextAlignment:UITextAlignmentCenter];
		[self.contentView addSubview:countLable];
    }
    return self;
}

-(void)layoutSubviews{
	
	[super layoutSubviews];
	if (!self.editing) 
	{
		[countLable setFrame:CGRectMake(100, 0, 100, 50)];
		[countLable setCenter:CGPointMake(160, 10)];
	}
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
