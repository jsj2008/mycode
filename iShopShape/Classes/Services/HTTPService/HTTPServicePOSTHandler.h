//
//  HTTPServicePOSTHandler.h
//  iShopShape
//
//  Created by Santosh B on 12/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HTTPServicePOSTHandlerDelegate

-(void) httpPOSTServiceFinish : (NSDictionary *)dict;
-(void) httpPOSTServiceFinishWithError : (NSError *)error;

@end

@interface HTTPServicePOSTHandler : NSObject {
	id <HTTPServicePOSTHandlerDelegate> delegate;
	NSURLConnection         *connection;
    NSMutableData           *appData;
}

@property (nonatomic, assign) id <HTTPServicePOSTHandlerDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *appData;

- (void) initWithRequest : (NSURL *)url aDict: (NSDictionary*)dataDictionary;
- (void) registerUser : (NSURL *)url;
- (void) unregisterUser : (NSURL *)url; 
- (void) postInstructionComments:(NSURL *)url ;
- (void) postCommentsWithImage : (NSURL *)url notificaitonID: (NSString*)noticiationID message : (NSString*)message imageData : (NSData*)data;
@end
