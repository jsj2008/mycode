#import "CustomMessageCell.h"


@implementation CustomMessageCell
@synthesize label;
@synthesize balloonView;
@synthesize ImageView;
@synthesize message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
        message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0, 0)];
		
		
		balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
		ImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.numberOfLines = 0;
		label.lineBreakMode = UILineBreakModeWordWrap;
		label.font = [UIFont systemFontOfSize:14.0];
		 
	
		[balloonView addSubview:ImageView];
		 
		[message addSubview:balloonView];
		[message addSubview:label];
		[self.contentView addSubview:message];
		 [balloonView release];
		[label release];
		 [message release];
				
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
	
}

- (void)dealloc {
    [super dealloc];
	//[balloonView dealloc];
   //[ImageView dealloc];
	//[message dealloc];
    //[label dealloc];
}









@end
