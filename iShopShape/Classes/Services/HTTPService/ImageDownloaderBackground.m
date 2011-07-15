//
//  ImageDownloaderBackground.m
//  iShopShape
//
//  Created by Santosh B on 30/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "ImageDownloaderBackground.h"
#import "Logger.h"

@implementation ImageDownloaderBackground

@synthesize indexPathInTableView;
@synthesize activeDownload;
@synthesize imageConnection;
@synthesize instructionId;
#pragma mark

- (void)dealloc
{
	NSLog(@"ImageDownloaderBackground ------------- Release");
	[urlRequest release];
    [indexPathInTableView release];
    
    [activeDownload release];
    
    [imageConnection cancel];
    [imageConnection release];
    [instructionId release];
    [super dealloc];
}

-(id) initWithRequest : (NSURL *)url
{
	if(self = [super init])
	{
		urlRequest = [NSURLRequest requestWithURL:url];
		[urlRequest retain];
	}
	return self;
}

- (void)startDownload
{
    self.activeDownload = [NSMutableData data];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
	
    self.imageConnection = conn;
    [conn release];
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

- (void) saveInstructionResourcesFolder:(UIImage *)image
{
	// Create paths to output images
	NSString *newPath = [NSString stringWithFormat:@"Documents/%@.png",instructionId];
	
	NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:newPath];
	
	[UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
	
	// Let's check to see if files were successfully written...
	
	// Create file manager
	NSError *error = nil;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	
	// Point to Document directory
	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	// Write out the contents of home directory to console
	NSLog(@"saveFileInResourcesFolder Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
        
    self.activeDownload = nil;
	
	// call our delegate and tell it that our icon is ready for display
	if(image)
		[self saveInstructionResourcesFolder:image];

    [image release];
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
	
}



@end
