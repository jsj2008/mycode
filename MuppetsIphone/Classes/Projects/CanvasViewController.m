//
//  CanvasViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "CanvasViewController.h"
#import "CanvasUploader.h"
#import <MessageUI/MessageUI.h>
#import "CanvasObjectMuppet.h"
#import "CanvasObjectBackground.h"

@interface CanvasViewController()

//- (void)renderAudio;
//- (void)renderVideo;

- (void)showEmailShare;
- (void)showFacebookShare;

@end

@implementation CanvasViewController
@synthesize canvas;
@synthesize sharePath;
@synthesize newView;


- (void)loadProject:(Project *)project {
    currentProject = [project retain];
    for (CanvasObject *obj in [currentProject objects]) {
       [canvas addSubview:obj];
       
        [obj setupAfterCanvas];
    }
}
- (void)loadImage:(UIImage *)myImage
{
    newView=[[UIImageView alloc]initWithFrame:CGRectMake(-7,-6, canvas.bounds.size.width+13, canvas.bounds.size.height+12)];

    newView.image=myImage;
    [canvas addSubview:newView];
    
}
- (BOOL)saveProject{
    if (!currentProject) return NO;
    [currentProject saveCanvas:canvas];
    return YES;
}
///check here change the canvas AYUSH 
- (BOOL)renderProject {
    if (!currentProject) return NO;
    UIImage *_capture = [canvas captureImage];
    [currentProject setPreviews:_capture];
    [self render];
    [_capture release];
    return YES;
}
 

- (id)init{
    self = [super initWithNibName:@"CanvasView" bundle:nil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [sharePath release];
    //[canvas release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSString *)videoPath{
    return [currentProject pathForResource:@"video.mp4"];
}

- (NSString *)thumbnailPath{
    return [currentProject pathForResource:@"thumbnail.png"];
}

- (NSString *)previewPath{
    return [currentProject pathForResource:@"preview.png"];
}

//- (void)saveToPictures{
//    UIImage *_capture = [canvas captureImage];
//    [currentProject setPreviews:_capture];
//    UIImageWriteToSavedPhotosAlbum(_capture, nil, nil, nil);  
//}


- (NSString *)pathForResourceType:(NSString *)resourceType{
    NSString *_path = nil;
    if ([resourceType isEqualToString:@"thumbnail"]) {
        _path = [self thumbnailPath];
    } else if ([resourceType isEqualToString:@"preview"]) {
        _path = [self previewPath];
    } else if ([resourceType isEqualToString:@"video"]) {
        _path = [self videoPath];
    } 
    return  _path;
}



- (void)render{
    [self showHudWithLabel:@"Rendering Video.."];
    //[self renderAudio];
    //[self renderVideo];
}



- (void)showShareOptions{
    UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle: @"Share Via"
                                                              delegate: self
                                                     cancelButtonTitle: @"Cancel"
                                                destructiveButtonTitle: nil 
                                                     otherButtonTitles: @"Facebook", @"Email", @"Preview on Web", nil] autorelease];
    [actionSheet showInView:self.view];
}

- (void)setSharePath:(NSString *)path{
    sharePath = path;
    [self hideHud];
    [self showShareOptions];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self showFacebookShare];
    } else if (buttonIndex == 1) {
        [self showEmailShare];
    } else if (buttonIndex == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sharePath]];
        [self performSelector:@selector(showShareOptions) withObject:nil afterDelay:1.0f];
    }
}

- (void)showEmailShare{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	[controller setSubject:@"I am a Muppet!!"];
	[controller setMessageBody:[NSString stringWithFormat:@"Click here to see: %@", sharePath] isHTML:NO];
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)showFacebookShare{
    [[[MuppetAccount shared] facebook] dialog:@"feed" 
                                      andParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:[sharePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"link", nil] 
                                    andDelegate:nil];
}

@end
