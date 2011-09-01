//
//  MyClass.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/12/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "DataLoader.h"
#import "SBJson.h"

static DataLoader *shared=nil;

@interface DataLoader (private)

@end


@implementation DataLoader

@synthesize occasions;
@synthesize characters;

+ (DataLoader*)shared{
	@synchronized(shared){
		if (!shared) {
			shared = [[DataLoader alloc] init];
			[shared load];
		}
	}
	return shared;
}

- (void)dealloc{
    [occasions release];
    [characters release];
    [super dealloc];
}

- (void)load{
    NSError *error = nil;
    
    NSString *_occasionsPath    = [[NSBundle mainBundle] pathForResource:@"occasions" ofType:@"json"];
    NSString *_occasionsData    = [NSString stringWithContentsOfFile:_occasionsPath encoding:NSASCIIStringEncoding error:&error];
    self.occasions              = [[_occasionsData JSONValue] retain];
    
    NSString *_charactersPath   = [[NSBundle mainBundle] pathForResource:@"characters" ofType:@"json"];
    NSString *_charactersData   = [NSString stringWithContentsOfFile:_charactersPath encoding:NSASCIIStringEncoding error:&error];
    self.characters             = [[_charactersData JSONValue] retain];
}

@end
