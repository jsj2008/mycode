//
//  GuidesDetailsCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 19/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "GuidesDetailsCustomCell.h"


@implementation GuidesDetailsCustomCell
@synthesize subTitle, guidesTumbnilImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		guidesTumbnilImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:guidesTumbnilImageView];
		[guidesTumbnilImageView setContentMode:UIViewContentModeScaleAspectFit];
		
		subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		subTitle.backgroundColor = [UIColor clearColor];
		subTitle.opaque = YES;
		[subTitle setFont:[UIFont systemFontOfSize:16]];
		subTitle.textColor = [UIColor grayColor];
		[self.contentView addSubview:subTitle];
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
		//frame = CGRectMake(boundsX + 0, 0, 280, 187);
		//guidesTumbnilImageView.frame = frame;
		//guidesTumbnilImageView.center = CGPointMake(0, 0);
		// place the badge label
//		frame = CGRectMake(boundsX + 240, 92, 100, 30);
//		subTitle.frame = frame;
	
		
		
		frame = CGRectMake(boundsX + 240, self.frame.size.height - 29, 100, 30);
		subTitle.frame = frame;
	}
}

-(void) setCellData :(GuidesDetails*)localGuides
{
	[guidesTumbnilImageView setContentMode:UIViewContentModeScaleAspectFit];
	
	UIImage *limage = [UIImage imageNamed:localGuides.stepImageName];
	NSLog(@"--%@--",localGuides.stepImageName);
	guidesTumbnilImageView.frame = CGRectMake(10, 10, limage.size.width, limage.size.height);
	[guidesTumbnilImageView setImage:[UIImage imageNamed:localGuides.stepImageName]];
	

	[subTitle setText:localGuides.stepName];
}

- (void)dealloc 
{
	[subTitle release];
	[guidesTumbnilImageView release];
    [super dealloc];
}


@end
