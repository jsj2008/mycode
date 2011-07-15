//
//  WebServicePost.h
//  BlogApp
//
//  Created by Ayush Goel on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebServicePost : NSObject 
{
    NSURLConnection         *connection;
    NSMutableData           *appData;

}

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *appData;

 -(id) initWithRequest : (NSURL *)url aDict: (NSDictionary*)dataDictionary;

@end