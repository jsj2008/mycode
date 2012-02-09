//
//  pdfViewViewController.m
//  pdfView
//
//  Created by Ayush Goel on 25/11/11.
//  Copyright 2011 goelay@gmail.com. All rights reserved.
//

#import "pdfViewViewController.h"


@implementation pdfViewViewController

- (void)viewDidLoad
{
    
    [self savePDFFile];
    [super viewDidLoad];
 
}

- (void )savePDFFile
{
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, (CFStringRef)@"Hello yea we are doing good", NULL);
    if (currentText) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
        if (framesetter) {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:@"temp.pdf"];
        
            // Create the PDF context using the default page size of 612 x 792.
            UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
            
            CFRange currentRange = CFRangeMake(0, 0);
            NSInteger currentPage = 0;
            BOOL done = NO;
            
            do {
                // Mark the beginning of a new page.
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                
                // Draw a page number at the bottom of each page
                currentPage++;
                [self drawPageNumber:currentPage];
                NSString* pageString = [NSString stringWithFormat:@"Page %d", 13144];
                [pageString drawInRect:CGRectMake(400,400,100,100) withFont:[UIFont systemFontOfSize:12]];
                
                 CGContextRef    currentContext = UIGraphicsGetCurrentContext();
                //UIImage * myPNG = [UIImage imageNamed:@"dialer-count-active.png"];
                UIImage * myPNG =imageView.image;
                CGContextDrawImage (currentContext, CGRectMake(200, 200, 100, 100), [myPNG CGImage]);
                // Render the current page and update the current range to
                // point to the beginning of the next page.
                
                currentRange = [self renderPage:currentPage withTextRange:currentRange andFramesetter:framesetter];
                
                // If we're at the end of the text, exit the loop.
                if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
                    done = YES;
            } while (!done);
            
            // Close the PDF context and write the contents out.
            UIGraphicsEndPDFContext();
            
            // Release the framewetter.
            CFRelease(framesetter);
            
        } else {
            NSLog(@"Could not create the framesetter needed to lay out the atrributed string.");
        }
        // Release the attributed string.
        CFRelease(currentText);
    } else {
        NSLog(@"Could not create the attributed string for the framesetter");
    }
}

- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
       andFramesetter:(CTFramesetterRef)framesetter
{
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);

    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    CGRect    frameRect = CGRectMake(72, 72, 468, 648);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    // Update the current range based on what was drawn.
    currentRange = CTFrameGetVisibleStringRange(frameRef);
    currentRange.location += currentRange.length;
    currentRange.length = 0;
    CFRelease(frameRef);
    
    return currentRange;
}

- (void)drawPageNumber:(NSInteger)pageNum
{
    NSString* pageString = [NSString stringWithFormat:@"Page %d", pageNum];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    CGSize maxSize = CGSizeMake(612, 72);
    
    CGSize pageStringSize = [pageString sizeWithFont:theFont
                                   constrainedToSize:maxSize
                                       lineBreakMode:UILineBreakModeClip];
    CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
                                   720.0 + ((72.0 - pageStringSize.height) / 2.0) ,
                                   pageStringSize.width,
                                   pageStringSize.height);
    
    [pageString drawInRect:stringRect withFont:theFont];

}


-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
