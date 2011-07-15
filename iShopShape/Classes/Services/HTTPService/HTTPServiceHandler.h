//
//  HTTPServiceHandler.h
//  iShopShape
//
//  Created by Santosh B on 30/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPServiceHandlerDelegate
-(void) httpServiceFinish : (NSDictionary *)dict;
-(void) httpServiceFinishWithError : (NSError *)error;
@end


@interface HTTPServiceHandler : NSObject {
	
	id <HTTPServiceHandlerDelegate> delegate;
	// the queue to run our "Operation"
    NSOperationQueue		*queue;
	NSURLConnection         *connection;
    NSMutableData           *appData;
}
@property (nonatomic, assign) id <HTTPServiceHandlerDelegate> delegate;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *appData;

-(void) initWithRequest : (NSURL *)url;
-(void) getStoreList : (NSURL *)url;
@end
