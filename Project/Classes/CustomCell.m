//
//  CustomCell.m
//  CustomCellTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize nameLbl;
@synthesize checkImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		// Initialization code.
		checkImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:checkImageView];
		
		nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:nameLbl];
		
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
	
	CGRect frame = CGRectMake(contentRect.origin.x + 70.0, 8.0, contentRect.size.width, 30.0);
	self.nameLbl.frame = frame;
	
	frame = CGRectMake(contentRect.origin.x + 10.0, 12.0, 50, 50);
	self.checkImageView.frame = frame;
	
	
}

- (void)dealloc {
    [super dealloc];
	[nameLbl dealloc];
	[checkImageView dealloc];
}


@end
