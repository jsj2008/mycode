//
//  RatingCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 31/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "RatingCustomCell.h"


@implementation RatingCustomCell
@synthesize nameLbl;
@synthesize starImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// Initialization code.
	
		nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		nameLbl.backgroundColor = [UIColor clearColor];
		//nameLbl.opaque = YES;
		//nameLbl.textColor = [UIColor blackColor];
		[nameLbl setFont:[UIFont boldSystemFontOfSize:18]];
		[self.contentView addSubview:nameLbl];
		
		starImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[starImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:starImageView];
		
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
		frame = CGRectMake(boundsX+5 , 12, 200, 20);
		nameLbl.frame = frame;
		// place the menu name
		
		// place the badge label
		frame = CGRectMake(boundsX + 200, 12, 84, 16);
		starImageView.frame = frame;
		
	}
}

/**
 *	@functionName	: setCellData
 *	@parameters		: Guides
 *	@return			: void
 *	@description	: This method will populate guide summay to table cell.
 */
//-(void) setCellData :(Guides*)localGuides
//{
//	[self.title setText:localGuides.guideTitle];
//	[self.subTitle setText:localGuides.guideSubTitle];
//	[self.guidesTumbnilImageView setImage:localGuides.guideImage];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	NSLog(@"RatingCustomCell -------------------- Release");
	[starImageView release];
	[nameLbl release];
    [super dealloc];
}


@end
