//
//  InstructionsCutomCell.m
//  iShopShape
//
//  Created by Santosh B on 16/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "InstructionsCutomCell.h"
#import "Logger.h"
#import "DatabaseHandler.h"


@implementation InstructionsCutomCell
@synthesize instructionNameLbl;
@synthesize dueStatusLbl;
@synthesize instructionImageView;
@synthesize statusDoneButton;
@synthesize imgDownloader;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		//[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		instructionBorderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_box.png"]];
		[instructionBorderImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:instructionBorderImageView];
		
		instructionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[instructionImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:instructionImageView];
		
		instructionNameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		instructionNameLbl.backgroundColor = [UIColor clearColor];
		instructionNameLbl.opaque = YES;
		instructionNameLbl.textColor = [UIColor blackColor];
		[instructionNameLbl setFont:[UIFont boldSystemFontOfSize:17]];
		[self.contentView addSubview:instructionNameLbl];
		
		dueStatusLbl = [[UILabel alloc] initWithFrame:CGRectZero];
		dueStatusLbl.backgroundColor = [UIColor clearColor];
		dueStatusLbl.opaque = YES;
		[dueStatusLbl setFont:[UIFont systemFontOfSize:15]];
		dueStatusLbl.textColor = [UIColor grayColor];
		[self.contentView addSubview:dueStatusLbl];
		
		statusDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[statusDoneButton setFrame:CGRectZero];
		[statusDoneButton setImage:[UIImage imageNamed:@"deselect.png"] forState:UIControlStateNormal];
		[statusDoneButton addTarget:self action:@selector(changeStatusDoneAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:statusDoneButton];
		
		activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		[activityIndicator setBackgroundColor:[UIColor clearColor]];
		[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		[activityIndicator setHidesWhenStopped:YES];
		[activityIndicator startAnimating];
		[self.contentView addSubview:activityIndicator];
		isDownloading = NO;
		isActualImageDownloading = NO;
    }
    return self;
}

- (void) postInstructionExecuted 
{
	NSString *str = [NSString stringWithFormat:@"%@/%@/yes", POST_EXECUTION_STATUS_URL,instruction.instId];
	NSURL *url = [NSURL URLWithString:str];
	
	HTTPServicePOSTHandlerObj = [[HTTPServicePOSTHandler alloc] init];
	[HTTPServicePOSTHandlerObj postInstructionComments:url];
	HTTPServicePOSTHandlerObj.delegate = self;
}

- (IBAction) changeStatusDoneAction : (id) sender
{
	if(!instruction.isExecuted)
	{
		instruction.isExecuted = instruction.isExecuted ? NO : YES;
		
		UIImage *statusImage = instruction.isExecuted ? [UIImage imageNamed:@"select.png"] : [UIImage imageNamed:@"deselect.png"];
		
		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
		
		if(!instruction.isExecuted)
		{
			[self.dueStatusLbl setTextColor:[UIColor redColor]];
		}
		else
		{
			[self postInstructionExecuted];
			[[DatabaseHandler sharedInstance] updateInstruction:instruction.instId aBool:YES];
			
			[self.dueStatusLbl setTextColor:[UIColor grayColor]];
			
		}
	}
	else {
		instruction.isExecuted = NO;
		[[DatabaseHandler sharedInstance] updateInstruction:instruction.instId aBool:NO];
		[self postInstructionExecuted];
		[self setButtonCurrentStatus];
	}

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
		frame = CGRectMake(boundsX + 45, 0, 64, 60);
		instructionBorderImageView.frame = frame;
		
		instructionImageView.frame = CGRectMake(53, 3, 49, 49);
		
		// place the menu name
		frame = CGRectMake(boundsX + 115, 0, 150, 30);
		instructionNameLbl.frame = frame;
		
		// place the badge label
		frame = CGRectMake(boundsX + 115, 23, 200, 30);
		dueStatusLbl.frame = frame;
		
		// place the status button
		frame = CGRectMake(boundsX, 4, 50, 50);
		statusDoneButton.frame = frame;
		
		frame = CGRectMake(boundsX + 60, 25, 20, 20);
		activityIndicator.frame = frame;
	}
}


-(int)howManyDaysHavePast:(NSDate*)lastDate today:(NSDate*)today 
{
	NSDate *startDate = lastDate;
	NSDate *endDate = today;
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSDayCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate options:0];
	int days = [components day];
	[gregorian release];
	return days;
}

- (void)actualImageDownload
{
	NSArray *array = [instruction.instructionImage componentsSeparatedByString:@".png"];
	
	NSString *newPath = [NSString stringWithFormat:@"%@.png",[array objectAtIndex:0]];
	NSURL *url = [[NSURL alloc] initWithString:newPath];
	imgDownloaderBg = [[[ImageDownloaderBackground alloc] initWithRequest:url] autorelease];
	imgDownloaderBg.instructionId = instruction.instId;
	[imgDownloaderBg startDownload];
	[url release];
	isActualImageDownloading = YES;
}

- (BOOL) isActualInstructionImageExistInCache
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	//Demo hack
	UIImage * resourceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",instruction.instId]];
	
	if(resourceImage)
	{
		return TRUE;
	}
	
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	BOOL aBool = [fm fileExistsAtPath:pngPath];
	return aBool;
}

- (void) setButtonCurrentStatus
{
	NSDate *today=[NSDate date];
	NSString *startDate;
	startDate=instruction.startDate;
	NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
	[dateFormatter1 setDateFormat:@"eee,MMM dd,yyyy"];                      
	NSDate *Date1 = [dateFormatter1 dateFromString:startDate];
	[dateFormatter1 release];
	
	int noDays = [self howManyDaysHavePast:today today:Date1];
	
	if(noDays<2 && !instruction.isExecuted)
	{
		UIImage *statusImage = [UIImage imageNamed:@"deselect.png"];
		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
		[dueStatusLbl setTextColor:[UIColor redColor]];
	}
	else if(!instruction.isExecuted)
	{
		UIImage *statusImage = [UIImage imageNamed:@"normal.png"];
		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
		[dueStatusLbl setTextColor:[UIColor grayColor]];
	}
	else {
		UIImage *statusImage = [UIImage imageNamed:@"select.png"];
		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
		[dueStatusLbl setTextColor:[UIColor grayColor]];
	}
	
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
	[instruction retain];
	
	[self.instructionNameLbl setText:instruction.title];
	
	NSString *localStartDate;
	localStartDate=instruction.startDate;
	NSDateFormatter *localDateFormatter = [[NSDateFormatter alloc] init];
	[localDateFormatter setDateFormat:@"EEEE,MMMM dd,yyyy"];                      
	NSDate *localDate = [localDateFormatter dateFromString:localStartDate];
	

	NSString *localDateString = [localDateFormatter stringFromDate:localDate];
	NSString *newFormattedString = nil;
	if(localDateString)
	{
		NSArray *localDateArray = [localDateString componentsSeparatedByString:@","];
		newFormattedString = [[NSString alloc] initWithFormat:@"%@, %@", [localDateArray objectAtIndex:0], [localDateArray objectAtIndex:1]];
	}
								   
	[self.dueStatusLbl setText:[NSString stringWithFormat:@"%@", newFormattedString]];
	
	[localDateFormatter release];
	[newFormattedString release];
	
	if(![self isInstructionImageExistInCache])
	{
		if(!isDownloading)
		{
			NSArray *array = [localInstruction.instructionImage componentsSeparatedByString:@".png"];
			
			NSString *newPath = [NSString stringWithFormat:@"%@_small.png",[array objectAtIndex:0]];
			
			NSLog(@"New Path == %@", newPath);
			
			NSURL *url = [[NSURL alloc] initWithString:newPath];
			
			NSLog(@"url == %@", url);
			
			imgDownloader = [[[ImageDownloader alloc] initWithRequest:url] autorelease];
			imgDownloader.delegate = self;
			[imgDownloader startDownload];
			[url release];
			isDownloading = YES;				 
		}
	}
	if(![self isActualInstructionImageExistInCache])
	{
		if(!isActualImageDownloading)
		{
			[self actualImageDownload];
		}
		
	}
	[self setButtonCurrentStatus];
	
//	NSDate *today=[NSDate date];
//	NSString *startDate;
//	startDate=instruction.startDate;
//	NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//	[dateFormatter1 setDateFormat:@"eee,MMM dd,yyyy"];                      
//	NSDate *Date1 = [dateFormatter1 dateFromString:startDate];
//	[dateFormatter1 release];
//	
//	int noDays = [self howManyDaysHavePast:today today:Date1];
//
//	if(noDays<2 && !instruction.isExecuted)
//	{
//		UIImage *statusImage = [UIImage imageNamed:@"deselect.png"];
//		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
//		[dueStatusLbl setTextColor:[UIColor redColor]];
//	}
//	else if(!instruction.isExecuted)
//	{
//		UIImage *statusImage = [UIImage imageNamed:@"normal.png"];
//		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
//		[dueStatusLbl setTextColor:[UIColor grayColor]];
//	}
//	else {
//		UIImage *statusImage = [UIImage imageNamed:@"select.png"];
//		[statusDoneButton setImage:statusImage forState:UIControlStateNormal];
//		[dueStatusLbl setTextColor:[UIColor grayColor]];
//	}
}

- (void) stopActivityIndicator
{
	[activityIndicator stopAnimating];
}

- (BOOL) isInstructionImageExistInCache
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	//Demo hack
	UIImage *resourceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_thumnail.png",instruction.instId]];
	
	if(resourceImage)
	{
		[instructionImageView setImage:resourceImage];
		[self stopActivityIndicator];
		return TRUE;
	}
	
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@_thumnail.png",instruction.instId];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	BOOL aBool = [fm fileExistsAtPath:pngPath];
	if(aBool)
	{
		UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngPath];
		//instructionImageView.frame = CGRectMake(46, 4, 49, 49);

		[instructionImageView setImage:img];
		[img release];
		[self stopActivityIndicator];
	}
	return aBool;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state.
}


- (void)dealloc 
{
	NSLog(@"InstructionsCutomCell ------------- Release");
	if(HTTPServicePOSTHandlerObj)
	{
		HTTPServicePOSTHandlerObj.delegate = nil;
		[HTTPServicePOSTHandlerObj release];
	}
	[instruction release];
	[instructionNameLbl release];
	[dueStatusLbl release];
	[instructionImageView release];
	[activityIndicator release];
	[instructionBorderImageView release];
    [super dealloc];
}


#pragma mark -
#pragma mark  Save image in cache
#pragma mark -
- (void) saveFileInResourcesFolder:(UIImage *)image
{
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@_thumnail.png",instruction.instId];
	
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
	
	//NSDictionary *dict =[fileMgr attributesOfItemAtPath:pngPath error:nil];
	//NSLog(@"%@",dict);
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

		[instructionImageView setImage:image];
	}
	
}

- (void)downloadDidFinishWithError:(NSError *)error
{
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];

	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];	
	
}




#pragma mark -
#pragma mark 
#pragma mark -
-(void) httpPOSTServiceFinish : (NSDictionary *)dict
{
	NSLog(@"POST ====== %@",dict);
}
-(void) httpPOSTServiceFinishWithError : (NSError *)error
{
	NSLog(@"POST ====== %@",[error description]);
}
@end
