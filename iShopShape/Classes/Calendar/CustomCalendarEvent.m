#import "CustomCalendarEvent.h"


@implementation CustomCalendarEvent
@synthesize titlename;
@synthesize ImageView;
@synthesize description;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		// Initialization code.
		ImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[ImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:ImageView];
		
//		titlename = [[UILabel alloc] initWithFrame:CGRectZero];
//		[titlename setBackgroundColor:[UIColor clearColor]];
//		[self.contentView addSubview:titlename];
		
		description = [[UILabel alloc] initWithFrame:CGRectZero];
		[description setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:description];
		
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)layoutSubviews
{  
	//CGRect contentRect = [self.contentView bounds];
	
	//self.titlename.frame = CGRectMake(contentRect.origin.x+10,10,280,20);
	
	self.description.frame=CGRectMake(10,self.frame.size.height - 25,280,20);	
	//self.titlename.font=[UIFont boldSystemFontOfSize:16];
	
	self.description.font=[ UIFont systemFontOfSize: 14.0 ];
	self.description.textColor = [UIColor grayColor];

	[super layoutSubviews];
}

- (void) setCellData: (NSString*)imageName size:(NSString *)sizeTitle
{
	//self.titlename.text=aCalendarTouch.HeaderLabel;
	UIImage *image = [UIImage imageNamed:imageName];
	
	NSLog(@"Cell %f, Image %f", self.frame.size.width,image.size.width);

	float diff = (300 - image.size.width) / 2;
	
	
	self.ImageView.frame = CGRectMake(diff,10,280,image.size.height);
	
	[self.ImageView setImage:image];
	
	self.description.text=sizeTitle;
}

- (void)dealloc {
    [super dealloc];

}


@end
