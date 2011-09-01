//
//  FacebookAccount.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/17/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "MuppetAccount.h"
#import "SBJson.h"
#import "ASIFormDataRequest.h"

NSString * const AccountLoginStatusChanged = @"AccountLoginStatusChanged";

static MuppetAccount *shared=nil;

@interface MuppetAccount (private)

- (void)load;
- (void)serializeAccountInfo;
- (void)deSerializeAccountInfo;
- (void)registerAccount;
- (NSString *)accountExpirationDateAsString;
- (NSDate *)accountExpirationDateFromString:(NSString *)dateAsString;

@end

@implementation MuppetAccount

@synthesize facebook;
@synthesize friends;
@synthesize status;
@synthesize userName;
@synthesize email;
@synthesize facebookId;

+ (MuppetAccount*)shared{
	@synchronized(shared){
		if (!shared) {
			shared = [[MuppetAccount alloc] init];
			[shared load];
		}
	}
	return shared;
}

- (id) init {
    self = [super init];
    if (self) {
        facebook                    = [[Facebook alloc] initWithAppId:kFacebookAppId];
        facebook.sessionDelegate    = self;
        _keyChainWrapper            = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainIdentifier accessGroup:kKeyChainAccessGroup];
    }
    return self;
}

- (void)dealloc{
    [_fbpermissions release];
    [facebook release];
    [friends release];
    [userName release];
    [email release];
    [facebookId release];
    [super dealloc];
}


- (void)load{
    self.status     = AccountStatusLoggedOut;
    _fbpermissions  = [[NSArray arrayWithObjects:@"friends_birthday", @"publish_stream", @"offline_access", @"user_photos", @"email",nil] retain];
    [self deSerializeAccountInfo];
}

- (void)login {
    [facebook authorize:_fbpermissions delegate:self];
    self.status = AccountStatusFacebookLoginDialogShown;
}

- (void)logout {
    [facebook logout:self];
}

- (void)setStatus:(AccountStatus)astatus{
    status = astatus;
    [[NSNotificationCenter defaultCenter] postNotificationName:AccountLoginStatusChanged object:self];
}

- (void)verifyRemoteSession{
    self.status = AccountStatusVerifyingFacebookCredentials;
    [facebook requestWithGraphPath:@"me" andParams:nil andResponse:^(id response) {
        userName	= [[response objectForKey:@"name"] retain];
        email		= [[response objectForKey:@"email"] retain];
        facebookId	= [[response objectForKey:@"id"] retain];

        [self registerAccount];
        self.status = AccountStatusFacebookLoggedIn;
    } andError:^(NSError *error) {
        self.status = AccountStatusFacebookLoginFailed;
    }];
}

- (void)registerAccount{
    self.status = AccountStatusVerifyingMuppetCredentials;
    [self postRequestWithPath:kLoginPath andParams:[NSDictionary dictionaryWithObjectsAndKeys:[MuppetAccount shared].facebook.accessToken, @"access_token", nil] andResponse:^(id response) {
        [self serializeAccountInfo];
        self.status = AccountStatusMuppetLoggedIn;
    } andError:^(NSError *error) {
        self.status = AccountStatusMuppetLoginFailed;
    }];
}

#pragma mark -
#pragma mark serialization and deserialization
- (void)serializeAccountInfo{
	NSDictionary *_facebookData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       facebook.accessToken,                    @"accessToken",
                                       [self accountExpirationDateAsString],    @"expirationDate",
                                       userName,                                @"userName",
                                       email,                                   @"email",
                                       facebookId,                              @"facebookId",
                                       apiKey,                                  @"apiKey",
                                       nil
								   ];
	
	NSString *_facebookDataAsString = [_facebookData JSONRepresentation];
    if (TARGET_IPHONE_SIMULATOR) {
        [_keyChainWrapper setObject:_facebookDataAsString forKey:kKeyChainKey];
    }
    else {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:_facebookDataAsString forKey:kKeyChainKey];
        [prefs synchronize];
    }
}

- (void)deSerializeAccountInfo{
    NSString *_facebookDataAsString;
    if (TARGET_IPHONE_SIMULATOR) {
        _facebookDataAsString = [_keyChainWrapper objectForKey:kKeyChainKey];
    }
    else {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        _facebookDataAsString = [prefs objectForKey:kKeyChainKey];
    }
	
	if (_facebookDataAsString && ![_facebookDataAsString isEqualToString:@""]) {
		NSDictionary *_facebookData	= [_facebookDataAsString JSONValue];
        
        [facebook fbDialogLogin:[_facebookData objectForKey:@"accessToken"] expirationDate:[self accountExpirationDateFromString:[_facebookData objectForKey:@"expirationDate"]]];
		userName					= [_facebookData objectForKey:@"userName"];
		email						= [_facebookData objectForKey:@"email"];
		facebookId					= [_facebookData objectForKey:@"facebookId"];
		apiKey						= [_facebookData objectForKey:@"apiKey"];
	}
}

#pragma mark -
#pragma mark FBSessionDelegate

-(void)fbDidNotLogin:(BOOL)cancelled {
    DLog(@"Did not Log In");
    self.status = AccountStatusFacebookLoginFailed;
}

- (void)fbDidLogout {
    DLog(@"Logged out");
    self.status = AccountStatusLoggedOut;
}

- (void)fbDidLogin {
    DLog(@"Logged In");
    [self verifyRemoteSession];
}

- (NSDate *)birthDayFromString:(NSString *)birthDayString{
    if (!birthDayString) return nil;

    NSDateFormatter *_formatter = [[[NSDateFormatter alloc] init] autorelease];
    [_formatter setTimeZone:[NSTimeZone systemTimeZone]];

	// Does the string include year?
	NSString *_year = @"";
	if ([[birthDayString componentsSeparatedByString:@"/"] count] == 3) {
		_year = @"/yyyy";
	}

	[_formatter setDateFormat:[NSString stringWithFormat:@"MM/dd%@",_year]];
	return [_formatter dateFromString:birthDayString];
}

- (void)parseBirthDays{
    for (NSDictionary *_friend in friends) {
        [_friend setValue:[self birthDayFromString:[_friend objectForKey:@"birthday"]] forKey:@"parsed_birthday"];
    }
}

#pragma mark remote requests

- (void)postRequestWithPath:(NSString *)path
                  andParams:(NSDictionary *)params
                andResponse:(void (^)(id))aResponseBlock
                   andError:(void (^)(NSError *))anErrorBlock{
    ASIFormDataRequest *_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:path]];
    
    for (id key in [params allKeys]) {
        [_request setPostValue:[params objectForKey:key] forKey:key];
    }
    
    [_request setCompletionBlock:^{
        if ([_request responseStatusCode] == 200 || [_request responseStatusCode] == 201) {
            aResponseBlock([[_request responseString] JSONValue]);
        } else {
            anErrorBlock([NSError errorWithDomain:@"Unidentified Error" code:[_request responseStatusCode] userInfo:nil]);
        }
    }];
    
    [_request setFailedBlock:^{
        anErrorBlock([_request error]);
    }];
    
    [_request setRequestMethod:@"POST"];
    
    [_request startAsynchronous];
}

- (void)getRequestWithPath:(NSString *)path
                 andParams:(NSMutableDictionary *)params
               andResponse:(void (^)(id))aResponseBlock
                  andError:(void (^)(NSError *))anErrorBlock{
    ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:path]];
    [_request setTimeOutSeconds:300.0];
    [_request setCompletionBlock:^{
        aResponseBlock([[_request responseString] JSONValue]);
    }];
    
    [_request setFailedBlock:^{
        anErrorBlock([_request error]);
    }];
    
    [_request startAsynchronous];
}

- (void)fetchFriendsWithResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock{
    // TODO: Check for block memeory leaks - gaurav
    [facebook requestWithGraphPath:@"me/friends" andParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"name,birthday,picture", @"fields", nil] andResponse:^(id result) {
        friends = [(NSArray *)[result objectForKey:@"data"] mutableCopy];
        [self parseBirthDays];
        responseBlock(friends);
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)fetchAlbumsWithParams:(NSMutableDictionary *)params andResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock{
    [facebook requestWithGraphPath:@"me/albums" andParams:params andResponse:^(id result) {
        NSArray *_albums                = [result objectForKey:@"data"];
        NSURL *_url                     = [NSURL URLWithString:[[[result objectForKey:@"paging"] objectForKey:@"next"] stringByReplacingOccurrencesOfString:@"|" withString:@""]];
        NSMutableDictionary *_params    = (NSMutableDictionary *)[_url queryDictionary];

        if ([_albums count] > 0) {
            responseBlock(_albums);
            if ([[_params objectForKey:@"until"] intValue] != 0)
                [self fetchAlbumsWithParams:_params andResponseBlock:responseBlock andErrorBlock:errorBlock];
        }
        
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)fetchPicturesWithParams:(NSMutableDictionary *)params andAlbumId:(NSString *)anAlbumId andResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock{
    facebook.responseBlock = nil;
    facebook.errorBlock = nil;

    [facebook requestWithGraphPath:[NSString stringWithFormat:@"%@/%@", anAlbumId, @"photos"] andParams:params andResponse:^(id result) {
        NSArray *_photos                = [result objectForKey:@"data"];
        NSURL *_url                     = [NSURL URLWithString:[[[result objectForKey:@"paging"] objectForKey:@"next"] stringByReplacingOccurrencesOfString:@"|" withString:@""]];
        NSMutableDictionary *_params    = (NSMutableDictionary *)[_url queryDictionary];
        
        if ([_photos count] > 0) {
            responseBlock(_photos);
            if ([[_params objectForKey:@"until"] intValue] != 0)
                [self fetchPicturesWithParams:params andAlbumId:anAlbumId andResponseBlock:responseBlock andErrorBlock:errorBlock];
        }

    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)uploadVideo:(NSString *)path andResponseBlock:(void (^)(NSArray *))responseBlock andErrorBlock:(void (^)(NSError *))errorBlock{
    NSString *_url = [NSString stringWithFormat:@"https://graph-video.facebook.com/me/videos?access_token=%@&title=yay&description=test", 
                      [facebook.accessToken stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:_url]];
    [request setFile:@"" forKey:@"file"];
    [request startSynchronous];

    NSLog(@"%@", [request responseString]);
}


#pragma mark -
#pragma mark FBRequestDelegate
// raw response
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
}

// parsed response
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    DLog(@"Facebook Response Success: %@", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    DLog(@"Facebook Response Error: %@", [error localizedDescription]);
}

- (NSString *)accountExpirationDateAsString{
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
    return [dateFormatter stringFromDate:facebook.expirationDate];
}

- (NSDate *)accountExpirationDateFromString:(NSString *)dateAsString{
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
    return [dateFormatter dateFromString:dateAsString];
}

@end
