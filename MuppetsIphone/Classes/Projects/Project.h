//
//  Project.h
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROJECTS_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Projects"]

@interface Project : NSObject {
}

@property (nonatomic, retain) NSString *name;
//Stores all the Canvas View Objects which can be easily serialized
@property (nonatomic, retain) NSMutableArray *objects;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) UIImage *preview;

+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr;
+ (BOOL)emptyPath:(NSString *)path;
+ (BOOL)removeItemAtPath:(NSString *)path;

+(NSArray *) all;

-(id) initWithData:(NSData *) data andPath:(NSString *) path;
-(BOOL) saveCanvas:(UIView *) canvas;

- (void)setPreviews:(UIImage *)anImage;
- (NSString *)pathForResource:(NSString *)resourceName;
- (NSString *)newPathForResource:(NSString *)resourceName;

+(void) makeDummyProject;
- (BOOL)remove;
- (BOOL)update;

@end
