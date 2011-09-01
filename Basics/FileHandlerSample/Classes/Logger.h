//
//  Logger.h
//  NCPiPhone
//
//  Created by Santosh B on 28/05/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LOG_FILENAME @"NCPLog.log"

enum LOGGER_TARGET {TO_CONSOLE = 1, TO_FILE = 2, TO_DATABASE = 3};

enum LOGGER_TYPE {BASIC_LOG = 1, DETAILED_LOG = 2};

enum LOGGER_LEVEL {DEBUG =1 , PERFORMANCE = 2, INFORMATION = 3, WARNING = 4, ERROR = 5};

@interface Logger : NSObject {

}

/**
 *	@functionName	: Init
 *	@parameters		: void
 *	@return			: self
 *	@description	: Initialize the Logger.
 */
+ (id) init;

/**
 *	@functionName	: Close
 *	@parameters		: void
 *	@return			: int
 *	@description	: Stop the Logger.
 */
+ (int) close;

/**
 *	@functionName	: WriteMessage
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *	@return			: int
 *	@description	: This method log the messages based to decided loging target.
 */
+ (int) writeMessage:(int) logLevel message:(NSString*) message;

/**
 *	@functionName	: WriteMessage
 *	@parameters		: (int) logLevel - message log level like Information, Debug, Performance, Warning, Error.
 *					  (NSString*) message - message to log.
 *					  (NSException *)exception - exception if any.
 *	@return			: int
 *	@description	: This method log the messages based to decided loging target.
 */
+ (int) writeMessage:(int) logLevel message:(NSString*) message exception: (NSException *)exception;
@end
