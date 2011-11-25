//
//  pdfViewViewController.h
//  pdfView
//
//  Created by Ayush Goel on 25/11/11.
//  Copyright 2011 goelay@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CTFramesetter.h>


@interface pdfViewViewController : UIViewController
{
    
    IBOutlet UIImageView *imageView;
    
}
//- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
      // andFramesetter:(CTFramesetterRef)framesetter;
- (void)drawPageNumber:(NSInteger)pageNum;
- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
       andFramesetter:(CTFramesetterRef)framesetter;
- (void )savePDFFile;
@end
