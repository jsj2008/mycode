//
//  HTTPServiceHandler.m
//  iShopShape
//
//  Created by Santosh B on 30/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "HTTPServiceHandler.h"
#import "iShopShapeAppDelegate.h"
#import "JSON.h"
#import "Reachability.h"
@implementation HTTPServiceHandler
@synthesize queue, connection, appData;
@synthesize delegate;

-(void) initWithRequest : (NSURL *)url
{		
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];

		NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
		
		[theRequest addValue:[userDefault objectForKey:@"USER_ID"] forHTTPHeaderField:@"DeviceId"];
		
		NSLog(@"STORE_ID == %@", [userDefault objectForKey:@"STORE_ID"]);
		NSLog(@"Header ==%@", [theRequest allHTTPHeaderFields]);
		
		NSLog(@"Request ==%@", theRequest);
		self.connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	}
	else 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No or low signal available" message:@"Please try again in a minute" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
		[alert show];
		[alert release];
	}
	
}

-(void) getStoreList : (NSURL *)url
{
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
		
		self.connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	}
	else 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No or low signal available" message:@"Please try again in a minute" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
		[alert show];
		[alert release];
	}
}

// -------------------------------------------------------------------------------
//	handleError:error
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to get data"
														message:errorMessage
													    delegate:nil
														cancelButtonTitle:@"OK"
														otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

// The following are delegate methods for NSURLConnection. Similar to callback functions, this is how
// the connection object,  which is working in the background, can asynchronously communicate back to
// its delegate on the thread from which it was started - in this case, the main thread.
//

// -------------------------------------------------------------------------------
//	connection:didReceiveResponse:response
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.appData = [NSMutableData data];    // start off with new data
}

// -------------------------------------------------------------------------------
//	connection:didReceiveData:data
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [appData appendData:data];  // append incoming data
}

// -------------------------------------------------------------------------------
//	connection:didFailWithError:error
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
		if(delegate)
		{
			[delegate httpServiceFinishWithError:error];
		}
    }
	else
	{
		if(delegate)
		{
			[delegate httpServiceFinishWithError:error];
		}
        // otherwise handle the error generically
        //[self handleError:error];
    }
    [self.connection release];
    self.connection = nil;   // release our connection
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self.connection release];
    self.connection = nil;   // release our connection
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   

	
	if(delegate)
	{
		NSString *str = [[NSString alloc] initWithData:appData encoding:NSASCIIStringEncoding];
		NSLog(@"%@",str);
		NSDictionary *result = [str JSONValue];
		[delegate httpServiceFinish:result];
		[str release];
	}
	
    // ownership of appListData has been transferred to the parse operation
    // and should no longer be referenced in this thread
    self.appData = nil;
}

// -------------------------------------------------------------------------------
//	dealloc
// -------------------------------------------------------------------------------
- (void)dealloc
{
	delegate = nil;
    [appData release];
	[super dealloc];
}

@end
