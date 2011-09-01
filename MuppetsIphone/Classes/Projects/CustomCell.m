//
//  CustomCell.m
//  CustomCellTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize titleLabel;
@synthesize checkImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		// Initialization code.
		checkImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:checkImageView];
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:titleLabel];
		
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
    CGRect contentRect = [self.contentView bounds];
	
	CGRect frame = CGRectMake(contentRect.origin.x + 120.0, 8.0, 300, 40.0);
	self.titleLabel.frame = frame;
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont boldSystemFontOfSize:25];
	
	frame = CGRectMake(contentRect.origin.x + 10.0, 12.0, 80, 50);
	checkImageView.frame = frame;
    checkImageView.backgroundColor=[UIColor clearColor];
	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
