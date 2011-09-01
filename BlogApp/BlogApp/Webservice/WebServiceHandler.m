
#import "WebServiceHandler.h"
#import "JSON.h"


@implementation WebServiceHandler
@synthesize theXML;

-(id)initWithWord:(NSURL *) url;
{
	//***************************************soap 1.1*****************************
	
	

	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	if (conn) {
		webData = [[NSMutableData data] retain];
	}    
	return self;
}

-(void) connection:(NSURLConnection *) connection 
didReceiveResponse:(NSURLResponse *) response {
	[webData setLength: 0];
	//NSLog(@"connection didReceiveResponse");
}

-(void) connection:(NSURLConnection *) connection 
	didReceiveData:(NSData *) data {
	[webData appendData:data];
	//NSLog(@"connection didReceiveData");
}

-(void) connection:(NSURLConnection *) connection 
  didFailWithError:(NSError *) error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"didFailWithError sunny %@", error);
	[webData release];
    [connection release];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection 
{
   // NSLog(@"DONE. Received Bytes: %d", [webData length]);
   theData = [[NSString alloc] 
                        initWithBytes: [webData mutableBytes] 
                        length:[webData length] 
                        encoding:NSUTF8StringEncoding];
   
  result = [theData JSONValue];
    NSLog(@"recieved data== %@",result);
	
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unique" object:nil userInfo:nil];
   

    [connection release];
    [webData autorelease];
}
-(NSMutableDictionary *) returnData
{
    return result;
}



-(void)dealloc
{
	[theData release];
	[super dealloc];
}
@end
