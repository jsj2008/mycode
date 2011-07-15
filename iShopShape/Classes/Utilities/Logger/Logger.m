//
//  Logger.m
//  NCPiPhone
//
//  Created by Santosh B on 28/05/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "Logger.h"
#import "ConfigReader.h"

ConfigReader *configReader = nil;
static NSString *logFilePath = nil;
static NSString *logPath = nil;

@interface Logger (PrivateMethods)

/**
 *	@functionName	: WriteMessageToFile
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages to file.
 */
+ (void) writeMessageToFile:(int) logLevel message:(NSString*) message;

/**
 *	@functionName	: WriteMessageToFile
 *	@parameters		: (int) logLevel	- message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *					  (NSException*) exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages with exception to file.
 */
+ (void) writeMessageToFile:(int) logLevel message:(NSString*) message exception: (NSException *)exception;

/**
 *	@functionName	: WriteMessageToConsole
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString *) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages to console.
 */
+ (void) writeMessageToConsole:(int) logLevel message:(NSString*) message;

/**
 *	@functionName	: WriteMessageToConsole
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString *) message - message to log.
 *					  (NSException*) exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages with exception to console.
 */
+ (void) writeMessageToConsole:(int) logLevel message:(NSString*) message exception: (NSException *)exception;

/**
 *	@functionName	: WriteMessageToDataBase
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages to database.
 */
+ (void) writeMessageToDataBase:(int) logLevel message:(NSString*) message;

/**
 *	@functionName	: WriteMessageToDataBase
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *					  (NSException*) exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages with exception to database.
 */
+ (void) writeMessageToDataBase:(int) logLevel message:(NSString*) message exception: (NSException *)exception;

/**
 *	@functionName	: GetLogFilePath
 *	@parameters		: void
 *	@return			: NSString - Full log file path
 *	@description	: This method return log file path.
 *					If file is not present it will create that file in applicaiton document directory.
 *					Also will create the directory structure if missing in application document directory.
 */
+ (NSString *) getLogFilePath;

/**
 *	@functionName	: SetPath
 *	@parameters		: (NSString*) path - log file path.
 *	@return			: void
 *	@description	: This method set the path for the file in which logging should be done.
 */
+ (void) setPath : (NSString *)path;

/**
 *	@functionName	: GetMessageKind
 *	@parameters		: (NSString *) messageKind - message log level like Information, Debug, Performance, Warning, Error, Unknown.
 *	@return			: NSString - Message log level like Debug, Performance, Information, Warning, Error, Unknown.
 *	@description	: This method will create the message kind string based on the provided message level for log.
 */
+ (NSString *) getMessageKind : (int)messagekind;

@end

#pragma mark -
#pragma mark LOGGER PRIVATE METHODS

@implementation Logger (PrivateMethods)

/**
 *	@functionName	: WriteMessageToFile
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages to file.
 */
+ (void) writeMessageToFile:(int) logLevel message:(NSString*) message
{
	
	@try 
	{
		//check the LoggerLevel configuration allow the log the
		//current log level or not. If LoggerLevel is set to INFORMATION
		//then logger will only log the Debug, Performance and Information 
		//log messages and will not log the Warning and error
		if([configReader.LoggerLevel intValue] <= logLevel)
		{
			//get the message type like Info, Debug etc. based on the provided logLevel
			NSString *messageType = [Logger getMessageKind:logLevel];
			
			//check is log file path is set
			if(!logFilePath)
			{
				//set the log file path to default
				[Logger getLogFilePath];
			}
			NSFileHandle *fileHandler = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
			
			if(!fileHandler)
			{
				return;
			}
			
			[fileHandler seekToEndOfFile];
			
			NSDateFormatter *format = [[NSDateFormatter alloc] init];
			[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
			[format setDateFormat:@"dd MMM yyyy"];
			
			NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
			[timeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
			[timeFormat setDateFormat:@"HH:mm:ss:ms"];
			
			NSDate *now = [[NSDate alloc] init];
			
			NSString *theDate = [format stringFromDate:now];
			
			NSString *theTime = [timeFormat stringFromDate:now];
			
			NSString *completeMessage = [[NSString alloc] initWithFormat:@"%@~%@ - %@~%@\n",[messageType UTF8String], [theDate UTF8String], [theTime UTF8String],[message UTF8String]];		
			NSData *data = [completeMessage dataUsingEncoding:NSASCIIStringEncoding];
			
			[fileHandler writeData:data];
			
			[fileHandler closeFile];
			
		}
		
	}
	@catch (NSException * e) 
	{
		NSLog(@"Unable to log the message - %@", [e description]);
	}
}

/**
 *	@functionName	: WriteMessageToFile
 *	@parameters		: (int) logLevel	- message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *					  (NSException*) exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages with exception to file.
 */
+ (void) writeMessageToFile:(int) logLevel message:(NSString*) message exception: (NSException *)exception
{	
	
	@try 
	{
		//check the LoggerLevel configuration allow the log the
		//current log level or not. If LoggerLevel is set to INFORMATION
		//then logger will only log the Debug, Performance and Information 
		//log messages and will not log the Warning and error
		if([configReader.LoggerLevel intValue] <= logLevel)
		{
			//get the message type like Info, Debug etc. based on the provided logLevel
			NSString *messageType = [Logger getMessageKind:logLevel];
			
			//check is log file path is set
			if(!logFilePath)
			{
				//set the log file path to default
				[Logger getLogFilePath];
			}
			
			NSFileHandle *fileHandler = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
			if(!fileHandler)
			{
				return;
			}
			
			[fileHandler seekToEndOfFile];
			
			NSDateFormatter *format = [[NSDateFormatter alloc] init];
			[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
			[format setDateFormat:@"dd MMM yyyy"];
			
			NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
			[timeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
			[timeFormat setDateFormat:@"HH:mm:ss:ms"];
			
			NSDate *now = [[NSDate alloc] init];
			
			NSString *theDate = [format stringFromDate:now];
			
			NSString *theTime = [timeFormat stringFromDate:now];
			
			NSString *completeMessage = [[NSString alloc] initWithFormat:@"%@~%@ - %@~%@~%@\n",[messageType UTF8String], [theDate UTF8String], [theTime UTF8String],[message UTF8String], [[exception description] UTF8String]];		
			NSData *data = [completeMessage dataUsingEncoding:NSASCIIStringEncoding];
			
			[fileHandler writeData:data];
			
			[fileHandler closeFile];
			
		}
	}
	@catch (NSException * e) 
	{
		NSLog(@"Unable to log the message - %@", [e description]);
	}
}

#pragma mark -
/**
 *	@functionName	: WriteMessageToConsole
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString *) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages to console.
 */
+ (void) writeMessageToConsole:(int) logLevel message:(NSString*) message
{
	//check the LoggerLevel configuration allow the log the
	//current log level or not. If LoggerLevel is set to INFORMATION
	//then logger will only log the Debug, Performance and Information 
	//log messages and will not log the Warning and error
	if([configReader.LoggerLevel intValue] <= logLevel)
	{
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		[format setDateFormat:@"dd MMM yyyy"];
		
		NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
		[timeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		[timeFormat setDateFormat:@"HH:mm:ss:ms"];
		
		NSDate *now = [[NSDate alloc] init];
		
		NSString *theDate = [format stringFromDate:now];
		
		NSString *theTime = [timeFormat stringFromDate:now];
		
		
		NSString *messageType = [self getMessageKind:logLevel];
		NSLog(@"[ %@ ] ~[ %@ - %@ ] ~ %@", messageType, theDate, theTime, message);
		[format release];
		format = nil;
		
		[now release];
		now = nil;
		
		[timeFormat release];
		timeFormat = nil;
	}
}

/**
 *	@functionName	: WriteMessageToConsole
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString *) message - message to log.
 *					  (NSException*) exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages with exception to console.
 */
+ (void) writeMessageToConsole:(int) logLevel message:(NSString*) message exception: (NSException *)exception
{	
	//check the LoggerLevel configuration allow the log the
	//current log level or not. If LoggerLevel is set to INFORMATION
	//then logger will only log the Debug, Performance and Information 
	//log messages and will not log the Warning and error
	if([configReader.LoggerLevel intValue] <= logLevel)
	{		
		NSDateFormatter *format = [[NSDateFormatter alloc] init];
		[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		[format setDateFormat:@"dd MMM yyyy"];
		
		NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
		[timeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		[timeFormat setDateFormat:@"HH:mm:ss:ms"];
		
		
		NSDate *now = [[NSDate alloc] init];
		
		NSString *theDate = [format stringFromDate:now];
		
		NSString *theTime = [timeFormat stringFromDate:now];
		
		NSString *messageType = [self getMessageKind:logLevel];
		NSLog(@"[ %@ ] ~ [ %@ - %@ ] ~ [ %@ ] ~ [ %@ ]", messageType, theDate, theTime, message, [exception description]);
		
		[format release];
		format = nil;
		
		[timeFormat release];
		timeFormat = nil;
		
		[now release];
		now = nil;
	}
}

#pragma mark -

/**
 *	@functionName	: WriteMessageToDataBase
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages to database.
 */
+ (void) writeMessageToDataBase:(int) logLevel message:(NSString*) message
{
	NSLog(@"Message : WriteMessageToDataBase");
}

/**
 *	@functionName	: WriteMessageToDataBase
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *					  (NSException*) exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages with exception to database.
 */
+ (void) writeMessageToDataBase:(int) logLevel message:(NSString*) message exception: (NSException *)exception
{
	NSLog(@"Message : WriteMessageToDataBase with exception");
}

#pragma mark -

/**
 *	@functionName	: GetMessageKind
 *	@parameters		: (NSString *) messageKind - message log level like Information, Debug, Performance, Warning, Error, Unknown.
 *	@return			: NSString - Message log level like Debug, Performance, Information, Warning, Error, Unknown.
 *	@description	: This method will create the message kind string based on the provided message level for log.
 */
+ (NSString *) getMessageKind : (int)messagekind
{
	NSString *messageType = [NSString stringWithString:@""];
	//Based on the passed messagekind create the messageType string
	switch (messagekind) 
	{
		case DEBUG:
			messageType = [messageType stringByAppendingFormat:@"D"];
			break;
			
		case PERFORMANCE:
			messageType = [messageType stringByAppendingFormat:@"P"];
			break;
			
		case INFORMATION:
			messageType = [messageType stringByAppendingFormat:@"I"];
			break;
		case WARNING:
			messageType = [messageType stringByAppendingFormat:@"W"];
			break;
		case ERROR:
			messageType = [messageType stringByAppendingFormat:@"E"];
			break;
		default:
			messageType = [messageType stringByAppendingFormat:@"U"];
			break;
	}
	
	return messageType;
}


#pragma mark -

/**
 *	@functionName	: GetLogFilePath
 *	@parameters		: void
 *	@return			: NSString - Full log file path
 *	@description	: This method return log file path.
 *					If file is not present it will create that file in applicaiton document directory.
 *					Also will create the directory structure if missing in application document directory.
 */
+ (NSString *) getLogFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	//if no log file path is found set it to default
	if(!logPath)
	{
		//if no log file path is found set it to default
		[self setPath:@""];
	}
		
	NSFileManager *manager = [NSFileManager defaultManager];
	

	NSString *logFilePath = [documentsDirectoryPath stringByAppendingPathComponent:[logPath lastPathComponent]];
	
	//check - log file exist
	if(![manager fileExistsAtPath:logFilePath])
	{
		//if not create a new log file
		[manager createFileAtPath:logFilePath contents:nil attributes:nil];
	}
	//set the log file path to provided file structure
	if(!logFilePath)
	{
		logFilePath = [[NSString alloc] initWithString:logFilePath] ;
	}
	return nil;
}

#pragma mark -
/**
 *	@functionName	: SetPath
 *	@parameters		: (NSString*) path - log file path.
 *	@return			: void
 *	@description	: This method set the path for the file in which logging should be done.
 */
+ (void) setPath : (NSString *)path
{
	//check is path already set
	if(!logPath)
	{
		logPath = [[NSString alloc] initWithString:LOG_FILENAME];
		//check path is nil 
		if(path && ![path isEqualToString:@""])
		{
			logPath = [NSString stringWithString:path];
		}
	}
	else
	{
		NSString *message = [[NSString alloc] initWithFormat:@"[ Logger ] - Log file path is already set to = %@", logPath];
		[Logger writeMessage:INFORMATION message:message];
		[message release];
		message = nil;
	}
}
@end

@implementation Logger

/**
 *	@functionName	: Init
 *	@parameters		: void
 *	@return			: int
 *	@description	: Initialize the Logger.
 */
+ (id) init
{
	if(!configReader)
	{
		configReader = [ConfigReader alloc];
		
		[configReader readConfigFile];
	}
	return self;
}

/**
 *	@functionName	: Close
 *	@parameters		: void
 *	@return			: int
 *	@description	: Stop the Logger.
 */
+ (int) close
{
	if(configReader)
	{
		[configReader release];
		configReader = nil;
	}
	return 1;
}

/**
 *	@functionName	: WriteMessage
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages based to decided loging target.
 */
+ (int) writeMessage:(int) logLevel message:(NSString*) message
{
	if(!configReader)
	{
		return 0;
	}
	if([configReader.LoggerEnabled intValue] && ![message isEqual:[NSNull null]])
	{
		switch ([configReader.LoggerTarget intValue])
		{
			case TO_CONSOLE:
				[Logger writeMessageToConsole:logLevel message:message];
				break;
			case TO_FILE:
				[Logger writeMessageToFile:logLevel message:message];
				break;				
			default:
				[Logger writeMessageToFile:logLevel message:message];
				[Logger writeMessageToConsole:logLevel message:message];
		}
	}
	return 1;
}

/**
 *	@functionName	: WriteMessage
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *					  (NSException *)exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages based to decided loging target.
 */
+ (int) writeMessage:(int) logLevel message:(NSString*) message exception: (NSException *)exception
{
	if(!configReader)
	{
		return 0;
	}
	if([configReader.LoggerEnabled intValue] && ![message isEqual:[NSNull null]])
	{
		switch ([configReader.LoggerTarget intValue])
		{
			case TO_CONSOLE:
				[Logger writeMessageToConsole:logLevel message:message exception:exception];
				break;
			case TO_FILE:
				[Logger writeMessageToFile:logLevel message:message exception:exception];
				break;
				
			case TO_DATABASE:
				[Logger writeMessageToDataBase:logLevel message:message exception:exception];
				break;	
			default:
				[Logger writeMessageToConsole:logLevel message:message exception:exception];
		}
	}
	return 1;
}
@end
