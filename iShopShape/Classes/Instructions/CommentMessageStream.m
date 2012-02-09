//
//  CommentMessageStream.m
//  iShopShape
//
//  Created by Santosh B on 29/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "CommentMessageStream.h"
#import "Notification.h"
#import "DatabaseHandler.h"
#import "ThumbnailCreater.h"

@implementation CommentMessageStream

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image guid: (NSString *)aGuid title:(NSString*)aTitle
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		imageSnap = image;
		[imageSnap retain];
		instructionTitle = aTitle;
		guid = [[NSString alloc] initWithString:aGuid];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self setTitle:instructionTitle];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
									   initWithTitle:@"Cancel" 
									   style:UIBarButtonItemStyleBordered
									   target:self
									   action:@selector(cancelButtonAction:)
									   ];
	[[self navigationItem] setLeftBarButtonItem:cancelButton];
	[cancelButton release];

	[self.view setBackgroundColor:[UIColor grayColor]];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle-bg.png"]]];
	
	commentTextView = [[CustomTextView alloc] initWithFrame:CGRectMake(45, 22, 200, 70)];
	[commentTextView setFont:[UIFont systemFontOfSize:16]];
	[commentTextView setBackgroundColor:[UIColor redColor]];
	[commentTextView setDelegate:self];
	[self.view addSubview:commentTextView];
	
	if(imageSnap)
	{
		UIImage *image = [ThumbnailCreater imageWithImage:imageSnap scaledToSize:CGSizeMake(180, 270) rect:CGRectMake(0, 20, 180, 180)];
		[imageView setImage:image];
		[imageView setBackgroundColor:[UIColor redColor]];
		//[imageView setImage:imageSnap];
	}
	
	[commentTextView becomeFirstResponder];
	activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(130, 85, 30, 30)];
	[activityIndicator setBackgroundColor:[UIColor clearColor]];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[activityIndicator setHidesWhenStopped:YES];
	[activityIndicator setHidden:YES];
	[self.view addSubview:activityIndicator];
	
    [super viewDidLoad];
}

- (IBAction) cancelButtonAction :(id)sender
{
	//[self.navigationController popViewControllerAnimated:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) sendButtonAction :(id)sender
{
	[self.view setUserInteractionEnabled:NO];
	[self.navigationItem.leftBarButtonItem setEnabled:NO];;
	NSLog(@"SendButton Action ------------ %@", commentTextView.text);

	[activityIndicator setHidden:NO];
	[activityIndicator startAnimating];
	[self addMessageStream];
}

/*
 * POST comments from store user to server
 */

- (void) postCommentForInstruction : (Notification*) message
{
	NSString* newString = [message.notificationTitle stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSString* imageName = @"";
	UIImage *image = nil;
	
	if(![message.notificationImage isEqualToString:@""])
	{
		imageName = message.notificationImage;

		NSString *newPath = [NSString stringWithFormat:@"Documents/%@",imageName];
	
		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
		
		image = [[UIImage alloc] initWithContentsOfFile:pngPath];
	}
	
	NSString *str = [NSString stringWithFormat:@"%@", POST_COMMENT_URL];
	
	NSURL *url = [NSURL URLWithString:str];
	
	HTTPServicePOSTHandler *HTTPServicePOSTHandlerObj = [[HTTPServicePOSTHandler alloc] autorelease];
	HTTPServicePOSTHandlerObj.delegate = self;
	
	NSData *data = nil;
	
	if(image)
	{
		data = UIImagePNGRepresentation(image);
		[data retain];
	}
	
	[image release];
	
	[HTTPServicePOSTHandlerObj postCommentsWithImage:url notificaitonID:message.notificationId message:newString imageData:data];
	
}

- (void) addMessageStream
{
	NSString *imgName = nil;
	
	if(imageSnap)
	{
		imgName = [NSString stringWithFormat:@"%@.png",[self generateImageName]];
		[self saveFileInResourcesFolder:imageSnap imageName:imgName];
	}
	
	if(![commentTextView.text isEqualToString:@""] || imgName)
	{
		Notification *message=[[Notification alloc]init];
		message.notificationId= guid;
		
		NSLog(@"Message Guid %@",message.notificationId);
		
		message.notificationTitle=commentTextView.text;
		message.position=0;
		if(!imageSnap)
			message.notificationImage=@"";
		else {
			message.notificationImage=imgName;
		}

		[[DatabaseHandler sharedInstance] insertMessageStream:message];
		
		commentTextView.text = @"";
		
		[self postCommentForInstruction:message];
		//[message autorelease];
	}
	
}

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
	[guid release];
    [super dealloc];
}

-(IBAction) cameraButtonAction :(id)sender
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


- (NSString *)generateImageName 
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return [(__bridge NSString *)string autorelease];
}

- (void) saveFileInResourcesFolder:(UIImage *)image imageName : (NSString *)imageName
{
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@",imageName];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	
	// Write image to PNG
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
	//NSLog(@"%f %f", newImage.size.width, newImage.size.height);	
	
	//[self saveFileInResourcesFolder:newImage];
	
	if(newImage)
	{
		if(imageSnap)
		{
			[imageSnap release];
			imageSnap = nil;
		}
		imageSnap = [newImage retain];
		
		UIImage *image = [ThumbnailCreater imageWithImage:newImage scaledToSize:CGSizeMake(90, 135) rect:CGRectMake(0, 20, 90, 90)];
		//UIImage *image = [self imageWithImage:newImage scaledToSize:CGSizeMake(90, 135)];
		[imageView setImage:image];
		[imageView setBackgroundColor:[UIColor redColor]];
		//[imageView setImage:newImage];
	}
	// Save image
	//UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
	
}


- (void) enableUserInteraction
{
	[activityIndicator stopAnimating];
	[self.view setUserInteractionEnabled:YES];
	[self.navigationItem.leftBarButtonItem setEnabled:YES];
	[self.navigationItem.leftBarButtonItem setEnabled:YES];
	//[self.navigationController popViewControllerAnimated:YES];
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark textViewDelegate
#pragma mark -

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//	NSLog(@"%@", textView.text);
//}

#pragma mark -
#pragma mark HTTPServicePOSTHandlerDelegate
#pragma mark -

-(void) httpPOSTServiceFinish : (NSDictionary *)dict
{
	[self performSelectorOnMainThread:@selector(enableUserInteraction) withObject:nil waitUntilDone:YES];
	NSLog(@"COMMENT MESSAGE STREAM POST ====== %@",dict);
}

-(void) httpPOSTServiceFinishWithError : (NSError *)error
{
	[self performSelectorOnMainThread:@selector(enableUserInteraction) withObject:nil waitUntilDone:YES];
	NSLog(@"COMMENT MESSAGE STREAM POST ====== %@",[error description]);
}
@end
