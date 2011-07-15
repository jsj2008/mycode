//
//  CommentCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 11/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "CommentCustomCell.h"


@implementation CommentCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		commentTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		commentTitle.backgroundColor = [UIColor clearColor];
		commentTitle.opaque = YES;
		
		commentTitle.textColor = [UIColor blackColor];
		[commentTitle setFont:[UIFont boldSystemFontOfSize:18]];
		[commentTitle setText:@"Comments"];
		[self.contentView addSubview:commentTitle];
	
		textView = [[UITextView alloc] initWithFrame:CGRectZero];
		[textView setFont:[UIFont systemFontOfSize:16]];
		[self.contentView addSubview:textView];
		
		[textView setBackgroundColor:[UIColor clearColor]];
		[textView setUserInteractionEnabled:NO];
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
		frame = CGRectMake(boundsX + 10 , 0, 120, 35);
		commentTitle.frame = frame;
	}
}

-(float) calculateHeightForCell:(NSString *)comments
{
	CGSize size = [comments sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(280,400) lineBreakMode:UILineBreakModeWordWrap];
	return size.height + 10;
}

- (void) setCommentsData: (NSString *)comments
{
	CGRect rect = CGRectMake(3, 25, 280, [self calculateHeightForCell:comments]);
	[textView setFrame:rect];
	[textView setText:comments];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
