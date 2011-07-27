
//
//ScreenCaptureView.m
//
#import "ScreenCaptureView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


#import "MuppetAccount.h"

@interface ScreenCaptureView()
- (void) writeVideoFrameAtTime:(CMTime)time;
- (void) cleanupWriter;

@property (nonatomic, copy) ScreenCaptureResponseBlock responseBlock;
@property (nonatomic, copy) ScreenCaptureErrorBlock errorBlock;
@property (nonatomic, retain) NSString *audioFilePath;
@property (nonatomic, retain) NSString *videoFilePath;
@property (nonatomic, retain) NSString *tempVideoPath;
@property (nonatomic, assign) int captureDuration;

@end

@implementation ScreenCaptureView

@synthesize currentScreen, frameRate, delegate;
@synthesize responseBlock, errorBlock;
@synthesize audioFilePath, videoFilePath, tempVideoPath, captureDuration;

- (void) initialize {
    // Initialization code
    self.clearsContextBeforeDrawing = YES;
    self.currentScreen              = nil;
    self.frameRate                  = 20.0f;
    _recording                      = false;
    videoWriter                     = nil;
    videoWriterInput                = nil;
    avAdaptor                       = nil;
    startedAt                       = nil;
    bitmapData                      = NULL;
    
    
    NSArray *_paths                 = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *_documentsDirectory   = [_paths objectAtIndex:0]; 
    NSString *_path                 = [_documentsDirectory stringByAppendingPathComponent:@"recording.mov"]; 
    tempVideoPath                   = [_path retain];
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
    [responseBlock release];
    [errorBlock release];
    [audioFilePath release];
    [videoFilePath release];
    [self cleanupWriter];
    [tempVideoPath release];
    [super dealloc];
}

- (CGContextRef)createBitmapContextOfSize:(CGSize) size {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    // FIXME: 
    // bitmapBytesPerRow   = (size.width * 4);
    bitmapBytesPerRow   = ((size.width+1) * 4);
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
                                     8,      // bits per component
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
    if (_recording) {
        NSDate* start = [NSDate date];
        CGContextRef context = [self createBitmapContextOfSize:self.frame.size];
        
        //not sure why this is necessary...image renders upside-down and mirrored
        CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.frame.size.height);
        CGContextConcatCTM(context, flipVertical);
        
        [self.layer renderInContext:context];
        
        CGImageRef cgImage = CGBitmapContextCreateImage(context);
        UIImage* background = [UIImage imageWithCGImage: cgImage];
        CGImageRelease(cgImage);
        
        self.currentScreen = background;
        
        float millisElapsed = [[NSDate date] timeIntervalSinceDate:startedAt] * 1000.0;
        [self writeVideoFrameAtTime:CMTimeMake((int)millisElapsed, 1000)];
        
        float processingSeconds = [[NSDate date] timeIntervalSinceDate:start];
        float delayRemaining = (1.0 / self.frameRate) - processingSeconds;
        
        CGContextRelease(context);

        //redraw at the specified framerate
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:delayRemaining > 0.0 ? delayRemaining : 0.01];
    }
}


-(BOOL) setUpWriter {
    NSError* error = nil;
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:tempVideoPath]) {
        NSError* error;
        if ([fileManager removeItemAtPath:tempVideoPath error:&error] == NO) {
            DLog(@"Could not delete old recording file at path:  %@", tempVideoPath);
        }
    }
    
    videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:tempVideoPath isDirectory:NO] fileType:AVFileTypeQuickTimeMovie error:&error];
    
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
    NSDictionary* bufferAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    
    avAdaptor = [[AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput sourcePixelBufferAttributes:bufferAttributes] retain];
    
    //add input
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
        DLog(@"Waiting...");
        [NSThread sleepForTimeInterval:0.5f];
        status = videoWriter.status;
    }
    
    @synchronized(self) {
        BOOL success = [videoWriter finishWriting];
        if (!success) {
            DLog(@"finishWriting returned NO");
        }
        
        [self cleanupWriter];
        
        DLog(@"Completed Video recording");
    }
    
    [pool drain];
}

- (bool) startRecording {
    bool result = NO;
    
    _drawRect = YES;
    
    @synchronized(self) {
        if (! _recording) {
            _recording = true;
            result = [self setUpWriter];
            startedAt = [[NSDate date] retain];
            [self setNeedsDisplay];
        }
    }
    return result;
}

- (void) stopRecording {
    @synchronized(self) {
        if (_recording) {
            [self completeRecordingSession];
            _recording = false;
        }
    }
}

-(void) writeVideoFrameAtTime:(CMTime)time {
    if (![videoWriterInput isReadyForMoreMediaData]) {
        DLog(@"Not ready for video data");
    }
    else {
        @synchronized (self) {
            UIImage* newFrame = [self.currentScreen retain];
            
            CVPixelBufferRef pixelBuffer = NULL;
            CGImageRef cgImage = CGImageCreateCopy([newFrame CGImage]);
            CFDataRef image = CGDataProviderCopyData(CGImageGetDataProvider(cgImage));
            
            int status = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, avAdaptor.pixelBufferPool, &pixelBuffer);
            if(status != 0){
                //could not get a buffer from the pool
                DLog(@"Error creating pixel buffer:  status=%d", status);
            }
            // set image data into pixel buffer
            CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
            uint8_t* destPixels = CVPixelBufferGetBaseAddress(pixelBuffer);
            CFDataGetBytes(image, CFRangeMake(0, CFDataGetLength(image)), destPixels);  //XXX:  will work if the pixel buffer is contiguous and has the same bytesPerRow as the input data
            
//            DLog(@"%@: CGImage to cache has dimensions %d x %d and %d bytes per row",
//                  NSStringFromCGSize(self.frame.size),
//                  CGImageGetWidth(cgImage), CGImageGetHeight(cgImage),
//                  CGImageGetBytesPerRow(cgImage));
//            DLog(@"%d", CVPixelBufferGetBytesPerRow(pixelBuffer));
            
            if(status == 0){
                BOOL success = [avAdaptor appendPixelBuffer:pixelBuffer withPresentationTime:time];
                if (!success)
                    DLog(@"Warning:  Unable to write buffer to video");
            }
            
            //clean up
            [newFrame release];
            CVPixelBufferUnlockBaseAddress( pixelBuffer, 0 );
            CVPixelBufferRelease( pixelBuffer );
            CFRelease(image);
            CGImageRelease(cgImage);
        }
        
    }
}

- (void)videoRecordingComlete{
    [self stopRecording];

    NSError *error = nil;
    
    AVURLAsset *video = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:tempVideoPath isDirectory:NO] options:nil];
    
    AVMutableComposition *saveComposition               = [AVMutableComposition composition];
    AVMutableCompositionTrack *compositionVideoTrack    = [saveComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *clipVideoTrack                        = [[video tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [video duration]) ofTrack:clipVideoTrack atTime:kCMTimeZero error:&error];
    
    NSURL *audioURL     = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    AVURLAsset *audio   = [AVURLAsset URLAssetWithURL:audioURL options:nil];
    [audioURL release];
    
    AVMutableCompositionTrack *compositionAudioTrack    = [saveComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *clipAudioTrack                        = [[audio tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [audio duration]) ofTrack:clipAudioTrack atTime:CMTimeMakeWithSeconds(2, 1) error:&error];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:videoFilePath];
    
    AVAssetExportSession *exporter  = [[[AVAssetExportSession alloc] initWithAsset:saveComposition presetName:AVAssetExportPresetHighestQuality] autorelease];
    exporter.outputURL              = url;
    exporter.outputFileType         = AVFileTypeQuickTimeMovie;
    
    [exporter exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         switch (exporter.status) 
         {
             case AVAssetExportSessionStatusCompleted:
                 // export complete 
                 responseBlock();
                 break;
             case AVAssetExportSessionStatusFailed:
                 errorBlock(exporter.error);
                 break;
             case AVAssetExportSessionStatusCancelled:
                 errorBlock(exporter.error);
                 // export cancelled  
                 break;
         }
         _drawRect = NO;
     }];
}

- (void)captureScreenWithAudio: (NSString *)anAudioFilePath 
                    targetPath: (NSString *)aVideoFilePath 
                   forDuration: (int)duration
                  withResponse: (void (^)(void))aresponseblock
                       orError: (void (^)(NSError *))anerrorblock{
    
    self.audioFilePath      = anAudioFilePath;
    self.videoFilePath      = aVideoFilePath;
    self.responseBlock      = aresponseblock;
    self.errorBlock         = anerrorblock;
    self.captureDuration    = duration;
    
    [self startRecording];
    [self performSelector:@selector(videoRecordingComlete) withObject:nil afterDelay:duration+5];
}

@end