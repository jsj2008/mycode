//
//  MessageStreamCellInst.m
//  iShopShape
//
//  Created by Santosh B on 04/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "MessageStreamCellInst.h"


@implementation MessageStreamCellInst
@synthesize imageView, messageLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.imageView setImage:[UIImage imageNamed:@"message_stream.png"]];
		[self.contentView addSubview:self.imageView];
		
		self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.messageLabel.backgroundColor = [UIColor clearColor];
		self.messageLabel.opaque = YES;
		self.messageLabel.textColor = [UIColor blackColor];
		[self.messageLabel setText:@"Message stream"];
		[self.messageLabel setFont:[UIFont boldSystemFontOfSize:18]];
		[self.contentView addSubview:self.messageLabel];
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
		self.imageView.frame = frame;
				
		// place the badge label
		frame = CGRectMake(boundsX + 45, 5, 150, 30);
		self.messageLabel.frame = frame;
		

	}
}


- (void)dealloc {
	[imageView release];
	[messageLabel release];
    [super dealloc];
}


@end
