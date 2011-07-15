//
//  RawData.h
//  graphTest
//
//  Created by Yogesh Bhople on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RawData : NSObject {
	
	NSMutableArray* weekRatingData;
	int month;

}

@property (nonatomic,retain) NSMutableArray* weekRatingData;
@property (assign) int month;


@end
