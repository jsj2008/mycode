//
//  ConfigReader.m
//  NCPiPhone
//
//  Created by Santosh B on 31/05/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "ConfigReader.h"

@implementation ConfigReader
@synthesize LoggerEnabled, LoggerLevel, LoggerTarget, LoggerType;

/*
*	@functionName	: ReadLogConfigFile
*	@parameters		: void
*	@return			: void
*	@description	: This method read the LoggerConfig.plist for logger settings.
*/
#define LOGGER_CONFIG_FILE_NAME  @""
- (void) readConfigFile
{
	
	NSDictionary *settingsValues = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:LOGGER_CONFIG_FILE_NAME ofType:nil]];
	
	if(settingsValues)
	{
		LoggerEnabled	= [[NSNumber alloc] initWithInt:[[settingsValues valueForKey:@"LoggerEnabled"] intValue]];
		LoggerLevel		= [[NSNumber alloc] initWithInt:[[settingsValues valueForKey:@"LoggerLevel"] intValue]];
		LoggerTarget	= [[NSNumber alloc] initWithInt:[[settingsValues valueForKey:@"LoggerTarget"] intValue]];
		LoggerType		= [[NSNumber alloc] initWithInt:[[settingsValues valueForKey:@"LoggerType"] intValue]];
		
		[settingsValues release];
		settingsValues = nil;
	}
	
}

@end
