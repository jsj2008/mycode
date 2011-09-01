//
//  constants.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#define kFacebookAppId              @"257211760962441"
#define kKeyChainKey				@"acct"
#define kKeyChainIdentifier			@"Password"
#define kKeyChainAccessGroup		@"YOUR_APP_ID_HERE.com.sequence.DisneyMuppets"


#define kMuppetsApiServer                 @"http://api.muppetmail.vinsol.com/v1"
//#define kMuppetsApiServer                   @"http://api.muppetmail.local:8080/v1"
#define kMuppetsApiNewCanvas(count)         [NSString stringWithFormat:@"%@/%@=%d", kMuppetsApiServer,  @"canvas/new/images?assets_count", count]
#define kMuppetsApiNewVideoCanvas           [NSString stringWithFormat:@"%@/%@", kMuppetsApiServer,     @"canvas/new/video"]
#define kMuppetsApiAssetComplete(id)        [NSString stringWithFormat:@"%@/assets/%d/complete", kMuppetsApiServer, id]
#define kMuppetsApiNotificationPath         [NSString stringWithFormat:@"%@/%@", kMuppetsApiServer,     @"alert/today"]

#define kLoginPath                          [NSString stringWithFormat:@"%@/authorizations", kMuppetsApiServer]