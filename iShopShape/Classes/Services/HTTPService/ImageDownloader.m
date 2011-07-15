//
//  ImageDownloader.m
//  iShopShape
//
//  Created by Santosh B on 30/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "ImageDownloader.h"
#import "Logger.h"

@implementation ImageDownloader
@synthesize delegate;
@synthesize indexPathInTableView;
@synthesize activeDownload;
@synthesize imageConnection;

#pragma mark

- (void)dealloc
{
	NSLog(@"ImageDownloader ------------- Release");
	[urlRequest release];
    [indexPathInTableView release];
    
    [activeDownload release];
    
    [imageConnection cancel];
    [imageConnection release];
    
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
	
	if(delegate)
	{
		[delegate downloadDidFinishWithError:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
        
    self.activeDownload = nil;
	
	// call our delegate and tell it that our icon is ready for display

	if(delegate)
	{
		[delegate downloadDidFinishDownloading:image index:self.indexPathInTableView];
	}
	   
    [image release];
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
	
}

@end
