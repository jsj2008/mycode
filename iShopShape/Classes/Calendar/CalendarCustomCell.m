//
//  CustomCell.m
//  iShopShape
//
//  Created by Ayush on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarCustomCell.h"


@implementation CalendarCustomCell
@synthesize titlename;
@synthesize description;
@synthesize startdate;
@synthesize enddate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
       
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		titlename = [[UILabel alloc] initWithFrame:CGRectZero];
		[titlename setBackgroundColor:[UIColor clearColor]];
		
		[self.contentView addSubview:titlename];
		
		description = [[UILabel alloc] initWithFrame:CGRectZero];
		[description setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:description];
		
		startdate = [[UILabel alloc] initWithFrame:CGRectZero];
		[startdate setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:startdate];
		
		enddate = [[UILabel alloc] initWithFrame:CGRectZero];
		[enddate setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:enddate];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    

}
- (void)layoutSubviews
{  


	self.titlename.font=[UIFont boldSystemFontOfSize:16];
	self.description.font=[ UIFont systemFontOfSize: 14.0 ];
	self.startdate.font=[ UIFont systemFontOfSize: 14.0 ];
	self.enddate.font=[ UIFont systemFontOfSize: 14.0 ];
	[super layoutSubviews];
}


- (void)dealloc {
    [super dealloc];
}


@end
