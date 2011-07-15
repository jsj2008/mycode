//
//  ExpandView.m
//  iShopShape
//
//  Created by Santosh B on 07/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "ExpandView.h"


@implementation ExpandView

@synthesize currentTag;

#define CENTER_IMAGE_WIDTH  66
#define CALLOUT_HEIGHT  120
#define LABEL_FONT_SIZE  18


#pragma mark - Comment this will set the anchor point Y position from the click
#define ANCHOR_Y  120

//static UIImage *CALLOUT_LEFT_IMAGE;
//
//static UIImage *CALLOUT_CENTER_IMAGE;
//static UIImage *CALLOUT_RIGHT_IMAGE;

#pragma mark -
#pragma mark Comment -- By setting this value we can move the anchor point to middle or right or left
#pragma mark left = 32 middle = 100 and right = 160

float ANCHOR_X = 160;

#define RECTFRAME CGRectMake (0, 0, 300, CALLOUT_HEIGHT)
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
    }
    return self;
}

- (void) createCallout : (Product *)product
{

	self.backgroundColor = [UIColor clearColor];
	
	calloutImageView = [[UIImageView alloc] init];
	[calloutImageView setImage:[UIImage imageNamed:@"CallOutWhite.png"]];
	[self addSubview:calloutImageView];
	[calloutImageView release];
	
	productImage = [[UIImageView alloc] initWithFrame:CGRectMake(-35,-10, 75, 75)];
	productImage.backgroundColor=[UIColor clearColor];
	[self addSubview:productImage];
	[productImage release];
	
	UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",product.productCode]];
	if(image)
	{
		[productImage setImage:image];
	}
	else 
	{
		NSString *newPath = [NSString stringWithFormat:@"Documents/%@_thumnail.png",product.productCode];
		
		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
		
		UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngPath];
		[productImage setImage:img];
		[img release];		
	}
	
	
	productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,-20, 140 , 50)];
	productNameLabel.font = [UIFont boldSystemFontOfSize:LABEL_FONT_SIZE];
	productNameLabel.textColor = [UIColor blackColor];
	[productNameLabel setText:product.productName];
	
	productNameLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:productNameLabel];
	[productNameLabel release];
	
	productIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, 100 , 20)];
	productIdLabel.font = [UIFont systemFontOfSize:13];
	productIdLabel.textColor = [UIColor blackColor];
	[productIdLabel setText:[NSString stringWithFormat:@"%@",product.productCode]];
	productIdLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:productIdLabel];
	[productIdLabel release];
	
	quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 100 , 20)];
	quantityLabel.font = [UIFont systemFontOfSize:13];
	quantityLabel.textColor = [UIColor blackColor];
	[quantityLabel setText:[NSString stringWithFormat:@"Qty : %d",product.quantity]];
	quantityLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:quantityLabel];
	[quantityLabel release];
}

- (void) layoutSubviews
{
	[calloutImageView setFrame:CGRectMake(-40, -22, 230, 120)];
}

- (void)dealloc {
	NSLog(@"ExpandView --------------------------- Release");
    [super dealloc];
}


@end
