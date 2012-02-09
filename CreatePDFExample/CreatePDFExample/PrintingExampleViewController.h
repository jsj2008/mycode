//
//  PrintingExampleViewController.h
//  PrintingExample
//
//  Created by Craig Spitzkoff on 6/9/11.
//  Copyright 2011 Raizlabs Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <QuickLook/QuickLook.h>
#import <QuartzCore/QuartzCore.h>


@interface PrintingExampleViewController : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, QLPreviewControllerDataSource>{
    
    NSString* pdfFilePath;
}

- (IBAction)pdfPressed:(id)sender;
- (IBAction)scaleIT:(id)sender;
- (UIView *)scaleView:(UIView *)viewScale;

@property (nonatomic, retain) NSString* pdfFilePath;
@property (nonatomic, retain) UIImage* testImage;
@property (nonatomic, retain) UIView* testView;

@end
