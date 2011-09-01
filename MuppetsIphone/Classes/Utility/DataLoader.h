//
//  MyClass.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/12/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataLoader : NSObject {
    NSArray *occasions;
    NSArray *characters;
}

@property (nonatomic, retain) NSArray *occasions;
@property (nonatomic, retain) NSArray *characters;

+ (DataLoader*)shared;
- (void)load;

@end
