//
//  WebServicePost.m
//  BlogApp
//
//  Created by Ayush Goel on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebServicePost.h"
#import "JSON.h"
#import "SBJSON.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebServicePost
@synthesize connection, appData;

-(id) initWithRequest : (NSURL *)url aDict: (NSDictionary*)dataDictionary
{
    NSMutableString *params=[[NSMutableString alloc]init];
    NSLog(@"dict == %@",dataDictionary);
    
    for (id key in dataDictionary)
    {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        CFStringRef value = (CFStringRef)[[dataDictionary objectForKey:key] copy];
        CFStringRef encodedValue = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                           value,
                                                                           NULL, 
                                                                           (CFStringRef)@";/?:@&=+$,", 
                                                                           kCFStringEncodingUTF8);
        [params appendFormat:@"%@=%@&", encodedKey, encodedValue];
        CFRelease(value);
        CFRelease(encodedValue);
    }
       
    
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
		[theRequest setHTTPMethod:@"POST"];
        NSData *theBodyData = [params dataUsingEncoding:NSUTF8StringEncoding]; 
        [theRequest setHTTPBody:theBodyData];  
  	     self.connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
   
    
return self;
	
}




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
    CFShow(error);
        [self.connection release];
    self.connection = nil;   // release our connection
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     NSString *str = [[NSString alloc] initWithData:appData encoding:NSASCIIStringEncoding];
    //NSDictionary *result = [str JSONValue];
    NSLog(@"POST Response my arraay ===  %@",str);
}

// -------------------------------------------------------------------------------
//	dealloc
// -------------------------------------------------------------------------------
- (void)dealloc
{

    [appData release];
	[super dealloc];
}


@end
