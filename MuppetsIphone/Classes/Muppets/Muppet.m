//
//  Muppet.m
//  Muppets
//
//  Created by Achal Aggarwal on 06/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "Muppet.h"
#import "SBJson.h"

@interface Muppet()

@property (nonatomic, retain) NSDate *createdAt;

@end

@implementation Muppet

@synthesize muppetPath;
@synthesize createdAt;
@synthesize name;

@synthesize head;
@synthesize body;
@synthesize eyes;
@synthesize nose;
@synthesize hair;
@synthesize facialhair;
@synthesize shirt;
@synthesize mouth;
@synthesize accessory;

+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr {
    NSFileManager *_fileManager = [[NSFileManager alloc] init];
    BOOL result;
    result = [_fileManager createFileAtPath:path contents:data attributes:attr];
    [_fileManager release];
    return result;
}

+ (BOOL)emptyPath:(NSString *)path {
    NSFileManager *_fileManager = [[NSFileManager alloc] init];
    BOOL result1;
    BOOL result2;
    result1 = [_fileManager removeItemAtPath:path error:NULL];
    
    result2 = [_fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    
    [_fileManager release];
    return result1 && result2;
}

+(void) createDummyMuppet {
    //copy dummy muppet data
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *source = [[NSBundle mainBundle] resourcePath];
    NSString *muppetPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Muppets/01.mmup"];
    
    [fileManager createDirectoryAtPath:muppetPath withIntermediateDirectories:YES attributes:nil error:NULL];
    
    NSError *error;
    if ([fileManager copyItemAtPath:[source stringByAppendingPathComponent:@"muppet.json"] toPath:[muppetPath stringByAppendingPathComponent:@"index.json"] error:&error]) {
        DLog(@"Copied Muppet");
    }
    else
    {
        DLog(@"%@", [error localizedDescription]);
    }
    
    [fileManager release];
}

+(NSArray *) all {
    //Array of all the projects saved on the disk
    NSMutableArray *result = nil;
    //add projects here... alloc init them with the NSData which is retrived from the file manager
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    DLog(@"%@", MUPPETS_PATH);
    
    NSDirectoryEnumerator *muppetEnum = [fileManager enumeratorAtPath:MUPPETS_PATH];
    
    NSString *filePath;
    
    while (filePath = [muppetEnum nextObject]) {
        if ([[filePath pathExtension] isEqualToString:@"json"]) {
            if (result == nil) {
                result = [[[NSMutableArray alloc] init] autorelease];
            }
            
            Muppet *muppet = [[Muppet alloc] initWithData:[fileManager contentsAtPath:[MUPPETS_PATH stringByAppendingPathComponent:filePath]] andPath:filePath];
            [result addObject:muppet];
            [muppet release];
        }
    }
    [fileManager release];
    return result;
}

-(id) initWithData:(NSData *) data andPath:(NSString *) path {
    self = [super init];
    if (self) {
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        id index = [[jsonParser objectWithData:data] retain];
        [jsonParser release];
        
        //self.createdAt = 
        self.muppetPath = [MUPPETS_PATH stringByAppendingPathComponent:[[path pathComponents] objectAtIndex:0]];
        
        NSArray *array = [[NSArray alloc] initWithObjects:@"name", @"head", @"body", @"eyes", @"nose", @"hair", @"facialhair", @"shirt", @"accessory", @"mouth", nil];
        for (NSString *obj in array) {
            [self setValue:[index objectForKey:obj] forKey:obj];
        }
        [array release];
        [index release];
    }
    return self;
}

-(id) initWithPath:(NSString *) path {
    NSString *filePath = [path stringByAppendingPathComponent:@"index.json"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    self = [self initWithData:[fileManager contentsAtPath:[MUPPETS_PATH stringByAppendingPathComponent:filePath]] andPath:path];
    
    [fileManager release];
    return self;
}

-(BOOL) save {
    NSMutableDictionary *_dictionary = [[NSMutableDictionary alloc] init];
    NSArray *array = [[NSArray alloc] initWithObjects:@"name", @"head", @"body", @"eyes", @"nose", @"hair", @"facialhair", @"shirt", @"accessory", @"mouth", nil];
    for (NSString *obj in array) {
        [_dictionary setValue:[self valueForKey:obj] forKey:obj];
    }
    [array release];
    
    [Muppet emptyPath:self.muppetPath];
    NSData *index_data = [[_dictionary JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
    //if this is an older project then save, otherwise, generate a new path for this
    if (self.muppetPath != nil) {
        //delete all files in the project folder before saving
        [Muppet emptyPath:self.muppetPath];
        
        if ([Muppet createFileAtPath:[self.muppetPath stringByAppendingPathComponent:@"index.json"] contents:index_data attributes:nil])
        {
            DLog(@"success!!!");
        }
        else {
            DLog(@"bum bum bummmmmmm");
        }
    }
    [_dictionary release];
    return NO;
}

-(void) dealloc {
    [head release];
    [body release];
    [eyes release];
    [nose release];
    [hair release];
    [facialhair release];
    [shirt release];
    [accessory release];
    
    [muppetPath release];
    [name release];
    [super dealloc];
}

@end
