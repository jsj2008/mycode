//
//  customcell1.m
//  project
//
//  Created by Ayush Goel on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "customcell1.h"


@implementation customcell1
@synthesize nameLbl;
@synthesize desgn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		// Initialization code.
		desgn = [[UILabel alloc] initWithFrame:CGRectZero];
		[desgn setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:desgn];
		
		nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:nameLbl];
		[nameLbl setBackgroundColor:[UIColor clearColor]];
		
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
	
    CGRect contentRect = [self.contentView bounds];
	
	CGRect frame = CGRectMake(contentRect.origin.x + 10.0, 0, 200, 30);
	self.nameLbl.frame = frame;
	
	frame = CGRectMake(contentRect.origin.x + 70.0, 0, 200, 30);
	self.desgn.frame = frame;
	
	
}

- (void)dealloc {
    [super dealloc];
	[nameLbl dealloc];
	[desgn dealloc];
}


@end
