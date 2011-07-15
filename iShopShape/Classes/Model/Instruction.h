//
//  Instruction.h
//  iShopShape
//
//  Created by Santosh B on 17/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Instruction : NSObject {
	NSString *instId;
	NSString *title;
	NSString *description;
	NSString *startDate;
	NSString *endDate;
	NSString *instructionImage;
	BOOL isExecuted;
	NSArray *styleProductArray;
}
@property(nonatomic,retain) NSString *instId;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *startDate;
@property(nonatomic,retain) NSString *endDate;
@property(nonatomic,retain) NSArray *styleProductArray;
@property(nonatomic,retain) NSString *instructionImage;
@property(nonatomic) BOOL isExecuted;
@end
