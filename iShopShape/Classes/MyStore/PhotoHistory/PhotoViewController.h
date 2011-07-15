/*
     File: PhotoViewController.h
 Abstract: n/a
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import <UIKit/UIKit.h>

@class ImageScrollView;

@interface PhotoViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *pagingScrollView;
    int currentImageIndex;
	NSArray *__imageData;
    NSMutableSet *recycledPages;
    NSMutableSet *visiblePages;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageArray : (NSArray*)imageLibrary index:(int)aIndex;

/**
 *	@functionName	: configurePage
 *	@parameters		: (NSUInteger)index page index no
 : (ImageScrollView *)page - page to be displayed at index no
 *	@return			: (void)
 *	@description	: This method Configure outer scrollView to display new page at index
 */
- (void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index;

/**
 *	@functionName	: isDisplayingPageForIndex
 *	@parameters		:(NSUInteger)index - page index no
 *	@return			: (BOOL)
 *	@description	: This method checks if the page at index no is being displayed or not
 */
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;

/**
 *	@functionName	: frameForPagingScrollView
 *	@parameters		:
 *	@return			: (CGRect)
 *	@description	: This method returns the rect size for the outer scrollview
 */
- (CGRect)frameForPagingScrollView;

/**
 *	@functionName	: frameForPageAtIndex
 *	@parameters		: (NSUInteger)index - page index no
 *	@return			: (CGRect)
 *	@description	: This method returns the rect size for the page at index no
 */
- (CGRect)frameForPageAtIndex:(NSUInteger)index;

/**
 *	@functionName	: tilePages
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: This method Calculate which pages are visible,Recycle no-longer-visible pages
 *					: add missing pages
 */
//- (void)tilePages;

/**
 *	@functionName	: dequeueRecycledPage
 *	@parameters		: 
 *	@return			: (ImageScrollView *)
 *	@description	: This method removes the recycle pages
 */
- (ImageScrollView *)dequeueRecycledPage;

/**
 *	@functionName	: imageNameAtIndex
 *	@parameters		: (NSUInteger)index - name of the image to be displaced at index no
 *	@return			: (NSString *)
 *	@description	: This method return to image name to be displaced at index no
 */
- (NSString *)imageNameAtIndex:(NSUInteger)index;

/**
 *	@functionName	: imageAtIndex
 *	@parameters		: (NSUInteger)index - index no of the page to be displayed
 *	@return			: (UIImage *))
 *	@description	: This method return the UIImage Object to be displayed at the index no
 */
- (UIImage *)imageAtIndex:(NSUInteger)index;
- (void)processPages;
@end

