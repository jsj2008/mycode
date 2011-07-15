//
//  CommentMessageStream.h
//  iShopShape
//
//  Created by Santosh B on 29/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServicePOSTHandler.h"
#import "CustomTextView.h"
@interface CommentMessageStream : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate, HTTPServicePOSTHandlerDelegate, UITextViewDelegate> {
	CustomTextView *commentTextView;
	IBOutlet UIImageView *imageView;
	UIImage *imageSnap;
	NSString *guid;
	NSString *instructionTitle;
	UIActivityIndicatorView *activityIndicator;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image guid: (NSString *)aGuid title:(NSString*)aTitle;

/**
 *	@functionName	: cameraButtonAction
 *	@parameters		: (id)sender
 *	@return			: (IBAction)
 *	@description	: set action for the camera button 
 */
- (IBAction) cameraButtonAction :(id)sender;

/**
 *	@functionName	: sendButtonAction
 *	@parameters		: (id)sender
 *	@return			: (IBAction)
 *	@description	: set action for the send button button 
 */
- (IBAction) sendButtonAction :(id)sender;

/**
 *	@functionName	: generateImageName
 *	@parameters		: 
 *	@return			: (NSString *)
 *	@description	: generate the image name
 */
- (NSString *)generateImageName ;

/**
 *	@functionName	: addMessageStream
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: add to message stream
 */
- (void) addMessageStream;

/**
 *	@functionName	: saveFileInResourcesFolder
 *	@parameters		: UIImage *)image
 *					: (NSString *)imageName
 *	@return			: (void)
 *	@description	: Save file in resources folder
 */
- (void) saveFileInResourcesFolder:(UIImage *)image imageName : (NSString *)imageName;

@end
