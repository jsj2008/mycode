//
//  MessageStreamScreen.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "MessageStreamScreen.h"
#import "CustomMessageCell.h"
#import "DatabaseHandler.h"
#import "Instruction.h"
#import "ThumbnailCreater.h"
#import <QuartzCore/CALayer.h>

#define BG_COLOR [UIColor colorWithRed:219.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1.0]
@implementation MessageStreamScreen
@synthesize messageTbl, textField, toolbar, messagearray;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil guid:(NSString *)aGuid {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		messageGuid = [[NSString alloc] initWithString:aGuid];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setTitle:@"Message stream"];
	
//	NSFileManager *fileMgr = [NSFileManager defaultManager];
	
	// Point to Document directory
//	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	// Write out the contents of home directory to console
//	NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil]);

//	Instruction *instruction = [[DatabaseHandler sharedInstance] readFromInstruction:messageGuid];
//	
//	if(instruction)
//	{
//		[self setTitle:instruction.title];
//	}
	
	messagearray = [[NSMutableArray alloc] init];
	NSArray *messagearray1 =[[DatabaseHandler sharedInstance] readFromMessageStream:messageGuid];
	[messagearray removeAllObjects];
	[messagearray addObjectsFromArray:messagearray1];

	
	controlContanierView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	[controlContanierView setBackgroundColor:[UIColor clearColor]];
	
	bgImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	UIColor *color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"messageCompose_background.png"]];
	[bgImageView setBackgroundColor:color];
	[controlContanierView addSubview:bgImageView];
	[bgImageView release];
	[color release];
	
	UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[cameraButton setFrame:CGRectMake(-1, 4, 40, 40)];
	[cameraButton setImage:[UIImage imageNamed:@"camera_up.png"] forState:UIControlStateNormal];
	[cameraButton setImage:[UIImage imageNamed:@"camera_down.png"] forState:UIControlStateSelected];
	[cameraButton addTarget:self action:@selector(launchCameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	[controlContanierView addSubview:cameraButton];
	
	
	UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendButton setFrame:CGRectMake(258, 10, 57, 27)];
	[sendButton setImage:[UIImage imageNamed:@"sendbutton_up.png"] forState:UIControlStateNormal];
	[sendButton setImage:[UIImage imageNamed:@"sendbutton_down.png"] forState:UIControlStateSelected];
	[sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	[controlContanierView addSubview:sendButton];

	[self addCustomTextField];
	[self.view addSubview:controlContanierView];
		
	CGRect r = controlContanierView.frame;
	r.origin.y = self.view.frame.size.height - r.size.height;
	controlContanierView.frame = r;	
	
	self.view.backgroundColor = BG_COLOR;
	messageTbl.backgroundColor = BG_COLOR;
	[super viewDidLoad];
}

- (void) addCustomTextField
{
	textField = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(40, 10, 210, 27)];
	textField.minNumberOfLines = 1;
	textField.maxNumberOfLines = 4;
	
	//CGRect aFrame = 
	textField.returnKeyType = UIReturnKeyGo; //just as an example
	//textView.font = [UIFont systemFontOfSize:11.0f];
	textField.font = [UIFont fontWithName:@"Helvetica" size:13]; 
	textField.delegate = self;
	
	[textField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
	[textField.layer setBorderColor: [[UIColor grayColor] CGColor]];
	/***/
	textField.layer.shadowColor = [UIColor blackColor].CGColor;
	textField.layer.shadowOffset = CGSizeMake(0, 1);
	textField.layer.shadowOpacity = 3;
	textField.layer.shadowRadius = 3.0;
	/***/
	
	[textField.layer setBorderWidth: 1.4];
	[textField.layer setCornerRadius:13.0f];
	[textField.layer setMasksToBounds:YES];
	[textField setClipsToBounds:YES];
	[controlContanierView addSubview:textField];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil]; 
}


- (NSString *)generateImageName 
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return [(NSString *)string autorelease];
}

- (void) saveFileInResourcesFolder:(UIImage *)image imageName : (NSString *)imageName
{
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@",imageName];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	
	//NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
	
	// Write a UIImage to JPEG with minimum compression (best quality)
	// The value 'image' must be a UIImage object
	// The value '1.0' represents image compression quality as value from 0.0 to 1.0
	//[UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
	
	// Write image to PNG
	[UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
	
	// Let's check to see if files were successfully written...
	
	// Create file manager
	NSError *error;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	
	// Point to Document directory
	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	// Write out the contents of home directory to console
	NSLog(@"saveFileInResourcesFolder Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
	
	//NSDictionary *dict =[fileMgr attributesOfItemAtPath:pngPath error:nil];
	//NSLog(@"%@",dict);
	
	
}

- (IBAction)launchCameraButtonAction : (id)sender
{
	NSLog(@"launchCamera");
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


/*
 * POST comments from store user to server
 */

- (void) postCommentForInstruction : (Notification*) message
{	
	[self.navigationItem.backBarButtonItem setEnabled:NO];
	
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
	
	HTTPServicePOSTHandlerObj = [[HTTPServicePOSTHandler alloc] autorelease];
	//HTTPServicePOSTHandlerObj.delegate = self;
	
	NSData *data = nil;
	
	if(image)
	{
		data = UIImagePNGRepresentation(image);
		[data retain];
		
	}
	[image release];
	[HTTPServicePOSTHandlerObj postCommentsWithImage:url notificaitonID:message.notificationId message:newString imageData:data];
	
	
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
	NSLog(@"%f %f", newImage.size.width, newImage.size.height);	
	//[newImage retain];
	
	NSString *imageName = [NSString stringWithFormat:@"%@.png",[self generateImageName]];

	[self saveFileInResourcesFolder:newImage imageName:imageName];
	
	if(newImage)
	{
		Notification *message=[[Notification alloc]init];
		message.notificationId= messageGuid;
		
		NSLog(@"Message Guid %@",message.notificationId);
		
		message.notificationTitle=textField.text;
		message.position=0;
		message.notificationImage = imageName;
		[messagearray addObject:message];
		
		[[DatabaseHandler sharedInstance] insertMessageStream:message];
		
		//upload to server
		[self postCommentForInstruction:message];
		
		[message release];
		
		NSArray *messageTemp =[[DatabaseHandler sharedInstance] readFromMessageStream:messageGuid];
		[messagearray removeAllObjects];
		[messagearray addObjectsFromArray:messageTemp];
		
		[messageTbl reloadData];
		
		NSUInteger index = [messagearray count] - 1;
		[messageTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		textField.text = @"";
	}
	
	//[newImage release];
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
}

- (IBAction) sendButtonAction : (id)sender
{
	[self addMessageStream];
	[textField resignFirstResponder];
}

- (void) addMessageStream
{
	if(![textField.text isEqualToString:@""] && textField.text)
	{
		Notification *message=[[Notification alloc]init];
		message.notificationId= messageGuid;
		
		NSLog(@"Message Guid %@",message.notificationId);
		
		message.notificationTitle=textField.text;
		message.position=0;
		
		message.notificationImage=@"";
		[messagearray addObject:message];
		
		[[DatabaseHandler sharedInstance] insertMessageStream:message];
		
		//upload to server
		[self postCommentForInstruction:message];
		
		[message release];
		
		NSArray *messageTemp =[[DatabaseHandler sharedInstance] readFromMessageStream:messageGuid];
		[messagearray removeAllObjects];
		[messagearray addObjectsFromArray:messageTemp];
		
		[messageTbl reloadData];
		
		NSUInteger index = [messagearray count] - 1;
		[messageTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		textField.text = @"";
		
	}

}


#pragma mark -
#pragma mark UITextFieldDelegate
#pragma mark -

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{	
	float diff = (textField.frame.size.height - height + 5);
	
	CGRect r = textField.frame;
	r.origin.y += diff;
	textField.frame = r;
	bgImageView.frame = CGRectMake(0, textField.frame.origin.y - 10, 320, textField.frame.size.height + 30);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {
	[textField1 resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];	
	controlContanierView.frame = CGRectMake(0, 372, 320, 44);
	messageTbl.frame = CGRectMake(0, 0, 320, 357);	
	[UIView commitAnimations];

	return YES;
}

- (void) keyboardWillHide:(NSNotification *)notif 
{
	[textField resignFirstResponder];
	[textField removeFromSuperview];
	[self addCustomTextField];
	bgImageView.frame = CGRectMake(0, 0, 320, 44);
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];	
	controlContanierView.frame = CGRectMake(0, 372, 320, 44);
	messageTbl.frame = CGRectMake(0, 0, 320, 357);	
	[UIView commitAnimations];
	
}

- (void)keyboardWillShow:(NSNotification *)notif {
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];	
	
	controlContanierView.frame = CGRectMake(0, 156, 320, 44);

	messageTbl.frame = CGRectMake(0, 0, 320, 156);	
	[UIView commitAnimations];
	
	if([messagearray count] > 0)
	{
		NSUInteger index = [messagearray count]-1;
		[messageTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	}
}
#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messagearray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *kCustomCellID = @"MyCellID";
	CustomMessageCell *cell = [[[CustomMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;	
	
	
	cell.message.frame = CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height);
	Notification *message=[messagearray objectAtIndex:indexPath.row];
	//messageGuid = message.notificationId;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	NSString *text=message.notificationTitle;
	NSString *image=message.notificationImage;
	NSLog(@"Notification Image = %@", message.notificationImage);
	NSLog(@"text == %@", text);
	
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *imagePath = [NSString stringWithFormat:@"%@/%@", documentsDirectoryPath, message.notificationImage];
	
	if(![fm fileExistsAtPath:imagePath])
	{
		image = @"";
	}
	if(![image isEqualToString:@""])
	{	
		image = [NSString stringWithFormat:@"%@/%@", documentsDirectoryPath, message.notificationImage];
		//NSFileManager *fm = [NSFileManager defaultManager];
		if([fm fileExistsAtPath:image])
		{
			NSLog(@"File Exist");
		}
	}
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(180.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
	UIImage *balloon;
	

	NSLog(@"Image %@", image);
	
	if(message.position== 0)
	{
		
		cell.balloonView.frame = CGRectMake(293.0f - (size.width + 8.0f), 10.0f, size.width + 28.0f, size.height + 15.0f);
		balloon = [[UIImage imageNamed:@"green_bubble.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		cell.label.frame = CGRectMake(303.0f - (size.width + 8.0f), 16.0f, size.width + 5.0f, size.height);
		
		if(![image isEqualToString:@""])
		{
			
			//cell.ImageView.image=  [UIImage imageWithContentsOfFile:image];//[UIImage imageNamed:image];
			UIImage *imageSnap = [UIImage imageWithContentsOfFile:image];
			UIImage *image = [ThumbnailCreater imageWithImage:imageSnap scaledToSize:CGSizeMake(100, 150) rect:CGRectMake(0, 20, 100, 100)];
			[cell.ImageView setImage:image];
			[cell.ImageView setFrame:CGRectMake(8.75,size.height +5,50.0f,50.0f)];
			[cell.ImageView.layer setCornerRadius:13.0f];
			[cell.ImageView.layer setMasksToBounds:YES];
			[cell.ImageView setClipsToBounds:YES];
			
			cell.balloonView.frame = CGRectMake(296.0f - (size.width + 60.0f) + 7, 2.0f, size.width + 70.0f, size.height + 65.0f);
			cell.label.frame = CGRectMake(300.0f - (size.width + 50.0f) + 7, 8.0f, size.width + 5.0f, size.height);
		}
	}
	else
	{
		cell.balloonView.frame = CGRectMake(0.0, 10.0, size.width + 28, size.height + 15);
		balloon = [[UIImage imageNamed:@"grey_bubble.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		cell.label.frame = CGRectMake(16, 16, size.width + 5, size.height);
		
		if(![image isEqualToString:@""])
		{
			NSLog(@"%@",image);
			cell.ImageView.image= [UIImage imageWithContentsOfFile:image];
			cell.ImageView.frame = CGRectMake(13,size.height +5,50,50);
			cell.balloonView.frame = CGRectMake(0.0f , 2.0f, size.width + 80, size.height + 65);
			
			
		}
	}
	cell.balloonView.image = balloon;
	cell.label.text = text;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	Notification *notificationMessage =[messagearray objectAtIndex:indexPath.row];
	NSString *body=notificationMessage.notificationTitle;
	CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0, 480.0) lineBreakMode:UILineBreakModeWordWrap];
	
//	NSFileManager *fm = [NSFileManager defaultManager];
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//	NSString *imagePath = [NSString stringWithFormat:@"%@/%@", documentsDirectoryPath, notificationMessage.notificationImage];
//	if(![fm fileExistsAtPath:imagePath])
//	{
//		return size.height + 40;
//	}
	if([notificationMessage.notificationImage isEqualToString:@""])
	{
		return size.height + 40;
	}
	else 
	{
		return size.height + 90;
	}
	
}

#pragma mark -
#pragma mark POST
#pragma mark -
-(void) httpPOSTServiceFinish : (NSDictionary *)dict
{
	[self.navigationItem.backBarButtonItem setEnabled:YES];
	NSLog(@"POST ====== %@",dict);
}
-(void) httpPOSTServiceFinishWithError : (NSError *)error
{
	[self.navigationItem.backBarButtonItem setEnabled:YES];
	NSLog(@"POST ====== %@",[error description]);
}

#pragma mark -

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	HTTPServicePOSTHandlerObj.delegate = nil;
	self.messageTbl = nil;
	self.textField = nil;
	self.toolbar = nil;
}


- (void)dealloc {
	NSLog(@"MessageStreamScreen -------------------- Release");
	//HTTPServicePOSTHandlerObj.delegate = nil;
	[messagearray release];
	[textField release];
	[messageGuid release];
	[controlContanierView release];
    [super dealloc];
}


@end
