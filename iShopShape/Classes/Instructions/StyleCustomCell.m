//
//  StyleCustomCell.m
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "StyleCustomCell.h"
#import "Logger.h"

@implementation StyleCustomCell

@synthesize thumbnailImageView;
@synthesize hotspotBgImageView;
@synthesize productNameLbl;
@synthesize productIdLbl;
@synthesize productQtyLbl;
@synthesize hotspotIDLbl;
@synthesize imgDownloader;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    if (self) {
        // Initialization code.		
		self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:thumbnailImageView];
		
//		self.hotspotBgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//		[hotspotBgImageView setImage:[UIImage imageNamed:@"grayStyle_circle.png"]];
//		[self.contentView addSubview:hotspotBgImageView];

		someButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[someButton addTarget:self 
					   action:nil
			 forControlEvents:UIControlEventTouchDown];
		
		[someButton setUserInteractionEnabled:NO];
		[someButton setBackgroundImage:[UIImage imageNamed:@"grayStyle_circle.png"] forState:UIControlStateNormal];
		[someButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
		[someButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
		[someButton.titleLabel setTextColor:[UIColor whiteColor]];
		someButton.frame = CGRectMake(product.xCoordinater,product.yCoordinater,20,20);
		[someButton setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:someButton];
		
		productNameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		productNameLbl.backgroundColor = [UIColor clearColor];
		productNameLbl.opaque = YES;
		productNameLbl.textColor = [UIColor blackColor];
		[productNameLbl setFont:[UIFont boldSystemFontOfSize:18]];
		[self.contentView addSubview:productNameLbl];
		
		productIdLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		productIdLbl.backgroundColor = [UIColor clearColor];
		productIdLbl.opaque = YES;
		productIdLbl.textColor = [UIColor grayColor];
		[self.contentView addSubview:productIdLbl];
		
		productQtyLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		productQtyLbl.backgroundColor = [UIColor clearColor];
		productQtyLbl.opaque = YES;
		productQtyLbl.textColor = [UIColor grayColor];
		[self.contentView addSubview:productQtyLbl];
		
//		hotspotIDLbl = [[UILabel alloc] initWithFrame:CGRectZero];
//		hotspotIDLbl.backgroundColor = [UIColor clearColor];
//		hotspotIDLbl.opaque = YES;
//		[hotspotIDLbl setTextAlignment:UITextAlignmentCenter];
//		[hotspotIDLbl setFont:[UIFont boldSystemFontOfSize:15]];
//		hotspotIDLbl.textColor = [UIColor whiteColor];
//		[self.contentView addSubview:hotspotIDLbl];
		
		activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		[activityIndicator setBackgroundColor:[UIColor clearColor]];
		[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		[activityIndicator setHidesWhenStopped:YES];
		[activityIndicator startAnimating];
		[self.contentView addSubview:activityIndicator];
		
		isDownloading = NO;
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
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    if (!self.editing) 
	{
		// get the X pixel spot
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		// place the menu image
		frame = CGRectMake(boundsX + 10, 6, 98, 98);
		thumbnailImageView.frame = frame;
		
		// place the menu name
//		frame = CGRectMake(boundsX + 276, 6, 20, 20);
//		someButton.frame = frame;
		
		// place the menu name
//		frame = CGRectMake(boundsX + 276, 6, 20, 20);
//		hotspotBgImageView.frame = frame;
		
		// place the badge label
		frame = CGRectMake(boundsX + 120, 6, 150, 30);
		productNameLbl.frame = frame;
		
		// place the badge background
		frame = CGRectMake(boundsX + 120, 31, 150, 30);
		productIdLbl.frame = frame;
		
		// place the badge background
		frame = CGRectMake(boundsX + 120, 56, 100, 35);
		productQtyLbl.frame = frame;
		
		// place the badge background
//		frame = CGRectMake(boundsX + 277.5, 7, 15, 15);
//		hotspotIDLbl.frame = frame;
		
		frame = CGRectMake(boundsX + 40, 30, 20, 20);
		activityIndicator.frame = frame;
	}
}

- (void) setCellData : (Product *)aProduct
{
	product = aProduct;
	
	[self.productNameLbl setText:product.productName];
	[self.productIdLbl setText:product.productCode];
	[self.productQtyLbl setText:[NSString stringWithFormat:@"Qty: %d", product.quantity]];
	//[self.hotspotIDLbl setText:[NSString stringWithFormat:@"%d", product.hotspotNumber]];
	
	float width = 0.0f;
	float xCoordinate = 0.0f;
	if(product.hotspotNumber<10)
	{
		[someButton setBackgroundImage:[UIImage imageNamed:@"grayStyle_circle.png"] forState:UIControlStateNormal];
		width = 20.0f;
		xCoordinate = 276.0f;
	}
	else {
		[someButton setBackgroundImage:[UIImage imageNamed:@"grayStyle_circle_Ex.png"] forState:UIControlStateNormal];
		width = 28.0f;
		xCoordinate = 270.0f;
	}
	
	[someButton setTitle:[NSString stringWithFormat:@"%d", product.hotspotNumber] forState:UIControlStateNormal];
	[someButton setFrame:CGRectMake(xCoordinate, 6, width, 20)];
	
	if(![self isStyleImageExistInCache])
	{
		if(!isDownloading)
		{
			if(product.thumbnailImageName)
			{
				NSLog(@"URL == %@", product.thumbnailImageName);
				NSURL *url = [[NSURL alloc] initWithString:product.thumbnailImageName];
				NSLog(@"URL == %@", url);
				imgDownloader = [[ImageDownloader alloc] initWithRequest:url];
				imgDownloader.delegate = self;
				[imgDownloader startDownload];
				[url release];
				isDownloading = YES;				 
			}
		}
	}
	
}

- (void) stopActivityIndicator
{
	[activityIndicator stopAnimating];
}

- (BOOL) isStyleImageExistInCache
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	//Demo hack
	UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",product.productCode]];
	
	if(image)
	{
		[thumbnailImageView setImage:image];
		//[instructionImageView setImage:image];
		[self stopActivityIndicator];
		return YES;
	}

	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@_thumnail.png",product.productCode];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	BOOL aBool = [fm fileExistsAtPath:pngPath];
	if(aBool)
	{
		UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngPath];
		[thumbnailImageView setImage:img];
		[img release];
		[self stopActivityIndicator];
	}
	return aBool;
}

#pragma mark -
#pragma mark  Save image in cache
#pragma mark -
- (void) saveFileInResourcesFolder:(UIImage *)image
{
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@_thumnail.png",product.productCode];
	
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
	if(isDownloading)
	{
		NSLog(@"Downloaded.........");
		
		[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
		
		if(image)
		{
			[self saveFileInResourcesFolder:image];
			[self.thumbnailImageView setImage:image];
		}
		
	}
	
}

- (void)downloadDidFinishWithError:(NSError *)error
{
	if(isDownloading)
	{
		[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
		
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
		[Logger writeMessage:DEBUG message:message];
		[message release];	
	}
}

- (void)dealloc {
	NSLog(@"StyleCustomCell-----------------------Release");

	imgDownloader.delegate = nil;
	[imgDownloader dealloc];
	[thumbnailImageView release];
//	[hotspotBgImageView release];
	[productNameLbl release];
	[productIdLbl release];
	[productQtyLbl release];
//	[hotspotIDLbl release];
	
    [super dealloc];
}


@end
