//
//  ScreenCaptureView.m
//  ScreenCapture
//
//  Created by Ayush Goel on 04/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScreenCaptureView.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreMedia/CMTime.h>
 #import <CoreVideo/CVPixelBuffer.h>





@interface ScreenCaptureView(Private)
- (void) writeVideoFrameAtTime:(CMTime)time;
@end

@implementation ScreenCaptureView

@synthesize currentScreen, frameRate, delegate;

- (void) initialize {
    self.clearsContextBeforeDrawing = YES;
    self.currentScreen = nil;
    self.frameRate = 10.0f;    
    _recording=FALSE;
    videoWriter = nil;
    videoWriterInput = nil;
    avAdaptor = nil;
    startedAt = nil;
    bitmapData = NULL;
    [self drawRect:CGRectMake(0,0,320,480)];
}


- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id) init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (CGContextRef) createBitmapContextOfSize:(CGSize) size {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (size.width * 4);
    bitmapByteCount     = (bitmapBytesPerRow * size.height);
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (bitmapData != NULL) {
        free(bitmapData);
    }
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     size.width,
                                     size.height,
                                     8,    
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaNoneSkipFirst);
    
    CGContextSetAllowsAntialiasing(context,NO);
    if (context== NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
}


- (void) drawRect:(CGRect)rect {
    NSDate* start = [NSDate date];
    CGContextRef context = [self createBitmapContextOfSize:self.frame.size];
    
 
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipVertical);
    
    [self.layer renderInContext:context];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage* background = [UIImage imageWithCGImage: cgImage];
    CGImageRelease(cgImage);
    
    self.currentScreen = background;
    

  
    if (_recording) {
        float millisElapsed = [[NSDate date] timeIntervalSinceDate:startedAt] * 1000.0;
       
       [self writeVideoFrameAtTime:CMTimeMake((int)millisElapsed, 1000)];
    }
    
    float processingSeconds = [[NSDate date] timeIntervalSinceDate:start];
    float delayRemaining = (1.0 / self.frameRate) - processingSeconds;
    
    CGContextRelease(context);
    
    
    [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:delayRemaining > 0.0 ? delayRemaining : 0.01];
}
-(void) setNeedsDisplay
{
   
    [self startRecording];
  //  [self stopRecording];
     //write in scroll end
    
}

- (void) cleanupWriter {
    [avAdaptor release];
    avAdaptor = nil;
    
    [videoWriterInput release];
    videoWriterInput = nil;
    
    [videoWriter release];
    videoWriter = nil;
    
    [startedAt release];
    startedAt = nil;
    
    if (bitmapData != NULL) {
        free(bitmapData);
        bitmapData = NULL;
    }
}

- (void)dealloc {
    [self cleanupWriter];
    [super dealloc];
}

- (NSURL*) tempFileURL {
  // NSString* outputPath = [[NSString alloc] initWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"output.mp4"];
    
    ///Users/Ayush/Desktop/ayush/output.mp4
    NSString* outputPath=@"Users/Ayush/Desktop/ayush/output.mp4";
    NSLog(@"path ==%@",outputPath);
    NSURL* outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:outputPath]) {
        NSLog(@"it here");
        NSError* error;
        if ([fileManager removeItemAtPath:outputPath error:&error] == NO) {
            NSLog(@"Could not delete old recording file at path:  %@", outputPath);
        }
    }
    
   // [outputPath release];
    return [outputURL autorelease];
}

-(BOOL) setUpWriter {
    NSError* error = nil;
    videoWriter = [[AVAssetWriter alloc] initWithURL:[self tempFileURL] fileType:AVFileTypeQuickTimeMovie error:&error];
    NSParameterAssert(videoWriter);
   
    //Configure video
    NSDictionary* videoCompressionProps = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithDouble:1024.0*1024.0], AVVideoAverageBitRateKey,
                                           nil ];
    
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:self.frame.size.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:self.frame.size.height], AVVideoHeightKey,
                                   videoCompressionProps, AVVideoCompressionPropertiesKey,
                                   nil];
    
    videoWriterInput = [[AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings] retain];
   
    NSParameterAssert(videoWriterInput);
    videoWriterInput.expectsMediaDataInRealTime = YES;

    NSDictionary* bufferAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    

    

    
    avAdaptor = [[AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput sourcePixelBufferAttributes:bufferAttributes] retain];
    
    
    [videoWriter addInput:videoWriterInput];
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:CMTimeMake(0, 1000)];
    
    return YES;
}

- (void) completeRecordingSession {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    [videoWriterInput markAsFinished];
    
    // Wait for the video
    int status = videoWriter.status;
    while (status == AVAssetWriterStatusUnknown) {
        NSLog(@"Waiting...");
        [NSThread sleepForTimeInterval:0.5f];
        status = videoWriter.status;
    }
    
    @synchronized(self) {
        BOOL success = [videoWriter finishWriting];
        if (!success) {
            NSLog(@"finishWriting returned NO");
        }
        
        [self cleanupWriter];
        
        id delegateObj = self.delegate;
        //NSString *outputPath = [[NSString alloc] initWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"output.mp4"];
   
        
     NSString* outputPath=@"Users/Ayush/Desktop/ayush/output.mp4";
        NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
        NSLog(@"output =%@",outputURL);
        NSLog(@"Completed recording, file is stored at:  %@", outputURL);
        if ([delegateObj respondsToSelector:@selector(recordingFinished:)]) {
            [delegateObj performSelectorOnMainThread:@selector(recordingFinished:) withObject:(success ? outputURL : nil) waitUntilDone:YES];
        }
        
        [outputPath release];
        [outputURL release];
    }
    
    [pool drain];
}

- (bool) startRecording {
  
    bool result = NO;
    
    @synchronized(self) {
         
        if (! _recording) {
           
            result = [self setUpWriter];
            startedAt = [[NSDate date] retain];
            _recording = true;
        }
    }
    
    return result;
}

- (void) stopRecording {
    @synchronized(self) {
        if (_recording) {
            _recording = false;
            [self completeRecordingSession];
        }
    }
}

-(void) writeVideoFrameAtTime:(CMTime)time {
    if (![videoWriterInput isReadyForMoreMediaData]) {
        NSLog(@"Not ready for video data");
    }
    else {
        @synchronized (self) {
            UIImage* newFrame = [self.currentScreen retain];
            CVPixelBufferRef pixelBuffer = NULL;
            CGImageRef cgImage = CGImageCreateCopy([newFrame CGImage]);
            CFDataRef image = CGDataProviderCopyData(CGImageGetDataProvider(cgImage));
            
            int status= CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, avAdaptor.pixelBufferPool, &pixelBuffer);
           
            if(status != 0){
           
                NSLog(@"Error creating pixel buffer:  status=%d", status);
            }
            
           CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
            uint8_t* destPixels = CVPixelBufferGetBaseAddress(pixelBuffer);
            CFDataGetBytes(image, CFRangeMake(0, CFDataGetLength(image)), destPixels);  //XXX:  will work if the pixel buffer is contiguous and has the 
            
            if(status == 0){
                BOOL success = [avAdaptor appendPixelBuffer:pixelBuffer withPresentationTime:time];
                if (!success)
                    NSLog(@"Warning:  Unable to write buffer to video");
            }
            
        
            [newFrame release];
           CVPixelBufferUnlockBaseAddress( pixelBuffer, 0 );
            CVPixelBufferRelease( pixelBuffer );
            CFRelease(image);
            CGImageRelease(cgImage);
        }
        
    }
    
}

@end