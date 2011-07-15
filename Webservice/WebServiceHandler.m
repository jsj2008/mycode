//
//  WebServiceHandler.m
//  CyberDictionary
//
//  Created by sujeet on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebServiceHandler.h"



@implementation WebServiceHandler
@synthesize theXML;

-(id)initWithWord:(NSString *)aWord
{
	//***************************************soap 1.1*****************************
	
	NSString *soapMsg = 
	[NSString stringWithFormat:
	 @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:rsap=\"http://www.resortsuite.com/RSAPP\">" 
	"<soapenv:Header>"
	"<o:Security xmlns:o=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" soapenv:mustUnderstand=\"1\">"
	"<o:UsernameToken>"
	"<o:Username>%@</o:Username>"
	"<o:Password>%@</o:Password>"
	"</o:UsernameToken>"
	"</o:Security>"
	"</soapenv:Header>"
	"<soapenv:Body>"
	"<rsap:FetchGuestItineraryRequest>"
	"<PMSFolioId>%@</PMSFolioId>"
	 "<GuestPin>group</GuestPin>"
	"</rsap:FetchGuestItineraryRequest>"
	"</soapenv:Body>"
	"</soapenv:Envelope>",@"resortsuite",@"resortsuite",@"53137"
	 ];
	
	
	NSLog(@"soapMsg: %@", soapMsg);
	
    //create a URL load request object using instances of the NSMutableURLRequest and NSURL objects
	
    NSURL *url = [NSURL URLWithString: @"https://206.223.188.227:2112/wso2wsas/services/RSAPP.RSAPPSOAP"];//https://206.223.188.227:2112/wso2wsas/services/RSAPP?wsdl
	
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	
 	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];

	[req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
	
    [req addValue:@"text/xml; charset=utf-8"  forHTTPHeaderField:@"Content-Type"];	////soap 1.2 chnage
	
    [req addValue:@"http://RSAPP.asp#FetchGuestItinerary" forHTTPHeaderField:@"SOAPAction"];// not required
	
	
    [req setHTTPMethod:@"POST"];
	
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
	
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
	NSLog(@"connection didReceiveResponse");
}

-(void) connection:(NSURLConnection *) connection 
	didReceiveData:(NSData *) data {
	[webData appendData:data];
	NSLog(@"connection didReceiveData");
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
    NSLog(@"DONE. Received Bytes: %d", [webData length]);
   theXML = [[NSString alloc] 
                        initWithBytes: [webData mutableBytes] 
                        length:[webData length] 
                        encoding:NSUTF8StringEncoding];
    //---shows the XML---
    NSLog(@"recieved xml is %@",theXML);
	


	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [connection release];
    [webData autorelease];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    NSLog(@"\nused to call the canAuthenticateAgainstProtectionSpace\n");
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	
    NSLog(@"\nused to call the didReveiceAutheticationChallenge\n");
    //if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
	//if ([trustedHosts containsObject:challenge.protectionSpace.host])
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
		
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}
-(void)dealloc
{
	[theXML release];
	[super dealloc];
}
@end
