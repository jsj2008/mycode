//
//  ModelTip.h
//  xml
//
//  Created by Ayush on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelTip : NSObject 
{
	NSString *countryName;
	NSString *category;
	int minVal;
	int maxVal;
	int defVal;

}

@property (nonatomic,retain) NSString *countryName;
@property (nonatomic,retain) NSString *category;
@property (nonatomic,) int minVal;
@property (nonatomic,) int maxVal;
@property (nonatomic,) int defVal;


@end
