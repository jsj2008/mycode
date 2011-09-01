//
//  CustomCell.m
//  CustomCellTable
//
//  Created by Santosh B on 30/11/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize nameLbl, ageLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		// Initialization code.
		checkImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:checkImageView];
		
		UIImage *checkedImage = [UIImage imageNamed:@"checked.png"];
		[checkImageView setImage:checkedImage];
		
		
		nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:nameLbl];
		
		ageLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:ageLbl];
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
	
	CGRect frame = CGRectMake(contentRect.origin.x + 40.0, 8.0, contentRect.size.width, 30.0);
	self.nameLbl.frame = frame;
	
	frame = CGRectMake(contentRect.origin.x + 100.0, 30.0, contentRect.size.width, 30.0);
	self.ageLbl.frame = frame;
	
	// layout the check button image
	UIImage *checkedImage = [UIImage imageNamed:@"checked.png"];
	frame = CGRectMake(contentRect.origin.x + 10.0, 12.0, checkedImage.size.width, checkedImage.size.height);
	checkImageView.frame = frame;
	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
