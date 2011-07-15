//
//  NotificationTableCell.m
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "NotificationTableCell.h"


@implementation NotificationTableCell
@synthesize notificationLable;
@synthesize bgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
        // Initialization code.
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		notificationLable = [[UILabel alloc] initWithFrame:CGRectZero];
		[notificationLable setBackgroundColor:[UIColor clearColor]];
		notificationLable.numberOfLines = 0;
		notificationLable.lineBreakMode = UILineBreakModeWordWrap;
		notificationLable.textAlignment = UITextAlignmentLeft;
		[notificationLable setFont:[UIFont systemFontOfSize:14.0f]];
		[self.contentView addSubview:notificationLable];
		
		bgView = [[UIView alloc] initWithFrame:CGRectZero];
		[bgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"newNotifications_bg.png"]]];
		[self setBackgroundView:bgView];
		[bgView release];
    }
	
    return self;
}


- (void) setCellData : (NSString*)aString
{
	NSString *notificationTitle = [NSString stringWithFormat:@"VM has replied to your %@ message", aString];
	//CGSize size = [notificationTitle sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(320.0f, 80.0f) lineBreakMode:UILineBreakModeWordWrap];

	CGSize constraintSize ;
	constraintSize.width = 280;
	constraintSize.height = MAXFLOAT;
	
	CGSize stringSize =[notificationTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	 
	notificationLable.frame=CGRectMake(10,0,stringSize.width,stringSize.height+20);
	[notificationLable setText:notificationTitle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)layoutSubviews 
{
	[super layoutSubviews];
	

	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    if (!self.editing) 
	{
		// get the X pixel spot

		CGRect frame;
		
		frame = CGRectMake(0, 0, 320, self.frame.size.height);
		bgView.frame = frame;
		
	}
}

- (void)dealloc {
	NSLog(@"NotificationTableCell------------------------Release");
	[notificationLable release];
    [super dealloc];
}


@end
