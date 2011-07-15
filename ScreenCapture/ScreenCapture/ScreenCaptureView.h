//
//  ScreenCaptureView.h
//  ScreenCapture
//
//  Created by Ayush Goel on 04/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScreenCaptureViewDelegate <NSObject>
- (void) recordingFinished:(NSString*)outputPathOrNil;
@end

@interface ScreenCaptureView : UIView {
    //video writing
    AVAssetWriter *videoWriter;
    AVAssetWriterInput *videoWriterInput;
    AVAssetWriterInputPixelBufferAdaptor *avAdaptor;
    
    //recording state
    BOOL _recording;
    NSDate* startedAt;
    void* bitmapData;
}

//for recording video
- (bool) startRecording;
- (void) stopRecording;

//for accessing the current screen and adjusting the capture rate, etc.
@property(retain) UIImage* currentScreen;
@property(assign) float frameRate;
@property(nonatomic, assign) id<ScreenCaptureViewDelegate> delegate;

@end
