//
//  ConfigReader.h
//  NCPiPhone
//
//  Created by Santosh B on 31/05/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConfigReader : NSObject {
	NSNumber* LoggerEnabled;
	NSNumber* LoggerTarget;
	NSNumber* LoggerLevel;
	NSNumber* LoggerType;
}
@property (readonly, assign) NSNumber* LoggerEnabled;
@property (readonly, assign) NSNumber* LoggerTarget;
@property (readonly, assign) NSNumber* LoggerLevel;
@property (readonly, assign) NSNumber* LoggerType;

/**
 *	@functionName	: ReadLogConfigFile
 *	@parameters		: void
 *	@return			: void
 *	@description	: This method read the LoggerConfig.xml for logger settings.
 */
- (void) readConfigFile;
@end
