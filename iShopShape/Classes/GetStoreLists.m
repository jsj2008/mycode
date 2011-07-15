//
//  GetStoreLists.m
//  iShopShape
//
//  Created by Santosh B on 20/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "GetStoreLists.h"
#import "Logger.h"
#import "Parser.h"

@implementation GetStoreLists
@synthesize delegate;
- (void) accessStoreList
{
	NSURL *url = [NSURL URLWithString:STORELIST_URL];
	HTTPServiceHandler *HTTPServiceHandlerObj = [[HTTPServiceHandler alloc] autorelease];
	[HTTPServiceHandlerObj getStoreList:url];
	
	HTTPServiceHandlerObj.delegate = self;
}

#pragma mark -
#pragma mark HTTPServiceHandlerDelegate
#pragma mark -

-(void) httpServiceFinish : (NSDictionary *)dict
{
	
	if([(NSMutableArray *)dict count])
	{
		NSArray *paresedList = [Parser parseStoreList:(NSArray *)dict];
		
		if(delegate)
		{
			[delegate getStoreList:paresedList];
		}
		NSLog(@"paresedList ======%@", paresedList);
	}
	
}

-(void) httpServiceFinishWithError : (NSError *)error
{
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];	
}

- (void) dealloc
{
	delegate = nil;
	[super dealloc];
}

@end
