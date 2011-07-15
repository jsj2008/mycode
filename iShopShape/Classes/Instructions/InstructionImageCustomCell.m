//
//  InstructionImageCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "InstructionImageCustomCell.h"
#import "Product.h"
#import "Logger.h"


@implementation InstructionImageCustomCell
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
        // Initialization code.
		imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:imageView];
		
		isDownloading = NO;
		
		firstScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
		[firstScrollView setUserInteractionEnabled:NO];
		[firstScrollView setBackgroundColor:[UIColor clearColor]];
				
		customImageView = [[CustomPlacementImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
		[customImageView setBackgroundColor:[UIColor clearColor]];

		[customImageView setUserInteractionEnabled:NO];
		[customImageView setContentMode:UIViewContentModeScaleAspectFit];
		imageViewHolderFrame = CGRectMake(0, 0, 200, 200);
				
		[firstScrollView setContentSize:CGSizeMake(300, 200)];
		
		[firstScrollView setMaximumZoomScale:1.0f];
		[firstScrollView setMinimumZoomScale:1.0f];
		
		imageViewHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
		[imageViewHolder setBackgroundColor:[UIColor clearColor]];
		[imageViewHolder addSubview:customImageView];
		[firstScrollView addSubview:imageViewHolder];
		[firstScrollView setScrollEnabled:NO];
		[self.contentView addSubview:firstScrollView];
		
		arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[arrowImageView setImage:[UIImage imageNamed:@"arrow.png"]];
		[arrowImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:arrowImageView];
		
		activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		[activityIndicator setBackgroundColor:[UIColor clearColor]];
		[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		[activityIndicator setHidesWhenStopped:YES];
		[activityIndicator startAnimating];
		[self.contentView addSubview:activityIndicator];
		
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
	
	// getting the cell size
    CGRect contentRect = self.contentView.bounds;
	
	if(!done)
	{
	// In this example we will never be editing, but this illustrates the appropriate pattern
		if (!self.editing) 
		{
			// get the X pixel spot
			CGFloat boundsX = contentRect.origin.x;
			CGRect frame;
			
			// place the menu image
			frame = CGRectMake(boundsX + 10, 6, 280, 200);
			imageView.frame = frame;
			
			// place the menu image
			frame = CGRectMake(boundsX + 280, self.contentView.frame.size.height - 25, 12, 16);
			arrowImageView.frame = frame;
			
			frame = CGRectMake(boundsX + 135, 100, 30, 30);
			activityIndicator.frame = frame;
		
			//Demo hack
			UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",instruction.instId]];
			
			if(image)
			{
				[image retain];
				//[instructionImageView setImage:image];
			}
			else 
			{
				NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
				NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
				
				image = [[UIImage alloc] initWithContentsOfFile:pngPath];
			}
			if(image)
			{
				float maxZoomLevel = 0.0f;
	//			if(image.size.width > image.size.height)
				{
					maxZoomLevel = image.size.width / self.contentView.frame.size.width;
				}
	//			else 
	//			{
	//				maxZoomLevel = image.size.height / self.contentView.frame.size.height;
	//			}

			
			[firstScrollView setMaximumZoomScale:maxZoomLevel];
			
			CGRect imageRect = CGRectMake( 0, 0, image.size.width/maxZoomLevel , image.size.height/maxZoomLevel);
			
			NSLog(@"Width == %f Height == %f", imageRect.size.width, imageRect.size.height);
				
			customImageView.frame = imageRect;
			imageViewHolderFrame = imageRect;
			
			[firstScrollView setFrame:CGRectMake(0, 0, imageRect.size.width, imageRect.size.height)];
			[firstScrollView setCenter: CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2)];
			[firstScrollView setContentSize:imageViewHolderFrame.size];
			
			[customImageView setCenter:CGPointMake( imageViewHolderFrame.size.width / 2.0f, imageViewHolderFrame.size.height / 2.0f)];
			
			imageViewHolder.frame = imageViewHolderFrame;
			
			CGSize backgroundImageSize = CGSizeMake(image.size.width/maxZoomLevel + 2, image.size.height/maxZoomLevel + 2);
			UIImage *bgImage = [self imageWithImage:image scaledToSize:backgroundImageSize];
			//[customImageView setImage:bgImage];
				[self setBackgroundColor:[UIColor colorWithPatternImage:bgImage]];
				
			[image release];
				
			int iLoop =0;
				
			for(Product *product in instruction.styleProductArray)	
			{
				
				UIButton *someButton = [UIButton buttonWithType:UIButtonTypeCustom];
				[someButton addTarget:self 
							   action:nil
					 forControlEvents:UIControlEventTouchDown];
				someButton.tag = iLoop;
				iLoop++;
				[someButton setUserInteractionEnabled:NO];
				
				float width = 0.0f;
				if(product.hotspotNumber<10)
				{
					[someButton setBackgroundImage:[UIImage imageNamed:@"grayStyle_circle.png"] forState:UIControlStateNormal];
					width = 20.0f;
				}
				else {
					[someButton setBackgroundImage:[UIImage imageNamed:@"grayStyle_circle_Ex.png"] forState:UIControlStateNormal];
					width = 28.0f;
				}
				
				//[someButton setBackgroundImage:[UIImage imageNamed:@"grayStyle_circle.png"] forState:UIControlStateNormal];
				[someButton setTitle:[NSString stringWithFormat:@"%d", product.hotspotNumber] forState:UIControlStateNormal];
				[someButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
				[someButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
				[someButton.titleLabel setTextColor:[UIColor whiteColor]];
				someButton.frame = CGRectMake(product.xCoordinater,product.yCoordinater,width,20);
				[someButton setBackgroundColor:[UIColor clearColor]];
				
				CGPoint someViewCenter = [someButton center];
				someViewCenter.x = customImageView.frame.origin.x + (product.xCoordinater/ maxZoomLevel);
				someViewCenter.y = customImageView.frame.origin.y + ( product.yCoordinater/ maxZoomLevel) ;
				[someButton setCenter:someViewCenter];
				
				[firstScrollView addSubview:someButton];
			}
			
			
			CGRect visibleRect = CGRectZero;
			visibleRect.origin = CGPointMake( (imageViewHolderFrame.size.width / 2.0f) - (firstScrollView.frame.size.width / 2.0f), (imageViewHolderFrame.size.height / 2.0f) - (firstScrollView.frame.size.height / 2.0f));
			visibleRect.size = [firstScrollView frame].size;
			
			[firstScrollView scrollRectToVisible:visibleRect animated:NO];
			}
		}
		done = YES;
	}
}
- (void)dealloc {
	NSLog(@"InstructionImageCustomCell-----------------------Release");
	
	[firstScrollView release];
	
	[imageViewHolder release];
	
	[customImageView release];
	
	[imageView release];
    [super dealloc];
}


- (void) stopActivityIndicator
{
	[activityIndicator stopAnimating];
}

//-(UIImage *)setCornerImage: (NSString *)imageName
//{
//	UIImage *img = nil;
//	UIImage * resourceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",instruction.instId]];
//	if(resourceImage)
//		img = resourceImage;
//	else 
//	{
//		NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
//		
//		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
//		NSFileManager *fm = [NSFileManager defaultManager];
//		BOOL aBool = [fm fileExistsAtPath:pngPath];
//		if(aBool)
//		{
//			img = [[UIImage alloc] initWithContentsOfFile:pngPath];
//		}
//	}
//
//	float maxZoomLevel = img.size.width / self.contentView.frame.size.width;
//	
//    int w = img.size.width/maxZoomLevel;
//    int h = img.size.height/maxZoomLevel;
//	
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//	
//    CGContextBeginPath(context);
//    CGRect rect = CGRectMake(0, 0, w, h);
//	
//	
//    addRoundedRectToPath(context, rect, 50, 2);
//    CGContextClosePath(context);
//    CGContextClip(context);
//	
//    CGContextDrawImage(context, rect, img.CGImage);
//	
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    [img release];
//	
//    return [UIImage imageWithCGImage:imageMasked];
//}
//

- (BOOL) isInstructionImageExistInCache
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	//Demo hack
	UIImage * resourceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",instruction.instId]];
	
	
	if(resourceImage)
	{
		
		//[self setCornerImage:instruction.instId];
		//[customImageView setImage:resourceImage];
		//[self setBackgroundColor:[UIColor colorWithPatternImage:resourceImage]];
		[self stopActivityIndicator];
		return TRUE;
	}
	
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	BOOL aBool = [fm fileExistsAtPath:pngPath];
	if(aBool)
	{
		UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngPath];
		//[self setCornerImage:instruction.instId];
		//[customImageView setImage:img];
		
		//[self setBackgroundColor:[UIColor colorWithPatternImage:img]];
		[img release];
		[self stopActivityIndicator];
	}
	return aBool;
}

- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}
/**
 *	@functionName	: setCellData
 *	@parameters		: Instruction
 *	@return			: void
 *	@description	: This method will populate instruction summay to table cell.
 */
-(void) setCellData :(Instruction*)localInstruction
{		
	instruction = localInstruction;
	if(![self isInstructionImageExistInCache])
	{
		if(!isDownloading)
		{
			
			if(localInstruction.instructionImage)
			{
				NSArray *array = [localInstruction.instructionImage componentsSeparatedByString:@".png"];
				
				NSString *newPath = [NSString stringWithFormat:@"%@.png",[array objectAtIndex:0]];
				NSURL *url = [[NSURL alloc] initWithString:newPath];
				imgDownloader = [[[ImageDownloader alloc] initWithRequest:url] autorelease];
				imgDownloader.delegate = self;
				[imgDownloader startDownload];
				[url release];
				isDownloading = YES;				 
			}
		}
	}
}



- (void)resetCell
{
	[self performSelectorOnMainThread:@selector(layoutSubviews) withObject:nil waitUntilDone:YES];
}

#pragma mark -
#pragma mark  Save image in cache
#pragma mark -
- (void) saveFileInResourcesFolder:(UIImage *)image
{
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	
	[UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
	
	// Let's check to see if files were successfully written...
	
	// Create file manager
	NSError *error = nil;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	
	// Point to Document directory
	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	// Write out the contents of home directory to console
	NSLog(@"saveFileInResourcesFolder Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}


#pragma mark -
#pragma mark ImageDownloaderDelegate
#pragma mark -

- (void)downloadDidFinishDownloading:(UIImage *)image index:(NSIndexPath *)indexPath
{
	NSLog(@"Downloaded.........");
	
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
	
	if(image)
	{
		[self saveFileInResourcesFolder:image];
		[self resetCell];
	}
	
}

- (void)downloadDidFinishWithError:(NSError *)error
{
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
	
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];	
	
}

@end
