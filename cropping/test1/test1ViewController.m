//
//  test1ViewController.m
//  test1
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "test1ViewController.h"
#import "CustomImageView.h"
@class AVCaptureSession;
@class AVCaptureStillImageOutput;
@class AVCaptureVideoPreviewLayer;
@class AVCaptureDevice;
@class AVCaptureDeviceInput;
@class AVCaptureVideoDataOutput; 
@class AVMediaTypeVideo;

@implementation test1ViewController
@synthesize myView;
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    NSError *error = nil;
    
    // Setup the video input
   /* AVCaptureDevice *videoDevice =[AVCaptureDevice defaultDeviceWithMediaType
                                   
                                   
                                   ];
    // Create a device input with the device and add it to the session.
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    // Setup the video output
    _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    _videoOutput.alwaysDiscardsLateVideoFrames = NO;
    _videoOutput.videoSettings =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];     
    
    // Setup the audio input
    AVCaptureDevice *audioDevice     = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeAudio];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error ];     
    // Setup the audio output
    _audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    
    // Create the session
    _capSession = [[AVCaptureSession alloc] init];
    [_capSession addInput:videoInput];
    [_capSession addInput:audioInput];
    [_capSession addOutput:_videoOutput];
    [_capSession addOutput:_audioOutput];
    
    _capSession.sessionPreset = AVCaptureSessionPresetLow;     
    
    // Setup the queue
    dispatch_queue_t queue = dispatch_queue_create("MyQueue", NULL);
    [_videoOutput setSampleBufferDelegate:self queue:queue];
    [_audioOutput setSampleBufferDelegate:self queue:queue];
    dispatch_release(queue);    
    NSLog(@"hiii");*/
    myView=[[CustomImageView alloc]initWithFrame:CGRectMake(50, 50,200, 200)];
    myView.image=[UIImage imageNamed:@"try.jpeg"];
    [myView setUserInteractionEnabled:YES];
    [self.view addSubview:myView];
    [myView release];
    
  
    
    [super viewDidLoad];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
