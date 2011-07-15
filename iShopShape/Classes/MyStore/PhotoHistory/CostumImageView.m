//
//  CostumImageView.m
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CostumImageView.h"
#import "ThumbnailCreater.h"

@implementation CostumImageView
@synthesize ImageName;
@synthesize delegate;
@synthesize myIndex;

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)name andIndex:(int)indexno{
    
    self = [super initWithFrame:frame];
    if (self) {
		myIndex = indexno;
        // Initialization code.
		UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",name]];
		if(!img)
		{
			img = [UIImage imageNamed:[NSString stringWithFormat:@"Actual_%@",name]];
		}
		if(!img)
		{
			NSString *newPath = [NSString stringWithFormat:@"Documents/%@",name];
			NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
			NSLog(@"pngPath = %@",pngPath);
			//img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",pngPath]];
			
			img = [UIImage imageWithContentsOfFile:pngPath];
			
			
			
			UIImage *image = [ThumbnailCreater imageWithImage:img scaledToSize:CGSizeMake(150, 226) rect:CGRectMake(0, 20, 150, 150)];
			[self setImage:image];
			
		}
		else 
		{
			if(img.size.height == 150.0f && img.size.width == 150.0f)
			{
				[self setImage:img];
			}
			else 
			{
				float percent = img.size.width/260;
				float height = img.size.height/percent;
				UIImage *image = [ThumbnailCreater imageWithImage:img scaledToSize:CGSizeMake(260, height) rect:CGRectMake(60, 20, 150, 150)];
				[self setImage:image];
			}

		}
    }
    return self;
}



- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
	NSLog(@"touched event");
	if(delegate)
	{
		[delegate imageTouched:myIndex];
	}
	
	
}



- (void)dealloc {
	[ImageName release];
    [super dealloc];
}

@end
