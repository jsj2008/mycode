//
//  MyStoreCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 15/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "MyStoreCustomCell.h"


@implementation MyStoreCustomCell
@synthesize menuNameLbl;
@synthesize menuIconImageView;
@synthesize ratingStarImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
		menuIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:menuIconImageView];
		
		menuNameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		menuNameLbl.backgroundColor = [UIColor clearColor];
		menuNameLbl.opaque = YES;
		menuNameLbl.textColor = [UIColor blackColor];
		[menuNameLbl setFont:[UIFont boldSystemFontOfSize:18]];
		[self.contentView addSubview:menuNameLbl];
		
		ratingStarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:ratingStarImageView];
		
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
	
	// getting the cell size
    CGRect contentRect = self.contentView.bounds;
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    if (!self.editing) 
	{
		// get the X pixel spot
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		// place the menu image
		frame = CGRectMake(boundsX + 5, 6, 31, 31);
		menuIconImageView.frame = frame;
		
		// place the menu name
		frame = CGRectMake(boundsX + 45, 6, 150, 30);
		menuNameLbl.frame = frame;
		
		// place the badge background
		frame = CGRectMake(boundsX + 185, 12, 84, 16);
		ratingStarImageView.frame = frame;
	}
}


- (void)dealloc {
	[menuNameLbl release];
	[menuIconImageView release];
	[ratingStarImageView release];
    [super dealloc];
}


@end
