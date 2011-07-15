//
//  InstructionDetailsScreen.m
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "InstructionDetailsScreen.h"
#import "InstructionImageCustomCell.h"
#import "StyleCustomCell.h"
#import "PlacementsScreen.h"
#import "CommentMessageStream.h"
#import "MessageStreamScreen.h"

#import "DurationDetailsCell.h"
#import "MessageStreamCellInst.h"
#import "CommentCustomCell.h"

@implementation InstructionDetailsScreen

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instruction: (Instruction*) aInstruction{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		instruction = aInstruction;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self setTitle:instruction.title];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackground.png"]]];
	[instructionDetailsTable setBackgroundColor:[UIColor clearColor]];
	
    [super viewDidLoad];
}

//- (void) viewWillDisappear:(BOOL)animated
//{
//	if(selectedRow)
//	{
//		[instructionDetailsTable deselectRowAtIndexPath:selectedRow animated:YES];
//	}
//}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"InstructionDetailsScreen -------------------- Release");
    [super dealloc];
}

- (void) saveFileInResourcesFolder:(UIImage *)image
{
	// Create paths to output images
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
		
	// Write image to PNG
	[UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
	
	// Let's check to see if files were successfully written...
	
	// Create file manager
	NSError *error;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	
	// Point to Document directory
	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	// Write out the contents of home directory to console
	NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
	
}

#pragma mark -
#pragma mark MessageStreamScreen
#pragma mark -

- (void) launchCommentMessageStreamScreen :(UIImage *)image
{
	
//	CommentMessageStream *commentMessageStream = [[CommentMessageStream alloc] initWithNibName:@"CommentMessageStream" bundle:[NSBundle mainBundle] image:image guid:instruction.instId title:instruction.title];
//	
//	BOOL aBool = image ? NO : YES;
//	
//	[self.navigationController pushViewController:commentMessageStream animated:aBool];
//	[commentMessageStream release];
	
	//CalendarEvent * calendarEventDetails = [calanderEventDetailsArray objectAtIndex:tagid];
	//CalendarTouchEvent *eventDetailsScreen = [[CalendarTouchEvent alloc] initWithNibName:@"CalendarTouchEvent" bundle:[NSBundle mainBundle] details:calendarEventDetails];
	
	CommentMessageStream *commentMessageStream = [[CommentMessageStream alloc] initWithNibName:@"CommentMessageStream" bundle:[NSBundle mainBundle] image:image guid:instruction.instId title:instruction.title];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:commentMessageStream];
	[self presentModalViewController:navController animated:YES];
	[navController release];
	[commentMessageStream release];
	
}

- (void)launchMessageStreamScreen
{
	MessageStreamScreen *messageStreamScreen = [[MessageStreamScreen alloc] initWithNibName:@"MessageStreamScreen" bundle:[NSBundle mainBundle] guid:instruction.instId];
	[self.navigationController pushViewController:messageStreamScreen animated:YES];
	[messageStreamScreen release];
}

#pragma mark -
#pragma mark Camera loading
- (IBAction) cameraButtonAction : (id)sender
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

		// Set source to the camera
		[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
		
		// Delegate is self
		[imagePicker setDelegate:self];
		
		// Allow editing of image ?
		[imagePicker setAllowsImageEditing:NO];
		
		// Show image picker
		[self presentModalViewController:imagePicker animated:YES];	
	}
	else 
	{
		NSLog(@"No Camera support available");
	}

}

#pragma mark -
#pragma mark CAMERA DELEGATE
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	UIAlertView *alert;
	
	// Unable to save the image  
	if (error)
	{
		alert = [[UIAlertView alloc] initWithTitle:@"Error" 
										   message:@"Unable to save image to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	}
	else // All is well
	{
		alert = [[UIAlertView alloc] initWithTitle:@"Success" 
										   message:@"Image saved to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	
	}
	[alert show];
	[alert release];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	
	CGSize newSize = CGSizeMake(320,480);
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
	UIGraphicsEndImageContext();
	
	[self saveFileInResourcesFolder:newImage];
	
	[self launchCommentMessageStreamScreen : newImage];
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];

}		



#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section ==0)
		return 18.0f;
	return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section==0)
		return @" ";
	if(section==1)
	{
		if([instruction.styleProductArray count] > 1)
			return [NSString stringWithFormat:@"%d Products",[instruction.styleProductArray count]];
		else {
			return [NSString stringWithFormat:@"%d Product",[instruction.styleProductArray count]];
		}

	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section) 
	{
		case 0:
			switch (indexPath.row) {
				case 0:
				{
					UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",instruction.instId]];
					if(!image)
					{
						NSFileManager *fm = [NSFileManager defaultManager];
						
							NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instruction.instId];
							
							NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
							BOOL aBool = [fm fileExistsAtPath:pngPath];
							if(aBool)
							image = [[[UIImage alloc] initWithContentsOfFile:pngPath] autorelease];
					}
					if(image)
					{
						float maxZoomLevel = image.size.width / 280;
						//NSLog(@"image Height == %f", image.size.height/maxZoomLevel);
						if(image.size.height/maxZoomLevel < 190)
						{
							return image.size.height/maxZoomLevel + 12;
						}
						else if(image.size.height/maxZoomLevel < 212)
						{
							return image.size.height/maxZoomLevel + 15;
						}
						else if(image.size.height/maxZoomLevel > 370)
						{
							return image.size.height/maxZoomLevel + 25;
						}
						
						return image.size.height/maxZoomLevel + 20;
					}


					return 220.0f;
				}
				case 1:
					return 40.0f;
					break;
			}
			
		case 1:
			return 112.0f;
		case 2:
			switch (indexPath.row) {
				case 0:
					return 90.0f;
				case 1:
					{
						CGSize size = [instruction.description  sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(280,400) lineBreakMode:UILineBreakModeWordWrap];
						//NSLog(@"addressHeight == %d", size.height);
						return size.height + 40;
					}
				case 2:
					return 44.0f;
			}
	}
	return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	int rows = 0;
	switch (section) {
		case 0:
			rows = 2;
			break;
		case 1:
			rows = [instruction.styleProductArray count];
			break;
		case 2:
			rows = 3;
			break;
	}
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	static NSString *identifier =@"DETAILED_CELL";
	static NSString *styleidentifier =@"STYLE_CELL";
	static NSString *durationidentifier = @"DURATION_CELL";	
	static NSString *commentidentifier = @"COMMENT_CELL";	
	static NSString *messageidentifier = @"MESSAGE_CELL";
	
	
	Product *product = nil;
	if(indexPath.section == 1 && indexPath.row < [instruction.styleProductArray count])
	{
		product = [instruction.styleProductArray objectAtIndex:indexPath.row];
	}
	
	if(indexPath.section == 0 && indexPath.row == 0)
	{
		InstructionImageCustomCell *cell = (InstructionImageCustomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
		
		if(nil == cell)
		{
			cell =[[[InstructionImageCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
		}
		[cell setCellData:instruction];
			
		return cell;
	}
	if(indexPath.section == 0 && indexPath.row == 1)
	{
		InstructionMessageStreamCell *cell = (InstructionMessageStreamCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
		
		if(nil == cell)
		{
			cell =[[[InstructionMessageStreamCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
		}
		[cell setDelegate:self];
		return cell;
	}
	else if(indexPath.section == 1)
	{
		StyleCustomCell *cell = (StyleCustomCell*)[tableView dequeueReusableCellWithIdentifier:styleidentifier];
		
		if(nil == cell)
		{
			cell =[[[StyleCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:styleidentifier] autorelease];
		}
		
		[cell setCellData:product];
		
		return cell;
	}
	else if(indexPath.section == 2)
	{
		if(indexPath.row < 2)
		{
			if(indexPath.row == 0)
			{
				DurationDetailsCell *cell = (DurationDetailsCell*)[tableView dequeueReusableCellWithIdentifier:durationidentifier];
				
				if(nil == cell)
				{
					cell =[[[DurationDetailsCell alloc] initWithFrame:CGRectZero reuseIdentifier:durationidentifier] autorelease];
					[cell setDurationData:[NSString stringWithFormat:@"Start: %@", instruction.startDate] endDate:[NSString stringWithFormat:@"End: %@", instruction.endDate]];
				}
				return cell;
			}
			else 
			{
				CommentCustomCell *cell = (CommentCustomCell*)[tableView dequeueReusableCellWithIdentifier:commentidentifier];
				if(nil == cell)
				{
					cell =[[[CommentCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:durationidentifier] autorelease];
					[cell setCommentsData:instruction.description];
				}
				
				return cell;
			}
		
		}
		else 
		{
			MessageStreamCellInst *cell = (MessageStreamCellInst*)[tableView dequeueReusableCellWithIdentifier:messageidentifier];
			
			if(nil == cell)
			{
				cell =[[[MessageStreamCellInst alloc] initWithFrame:CGRectZero reuseIdentifier:messageidentifier] autorelease];
			}
			return cell;
		}
	
	}
	return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	switch (indexPath.section) 
	{
		case 0:
		switch (indexPath.row) 
		{
			case 0:
			{
				PlacementsScreen *placementsScreen = [[PlacementsScreen alloc] initWithNibName:@"PlacementsScreen" bundle:[NSBundle mainBundle] instruction:instruction];
				[self.navigationController pushViewController:placementsScreen animated:YES];
				[placementsScreen release];
			}
			break;
			case 1:
			{
				[self launchCommentMessageStreamScreen:nil];
			}
			break;
		}
		case 2:
			if(indexPath.row == 2)
			{
				[self launchMessageStreamScreen];
			}
	}

}

#pragma mark -
#pragma mark InstructionImageCustomCellDelegate
#pragma mark -
-(void) cameraButtonActionDelegate
{
	[self cameraButtonAction:nil];
}


@end
