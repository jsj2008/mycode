//
//  HTTPServicePOSTHandler.m
//  iShopShape
//
//  Created by Santosh B on 12/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "HTTPServicePOSTHandler.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "Reachability.h"

@implementation HTTPServicePOSTHandler
@synthesize delegate, connection, appData;

-(void) initWithRequest : (NSURL *)url aDict: (NSDictionary*)dataDictionary
{
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
		
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:@"application/json-rpc" forHTTPHeaderField:@"Content-Type"];
		
		NSString *theBodyString = [dataDictionary JSONRepresentation];

		NSData *theBodyData = [theBodyString dataUsingEncoding:NSUTF8StringEncoding];   
		[theRequest setHTTPBody:theBodyData];  
		
		NSLog(@"theRequest=%@", theRequest);
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

- (void) registerUser : (NSURL *)url
{
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
		
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:@"application/json-rpc" forHTTPHeaderField:@"Content-Type"];	

		NSLog(@"registerUser Request=%@", theRequest);
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

- (void) unregisterUser : (NSURL *)url
{
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
		
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:@"application/json-rpc" forHTTPHeaderField:@"Content-Type"];	
		NSUserDefaults *standardUserdefualts = [NSUserDefaults standardUserDefaults];
		[theRequest addValue:[standardUserdefualts objectForKey:@"USER_ID"] forHTTPHeaderField:@"DeviceId"];
		
		NSLog(@"unRegisterUser Request=%@", theRequest);
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

- (void) postInstructionComments:(NSURL *)url 
{
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
		
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:@"application/json-rpc" forHTTPHeaderField:@"Content-Type"];	
		NSUserDefaults *standardUserdefualts = [NSUserDefaults standardUserDefaults];
		[theRequest addValue:[standardUserdefualts objectForKey:@"USER_ID"] forHTTPHeaderField:@"DeviceId"];
		
		NSLog(@"postInstructionComments Header %@", [theRequest allHTTPHeaderFields]);
		NSLog(@"postInstructionComments Request=%@", theRequest);
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


- (void) postCommentsWithImage : (NSURL *)url notificaitonID: (NSString*)noticiationID message : (NSString*)message imageData : (NSData*)data
{
	if([[Reachability sharedReachability] internetConnectionStatus] != NotReachable)
	{
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
		
		[theRequest setHTTPMethod:@"POST"];
		
		//[theRequest setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
		
		[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		NSUserDefaults *standardUserdefualts = [NSUserDefaults standardUserDefaults];
		[theRequest addValue:[standardUserdefualts objectForKey:@"USER_ID"] forHTTPHeaderField:@"DeviceId"];
		
		NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
		[dataDictionary setObject:noticiationID forKey:@"notificationid"];
		if(message)
			[dataDictionary setObject:message forKey:@"message"];
		else {
			[dataDictionary setObject:@"" forKey:@"message"];
		}

		if(data)
		{
			//NSString* pictureDataString = [data base64EncodedString];
			NSString* pictureDataString = [NSData encode:data];
			[dataDictionary setObject:pictureDataString forKey:@"imagebyte"];
		}
		else {
			[dataDictionary setObject:@"" forKey:@"imagebyte"];
		}

		NSString *theBodyString = [dataDictionary JSONRepresentation];
		
		[dataDictionary release];
		
		NSData *theBodyData = [theBodyString dataUsingEncoding:NSUTF8StringEncoding];   
		[theRequest setHTTPBody:theBodyData];  
		
		[theRequest setHTTPBody:theBodyData];  
		
		NSLog(@"theRequest=%@", theRequest);
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
	NSLog(@"POST didFailWithError");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
		if(delegate)
		{
			[delegate httpPOSTServiceFinishWithError:error];
		}
    }
	else
	{
		if(delegate)
		{
			[delegate httpPOSTServiceFinishWithError:error];
		}
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
		NSLog(@"POST Response %@",str);
		if(str)
		{
			NSDictionary *result = [NSDictionary dictionaryWithObject:str forKey:@"RESPONSE"];
			[delegate httpPOSTServiceFinish:result];
		}
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
