//
//  GuidesCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "GuidesCustomCell.h"


@implementation GuidesCustomCell
@synthesize title;
@synthesize subTitle;
@synthesize guidesTumbnilImageView;
@synthesize playButtonImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// Initialization code.
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

		guidesTumbnilImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:guidesTumbnilImageView];
		
		playButtonImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[playButtonImageView setImage:[UIImage imageNamed:@"play_button.png"]];
		[self.contentView addSubview:playButtonImageView];
		
		
		title = [[UILabel alloc] initWithFrame:CGRectZero];
		title.backgroundColor = [UIColor clearColor];
		title.opaque = YES;
		title.textColor = [UIColor blackColor];
		[title setFont:[UIFont boldSystemFontOfSize:20]];
		[self.contentView addSubview:title];
		
		subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		subTitle.backgroundColor = [UIColor clearColor];
		subTitle.opaque = YES;
		[subTitle setFont:[UIFont systemFontOfSize:16]];
		subTitle.textColor = [UIColor grayColor];
		[self.contentView addSubview:subTitle];
		
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
		frame = CGRectMake(boundsX + 20, 5, 60, 60);
		guidesTumbnilImageView.frame = frame;
		
		frame = CGRectMake(boundsX + 35, 20, 30, 30);
		playButtonImageView.frame = frame;
		// place the menu name
		frame = CGRectMake(boundsX + 100, 8, 200, 30);
		title.frame = frame;
		
		// place the badge label
		frame = CGRectMake(boundsX + 100, 35, 200, 30);
		subTitle.frame = frame;
		
	}
}

/**
 *	@functionName	: setCellData
 *	@parameters		: Guides
 *	@return			: void
 *	@description	: This method will populate guide summay to table cell.
 */
-(void) setCellData :(Guides*)localGuides
{
	[self.title setText:localGuides.guideTitle];
	[self.subTitle setText:localGuides.guideSubTitle];
	[self.guidesTumbnilImageView setImage:localGuides.guideImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	NSLog(@"GuidesCustomCell -------------------- Release");
	[title release];
	[subTitle release];
	[guidesTumbnilImageView release];
    [super dealloc];
}


@end
