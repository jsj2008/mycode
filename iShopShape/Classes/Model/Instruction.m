//
//  Instruction.m
//  iShopShape
//
//  Created by Santosh B on 17/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "Instruction.h"


@implementation Instruction
@synthesize instId,isExecuted, title,description, startDate,endDate,instructionImage,styleProductArray;
-(void)dealloc
{
	NSLog(@"Instruction ------------- Release");
	[instId release];
	[title release];
	[description release];
	[startDate release];
	[endDate release];
	[instructionImage release];
	[styleProductArray release];
	[super dealloc];
}
@end
