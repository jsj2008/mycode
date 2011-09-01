//
//  FacebookAccount.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/17/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "KeychainItemWrapper.h"

extern NSString * const AccountLoginStatusChanged;

typedef enum {
    AccountStatusLoggedOut,
    AccountStatusVerifyingFacebookCredentials,
    AccountStatusFacebookLoggedIn,
    AccountStatusFacebookLoginFailed,
    AccountStatusFacebookLoginDialogShown,
    AccountStatusVerifyingMuppetCredentials,
    AccountStatusMuppetLoggedIn,
    AccountStatusMuppetLoginFailed
} AccountStatus;

@interface MuppetAccount : NSObject <FBSessionDelegate, FBRequestDelegate> {
    Facebook *facebook;
    NSArray *_fbpermissions;
    
    KeychainItemWrapper *_keyChainWrapper;
    NSString *userName;
	NSString *email;
	NSString *facebookId;
	NSString *apiKey;
    
    NSArray *friends;
    
    AccountStatus status;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSArray *friends;
@property (nonatomic, assign) AccountStatus status;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *facebookId;

+ (MuppetAccount*)shared;
- (void)login;
- (void)logout;
- (void)verifyRemoteSession;
- (void)fetchFriendsWithResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock;

- (void)postRequestWithPath:(NSString *)path
                  andParams:(NSDictionary *)params
                andResponse:(void (^)(id))aResponseBlock
                   andError:(void (^)(NSError *))anErrorBlock;
- (void)getRequestWithPath:(NSString *)path
                 andParams:(NSMutableDictionary *)params
               andResponse:(void (^)(id))aResponseBlock
                  andError:(void (^)(NSError *))anErrorBlock;

- (void)fetchAlbumsWithParams:(NSDictionary *)params andResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock;
- (void)fetchPicturesWithParams:(NSMutableDictionary *)params andAlbumId:(NSString *)anAlbumId andResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock;
- (void)uploadVideo:(NSString *)path andResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock;

@end
