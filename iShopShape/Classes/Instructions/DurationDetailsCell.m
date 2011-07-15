//
//  DurationDetailsCell.m
//  iShopShape
//
//  Created by Santosh B on 04/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "DurationDetailsCell.h"


@implementation DurationDetailsCell
@synthesize durationLbl, startDateLbl, endDateLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // Initialization code.
		durationLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		durationLbl.backgroundColor = [UIColor clearColor];
		durationLbl.opaque = YES;
		
		durationLbl.textColor = [UIColor blackColor];
		[durationLbl setFont:[UIFont boldSystemFontOfSize:18]];
		[self.contentView addSubview:durationLbl];
		
		startDateLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		startDateLbl.backgroundColor = [UIColor clearColor];
		startDateLbl.opaque = YES;
		
		startDateLbl.textColor = [UIColor blackColor];
		[startDateLbl setFont:[UIFont systemFontOfSize:16]];
		[self.contentView addSubview:startDateLbl];
		
		endDateLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		endDateLbl.backgroundColor = [UIColor clearColor];
		endDateLbl.opaque = YES;
		
		endDateLbl.textColor = [UIColor blackColor];
		[endDateLbl setFont:[UIFont systemFontOfSize:16]];
		[self.contentView addSubview:endDateLbl];
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
		durationLbl.frame = frame;
		
		// place the badge background
		frame = CGRectMake(boundsX + 10, 25, 280, 35);
		startDateLbl.frame = frame;
		
		// place the badge background
		frame = CGRectMake(boundsX + 10, 50, 280, 35);
		endDateLbl.frame = frame;
	}
}


- (void) setDurationData: (NSString *)startDate endDate:(NSString*)endDate
{
	[durationLbl setText:@"Duration"];
	[startDateLbl setText:startDate] ; //@"Start: Tuesday, July 5,2010"];
	[endDateLbl setText: endDate]; //@"End: Saturday, July 11,2010"];
}
	 
- (void) setCommentsData: (NSString *)comments
{
	[durationLbl setText:@"Comments"];
	
	CGSize constraintSize ;
	constraintSize.width = 280;
	constraintSize.height = MAXFLOAT;
	
	CGSize stringSize =[comments sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	int addressHeight = stringSize.height;
	NSLog(@"addressHeight == %d", addressHeight);
	CGRect rect = CGRectMake(10, 25, 280, addressHeight + 50);
	[startDateLbl setFrame:rect];
//	startDateLbl.numberOfLines = 0;
//	startDateLbl.lineBreakMode = UILineBreakModeWordWrap;
//	startDateLbl.adjustsFontSizeToFitWidth = YES;
	startDateLbl.backgroundColor = [UIColor clearColor];
	startDateLbl.numberOfLines = 0;
	startDateLbl.lineBreakMode = UILineBreakModeWordWrap;
	startDateLbl.font = [UIFont systemFontOfSize:14.0];
				  
	[endDateLbl setHidden:YES];
	[startDateLbl setText:comments];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[durationLbl release];
	[startDateLbl release];
	[endDateLbl release];
    [super dealloc];
}


@end
