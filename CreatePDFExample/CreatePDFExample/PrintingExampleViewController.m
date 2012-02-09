//
//  PrintingExampleViewController.m
//  PrintingExample
//
//  Created by Craig Spitzkoff on 6/9/11.
//  Copyright 2011 Raizlabs Corporation. All rights reserved.
//

#import "PrintingExampleViewController.h"

#define kDefaultPageHeight 2550
#define kDefaultPageWidth  3300
#define kMargin 200
#define kColumnMargin 50

@implementation PrintingExampleViewController
@synthesize pdfFilePath;
@synthesize testImage;
@synthesize testView;

- (void)dealloc
{
    [pdfFilePath release];
    
	[testView release];
	
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
	
	
    [super viewDidLoad];
	
	//self.testImage = [UIImage imageNamed:@"testing.png"];
	//UIImageView *containImage = [[[UIImageView alloc] initWithFrame:CGRectMake(-265, 40, 745, 270)] autorelease];
	//containImage.image = testImage;
   // [self.view addSubview:containImage];
	
	
	UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 480, 260)];
	newView.backgroundColor = [UIColor grayColor];	
	
	UIView *smallView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)] autorelease];
	smallView.backgroundColor = [UIColor greenColor];
	[newView addSubview:smallView];
	smallView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	UIView *bigView = [[[UIView alloc] initWithFrame:CGRectMake(430, 200, 50, 60)] autorelease];
	bigView.backgroundColor = [UIColor orangeColor];
	[newView addSubview:bigView];
	bigView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	newView.autoresizesSubviews = true;
	

	//[newView setTransform:CGAffineTransformMakeScale(.1,.1)];
	
	//newView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	
	//newView.transform = CGAffineTransformMakeScale(.1, .1);

	
	
	//newView.transform = t;
	//newView.frame = CGRectMake(0, 0, 960, 640);

	
	//newView.transform = CGAffineTransformMakeScale(.3, .3);	
	
	self.testView = newView;
	
	//testView = [self scaleView:testView];
	
	[self.view addSubview:testView];
	//[self.view addSubview:newView];

	
	
	
}

- (IBAction)scaleIT:(id)sender {
	testView = [self scaleView:testView];
	testView.frame = CGRectMake(0, 0, 100, 100);
}


- (UIView *) scaleView:(UIView *) viewScale {
	
	viewScale.autoresizesSubviews = true;
	
	CGAffineTransform scalingTransform;
	scalingTransform = CGAffineTransformMakeScale(.3, .3);
	viewScale.transform = scalingTransform;	
	
	NSLog(@"scaled it");
	
	return viewScale;
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)pdfPressed:(id)sender {

    
   NSString *path = NSTemporaryDirectory();
    self.pdfFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.pdf", [[NSDate date] timeIntervalSince1970] ]];
    UIGraphicsBeginPDFContextToFile(self.pdfFilePath, CGRectZero, nil);
    
	
	
    // get the context reference so we can render to it. 
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    // iterate through out students, adding to the pdf each time. 
    for (int counter=0;counter<3;counter++ )
    {
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth, kDefaultPageHeight), nil);
		UIView *tempView = testView;
        tempView.frame = CGRectMake(1000,1000, 1000,1000);
		[testView drawRect:CGRectMake(1000,1000, 1000, 1000)];
		[testView.layer renderInContext:context];
        tempView.frame = CGRectMake(0, 60, 480,260);        
    }
    
    // end and save the PDF. 
    UIGraphicsEndPDFContext();
    
    // Ask the user if they'd like to see the file or email it.
    UIActionSheet* actionSheet = [[[UIActionSheet alloc] initWithTitle:@"Would you like to preview or email this PDF?"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Preview", @"Email", nil] autorelease];
    [actionSheet showInView:self.view];
    
}

#pragma mark - MFMailComposerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error 
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Action Sheet button %d", buttonIndex);
    
    if (buttonIndex == 0) {
        
        // present a preview of this PDF File. 
        QLPreviewController* preview = [[[QLPreviewController alloc] init] autorelease];
        preview.dataSource = self;
        [self presentModalViewController:preview animated:YES];

    }
    else if(buttonIndex == 1)
    {
        // email the PDF File. 
        MFMailComposeViewController* mailComposer = [[[MFMailComposeViewController alloc] init] autorelease];
        mailComposer.mailComposeDelegate = self;
        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:self.pdfFilePath]
                               mimeType:@"application/pdf" fileName:@"report.pdf"];
        
        [self presentModalViewController:mailComposer animated:YES];        
    }
    
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [NSURL fileURLWithPath:self.pdfFilePath];
}



@end
