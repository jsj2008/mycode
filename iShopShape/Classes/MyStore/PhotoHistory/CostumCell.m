//
//  CustomCell.m
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CostumCell.h"
#import "StoreImageObj.h"

@implementation CostumCell

@synthesize arrayOfImageView;
@synthesize delegate;
@synthesize weekKey;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withImageArray:(NSMutableArray *)images withkey:(int)key{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
        
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		weekKey = key;
		imagesArray = images;
		
		arrayOfImageView = [[NSMutableArray alloc] init];
		
		for (int i = 0; i < [images count]; i++) 
		{
			StoreImageObj *store = [images objectAtIndex:i];
			CostumImageView *imgView = [[CostumImageView alloc]initWithFrame:CGRectZero withImageName:[store imageName] andIndex:i  ] ;
			
			[imgView setUserInteractionEnabled:YES];	
			
			[imgView setDelegate:self];
			
			[self.contentView addSubview:imgView];
			
			[arrayOfImageView addObject:imgView];
			
			[imgView release];
			
		}
		
    }
    return self;
}

-(void)layoutSubviews{
	
	[super layoutSubviews];
	
	  if (!self.editing) 
	  {
		int x ,y ,index = 0,count = [arrayOfImageView count],row = 1;
		
		for (int j = 1; (index < count); j++) 
		{
			UIImageView * view = [arrayOfImageView	objectAtIndex:index];
			
			x = (4*(j -1) + 75*(j -1));
			
			y =  (10 *(row -1) + 75 * (row -1));
			
			CGRect frame = CGRectMake(x+4, y+5, 75, 75);
			[view setFrame:frame];
			index++;
			if (j==4) {
				
				row++;	//to set y
				j=0;	//to set x
			}
		}
	  }
}

- (void) setCellData : (NSArray *)array withKey:(int)key
{
	if(arrayOfImageView)
	{
		for(int iLoop =0 ; iLoop<[arrayOfImageView count]; iLoop++)
		{
			CostumImageView *imgView = [arrayOfImageView objectAtIndex:iLoop];
			[imgView removeFromSuperview];
		}
		[arrayOfImageView removeAllObjects];
	}

	weekKey = key;
	for (int i = 0; i < [array count]; i++) 
	{
		StoreImageObj *store = [array objectAtIndex:i];
		CostumImageView *imgView = [[CostumImageView alloc] initWithFrame:CGRectZero withImageName:[store imageName] andIndex:i  ] ;
		
		[imgView setUserInteractionEnabled:YES];	
		
		[imgView setDelegate:self];
		
		[self.contentView addSubview:imgView];
		
		[arrayOfImageView addObject:imgView];
		
		[imgView release];
		
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


-(void)imageTouched:(int)myIndex	//implementing hte interface method
{
	
	if(delegate)
	{
		[delegate CostumCellImageTouchEvent:myIndex weekKey:weekKey];
	}
	
}
- (void)dealloc {
	[arrayOfImageView release];
	arrayOfImageView = nil;
	
	[imagesArray release];
	imagesArray = nil;
    [super dealloc];
}

@end
