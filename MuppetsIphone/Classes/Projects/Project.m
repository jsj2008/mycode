//
//  Project.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "Project.h"
#import "SBJson.h"
#import "CanvasObject.h"

@interface Project()

@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSString *projectPath;

@end

@implementation Project

@synthesize name;
@synthesize createdAt;
@synthesize objects;
@synthesize projectPath;
@synthesize thumbnail;
@synthesize preview;

+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr {
    NSFileManager *_fileManager = [[NSFileManager alloc] init];
    BOOL result;
    result = [_fileManager createFileAtPath:path contents:data attributes:attr];
    [_fileManager release];
    return result;
}

+ (BOOL)removeItemAtPath:(NSString *)path {
    NSFileManager *_fileManager = [[NSFileManager alloc] init];
    NSError *error = nil;
    BOOL result = [_fileManager removeItemAtPath:path error:&error];
    if (error) {
        DLog(@"%@", [error localizedDescription]);
    }
    [_fileManager release];
    return result;
}

+ (BOOL)emptyPath:(NSString *)path {
    NSFileManager *_fileManager = [[NSFileManager alloc] init];
    BOOL result1;
    BOOL result2;
    result1 = [Project removeItemAtPath:path];
    
    result2 = [_fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    
    [_fileManager release];
    return result1 && result2;
}

+(void) makeDummyProject {
    //copy dummy project data
    NSFileManager *fileManager  = [[NSFileManager alloc] init];
    NSString *source            = [[NSBundle mainBundle] resourcePath];
    
    for (int i=1; i<=14; i++) {
        NSString *projectPath   = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Projects/%d.mproj", i]];
        NSArray *array          = [[NSArray alloc] initWithObjects:@"grass-background.jpg", @"index.json", @"__kermit.png", @"__animal.png", @"__misspiggy.png", @"thumbnail.png", @"preview.png", nil];

        [fileManager createDirectoryAtPath:projectPath withIntermediateDirectories:YES attributes:nil error:NULL];

        for (NSString *obj in array) {
            NSError *error;
            if ([fileManager copyItemAtPath:[source stringByAppendingPathComponent:obj] toPath:[projectPath stringByAppendingPathComponent:obj] error:&error]) {
                // DLog(@"Copied: %@ to Project: %@", obj, projectPath);
            }
            else
            {
                // DLog(@"%@", [error localizedDescription]);
            }
        }
        [array release];
    }
    
    [fileManager release];
}

+(NSArray *) all {
    //Array of all the projects saved on the disk
    NSMutableArray *result = nil;
    //add projects here... alloc init them with the NSData which is retrived from the file manager
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];

    DLog(@"%@", PROJECTS_PATH);
    
    NSDirectoryEnumerator *projectEnum = [fileManager enumeratorAtPath:PROJECTS_PATH];
    
    NSString *filePath;
    
    while (filePath = [projectEnum nextObject]) {
        if ([[filePath pathExtension] isEqualToString:@"json"]) {
            if (result == nil) {
                result = [[[NSMutableArray alloc] init] autorelease];
            }
            
            Project *project = [[Project alloc] initWithData:[fileManager contentsAtPath:[PROJECTS_PATH stringByAppendingPathComponent:filePath]] andPath:filePath];
            [result addObject:project];
            [project release];
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
        self.name = [index objectForKey:@"name"];
        //self.createdAt = 
        self.projectPath = [PROJECTS_PATH stringByAppendingPathComponent:[[path pathComponents] objectAtIndex:0]];
        
        if (self.objects) {
            [self.objects release], self.objects = nil;
        }
        
        self.objects = [[NSMutableArray alloc] init];
        
        for (id obj in [index objectForKey:@"objects"]) {
            [self.objects addObject:[CanvasObject objectWithDictionary:obj andPath:self.projectPath]];
        }
        //Look into this later
        /*
        [self.objects sortWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2){
            if ([obj1 valueForKey:@"zindex"] < [obj2 valueForKey:@"zindex"]) {
                return NSOrderedAscending;
            }
            if ([obj1 valueForKey:@"zindex"] > [obj2 valueForKey:@"zindex"]) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
         */

        [index release];
    }
    return self;
}

-(BOOL) saveCanvas:(UIView *) canvas {
    
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    
    //Add Project Name
    [json setObject:name forKey:@"name"];
    
    //Add Canvas Objects in an array
    NSMutableArray *_objects = [[NSMutableArray alloc] init];
    for (CanvasObject *obj in [canvas subviews]) {
        
        NSMutableDictionary *temp = [[obj serialize] retain];
        
        if (IS_NULL([temp objectForKey:@"z-index"])) {
            [temp setObject:[NSNumber numberWithInt:[[canvas subviews] indexOfObject:obj]] forKey:@"z-index"];
        }
        [_objects addObject:temp];
        [temp release];
    }
    
    //Add obejcts array to the project
    [json setObject:_objects forKey:@"objects"];
    [_objects release];

    
    //get all files associated with the objects
    NSMutableArray *files = [[NSMutableArray alloc] init];
    for (CanvasObject *obj in [canvas subviews]) {
        NSDictionary *_file = [[obj file] retain];
        if (!IS_NULL(_file)) {
            [files addObject:_file];
        }
    }
    
    //delete all files in the project folder before saving
    [Project emptyPath:self.projectPath];
    
    //save all files associated with the project before writting the Index file
    for (NSDictionary *file in files) {
        if (!IS_NULL(file)) {
            [Project createFileAtPath:[self.projectPath stringByAppendingPathComponent:[[file allKeys] objectAtIndex:0]] 
                             contents:[[file allValues] objectAtIndex:0] attributes:nil];
        }
    }
    [files release];
    
    
    //Create NSData for the Project Index.JSON file
    NSData *index_data = [[json JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
    
    //if this is an older project then save, otherwise, generate a new path for this
    if (self.projectPath != nil) {
        if ([Project createFileAtPath:[self.projectPath stringByAppendingPathComponent:@"index.json"] contents:index_data attributes:nil])
        {
            DLog(@"success saving index file for project");
        }
        else {
            DLog(@"bum bum bummmmmmm");
        }
    }
    [json release];
    
    //Save Previews
    UIImage *_capture = [canvas captureImage];
    [self setPreviews:_capture];
    
    return NO;
}


- (NSString *)pathForResource:(NSString *)resourceName{
    NSString *_path = [NSString stringWithFormat:@"%@/%@", self.projectPath, resourceName];
    return _path;
}

- (NSString *)newPathForResource:(NSString *)resourceName{
    NSString *_path = [self pathForResource:resourceName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:_path]) {
        NSError* error;
        if ([fileManager removeItemAtPath:_path error:&error] == NO) {
            DLog(@"Could not delete file at path:  %@", _path);
        }
    }
    return _path;
}

- (UIImage *)thumbnail{
    if (thumbnail) return thumbnail;

    NSString *_path = [self pathForResource:@"thumbnail.png"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:_path]) {
        thumbnail = [[UIImage imageWithData:[NSData dataWithContentsOfFile:_path]] retain];
    }

    return thumbnail;
}

- (UIImage *)preview{
    if (preview) return preview;
    
    NSString *_path = [self pathForResource:@"preview.png"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:_path]) {
        thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfFile:_path]];
    }
    
    return preview;
}

- (void)setPreviews:(UIImage *)anImage{
    
    //if (self.thumbnail) {
        //[self.thumbnail release], self.thumbnail = nil;
    //}
    
    thumbnail = [[anImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(100.0f, 100.0f) interpolationQuality:kCGInterpolationDefault] retain];
    self.preview   = anImage;

    NSString *_thumbnailPath = [self newPathForResource:@"thumbnail.png"];
    NSString *_previewPath   = [self newPathForResource:@"preview.png"];

    [UIImagePNGRepresentation(anImage) writeToFile:_previewPath atomically:YES];
    [UIImagePNGRepresentation(thumbnail) writeToFile:_thumbnailPath atomically:YES];
}

- (id)objectForKey:(NSString *)key{
    return @"thumb.png";
}

- (BOOL)remove{
    return [Project removeItemAtPath:self.projectPath];
}

- (BOOL)update {
    BOOL result = NO;
    
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    
    //Add Project Name
    [json setObject:name forKey:@"name"];
    
    //Add Canvas Objects in an array
    NSMutableArray *_objects = [[NSMutableArray alloc] init];
    for (CanvasObject *obj in objects) {
        
        NSMutableDictionary *temp = [[obj serialize] retain];
        
        if (IS_NULL([temp objectForKey:@"z-index"])) {
            [temp setObject:[NSNumber numberWithInt:[obj zindex]] forKey:@"z-index"];
        }
        [_objects addObject:temp];
        [temp release];
    }
    
    //Add obejcts array to the project
    [json setObject:_objects forKey:@"objects"];
    [_objects release];
    
    
    //Create NSData for the Project Index.JSON file
    NSData *index_data = [[json JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
    
    //if this is an older project then save, otherwise, generate a new path for this
    if (self.projectPath != nil) {
        [Project removeItemAtPath:[self.projectPath stringByAppendingPathComponent:@"index.json"]];
        result = [Project createFileAtPath:[self.projectPath stringByAppendingPathComponent:@"index.json"] contents:index_data attributes:nil];
        if (result)
        {
            DLog(@"success saving index file for project");
        }
        else {
            DLog(@"bum bum bummmmmmm");
        }
    }
     
    [json release];
    return result;
}

- (void) dealloc {
    //[thumbnail release], thumbnail = nil;
    [preview release];
    [name release];
    [createdAt release];
    [objects release];
    [projectPath release];
    [super dealloc];
}

@end
