//
//  CanvasDrawView.h
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenCaptureView.h"
#import "TouchImageView.h"

@class CanvasObjectMuppet;
@interface CanvasDrawView : ScreenCaptureView {
    
}

- (CanvasObjectMuppet *)speakingMuppet;

@end
