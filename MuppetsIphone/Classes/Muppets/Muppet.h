//
//  Muppet.h
//  Muppets
//
//  Created by Achal Aggarwal on 06/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MUPPETS_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Muppets"]

@interface Muppet : NSObject {
    
}

@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSString *head;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *eyes;
@property (nonatomic, retain) NSString *nose;
@property (nonatomic, retain) NSString *hair;
@property (nonatomic, retain) NSString *facialhair;
@property (nonatomic, retain) NSString *shirt;
@property (nonatomic, retain) NSString *mouth;
@property (nonatomic, retain) NSString *accessory;

@property (nonatomic, retain) NSString *muppetPath;

+(void) createDummyMuppet;

+(NSArray *) all;

-(id) initWithData:(NSData *) data andPath:(NSString *) path;
-(id) initWithPath:(NSString *) path;
-(BOOL) save;

+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr;
+ (BOOL)emptyPath:(NSString *)path;

@end
