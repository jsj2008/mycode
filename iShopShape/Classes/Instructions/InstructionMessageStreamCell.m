//
//  InstructionMessageStreamCell.m
//  iShopShape
//
//  Created by Santosh B on 29/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "InstructionMessageStreamCell.h"


@implementation InstructionMessageStreamCell
@synthesize cameraButton;
@synthesize delegate;
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (self) {
        // Initialization code.
		cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[cameraButton setImage:[UIImage imageNamed:@"camera_up.png"] forState:UIControlStateNormal];
		[cameraButton setImage:[UIImage imageNamed:@"camera_down.png"] forState:UIControlStateSelected];
		[cameraButton addTarget:self action:@selector(cameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:cameraButton];
		
		[self setBackgroundColor:[UIColor clearColor]];
		
		[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle-bg.png"]]];

		
		imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[imageView setImage:[UIImage imageNamed:@"write_message.png"]];
		[self.contentView addSubview:imageView];
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
		frame = CGRectMake(boundsX + 50, 7, 240, 27);
		imageView.frame = frame;
		
		frame = CGRectMake(boundsX + 7, 3, 36, 36);
		cameraButton.frame = frame;
	}
}

- (void)dealloc {
	delegate =nil;
	[imageView release];
    [super dealloc];
}

#pragma mark -
- (IBAction) cameraButtonAction : (id)sender
{
	if(delegate)
	{
		[delegate cameraButtonActionDelegate];
	}
}

@end
