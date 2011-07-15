//
//  StoreImageObj.h
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoreImageObj : NSObject {
	NSString *imageName;
	NSDate *imageDate;
	
}

@property(nonatomic, retain) NSString *imageName;
@property(nonatomic, retain) NSDate *imageDate;

-(id)initWithImageName:(NSString *)name onDate:(NSDate *)imgdate;
@end
