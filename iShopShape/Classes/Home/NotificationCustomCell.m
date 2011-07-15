//
//  NotificationCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 15/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "NotificationCustomCell.h"


@implementation NotificationCustomCell
@synthesize badgeNumberLbl;
@synthesize badgeNumberBackgroundView;
@synthesize menuNameLbl;
@synthesize menuIconImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
		menuIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:menuIconImageView];
		
		self.badgeNumberBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.badgeNumberBackgroundView setImage:[UIImage imageNamed:@"badgeBg.png"]];
		[self.contentView addSubview:badgeNumberBackgroundView];
		
		menuNameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		menuNameLbl.backgroundColor = [UIColor clearColor];
		menuNameLbl.opaque = YES;
		menuNameLbl.textColor = [UIColor blackColor];
		[menuNameLbl setFont:[UIFont boldSystemFontOfSize:18]];
		[self.contentView addSubview:menuNameLbl];
		
		badgeNumberLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		badgeNumberLbl.backgroundColor = [UIColor clearColor];
		badgeNumberLbl.opaque = YES;
		[badgeNumberLbl setFont:[UIFont boldSystemFontOfSize:16]];
		badgeNumberLbl.textColor = [UIColor whiteColor];
		[badgeNumberLbl setTextAlignment:UITextAlignmentCenter];
		[self.contentView addSubview:badgeNumberLbl];
		
    }
    return self;
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
		
		// place the badge label
		frame = CGRectMake(boundsX + 248, 6, 20, 30);
		badgeNumberLbl.frame = frame;
		
		// place the badge background
		frame = CGRectMake(boundsX + 243, 11, 30, 21);
		badgeNumberBackgroundView.frame = frame;
	}
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc 
{
	[menuNameLbl release];
	[badgeNumberLbl release];
	[menuIconImageView release];
	[badgeNumberBackgroundView release];
    [super dealloc];
}


@end
