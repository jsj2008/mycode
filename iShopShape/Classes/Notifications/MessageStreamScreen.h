//
//  MessageStreamScreen.h
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification.h"
#import "HTTPServicePOSTHandler.h"
#import "HPGrowingTextView.h"

@interface MessageStreamScreen : UIViewController <HPGrowingTextViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, HTTPServicePOSTHandlerDelegate>
{
	IBOutlet UITableView *messageTbl;
	
	HPGrowingTextView *textField;
	UIView *controlContanierView;
	UIImageView *bgImageView ;
	HTTPServicePOSTHandler *HTTPServicePOSTHandlerObj;
	
	NSString *messageGuid;
}

@property (nonatomic, retain) UITableView *messageTbl;
@property (nonatomic, retain) HPGrowingTextView *textField;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) NSMutableArray *messagearray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil guid:(NSString *)aGuid;

/**
 *	@functionName	: launchCameraButtonAction
 *	@parameters		: (id)sender
 *	@return			: (IBAction)
 *	@description	: launch Camera Button Action
 */
- (IBAction)launchCameraButtonAction : (id)sender;

/**
 *	@functionName	: addMessageStream
 *	@parameters		:
 *	@return			: (void)
 *	@description	: add new Message to the main message Stream
 */
- (void) addMessageStream;

/**
 *	@functionName	: addCustomTextField
 *	@parameters		:
 *	@return			: (void)
 *	@description	: add custom text field 
 */
- (void) addCustomTextField;

/**
 *	@functionName	: generateImageName
 *	@parameters		:
 *	@return			: (NSString *)
 *	@description	: generate image name 
 */
- (NSString *)generateImageName ;

/**
 *	@functionName	: saveFileInResourcesFolder
 *	@parameters		: (UIImage *)image
 *					: (NSString *)imageName
 *	@return			: (void)
 *	@description	: save file in resources folder
 */
- (void) saveFileInResourcesFolder:(UIImage *)image imageName : (NSString *)imageName;

@end
