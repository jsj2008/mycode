//
//  DatabaseHandler.m
//  iShopShape
//
//  Created by Santosh B on 03/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "DatabaseHandler.h"
#import "Logger.h"
#import "Notification.h"
#import "Product.h"
#import "StoreImageObj.h"
#import "NotificationStatus.h"

static DatabaseHandler *sharedInstance;
NSString *databaseName = @"iShopShape.sql";
NSString *databasePath;

@implementation DatabaseHandler

+ (void) releaseIt
{
	sharedInstance = nil;
}
+ (id) sharedInstance 
{
	if(!sharedInstance)
	{
		sharedInstance = [[DatabaseHandler alloc] init];
		
		//m=[[Message alloc]init];
		//databaseName = [[NSString alloc] initWithString:@"IShopShape.sql"];
		
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		
		databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
		
		if(![sharedInstance checkDatabase])
		{
			[sharedInstance createDatabase];
			//[sharedInstance createTable];
		}
		//[self deletefromDatabase];
	}
	return sharedInstance;
}

#pragma mark -
#pragma mark CREATE TABLES
#pragma mark -
- (void) createPendingAPNSNotificationTable : (sqlite3 *) database
{
	
	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS pending( guid varchar ,category integer)";
	
	char *errorMsg = nil;
	
	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"pendingAPNSNotificationTable ----------- Created Successfully"];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
	else 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
}


- (void) createInstructionsTable : (sqlite3 *) database
{
	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS instructions( guid varchar ,name VARCHAR(50),startdate VARCHAR(50),enddate VARCHAR(50),imageurl VARCHAR(70),status integer,description VARCHAR)";
	char *errorMsg = nil;
	
	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"instructionTable ----------- Created Successfully"];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
	else 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
}

- (void) createStyleTable : (sqlite3 *) database
{
	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS style(guid varchar ,styleid varchar,name VARCHAR(50),quantity INTEGER,imageurl VARCHAR(70),hotspotnumber INTEGER,posx INTEGER,posy INTEGER)";
	char *errorMsg = nil;
	
	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"styleTable ----------- Created Successfully"];
		[Logger writeMessage:DEBUG message:message];
		[message release];
		
	}
	else 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
}

- (void) createMessageStreamTable : (sqlite3 *) database
{
	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS message( guid varchar ,text VARCHAR(1000),imageurl VARCHAR(100),position integer,startdate VARCHAR(50),current_timestamp)";
	char *errorMsg = nil;
	
	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"notificationTable ----------- Created Successfully"];
		[Logger writeMessage:DEBUG message:message];
		[message release];
		
	}
	else 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
}

-(void) createUnViewedNotificationTable : (sqlite3 *)database
{
	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS notifications( guid varchar,status integer,primary key(guid))";
	char *errorMsg = nil;
	
	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"notificationTable ----------- Created Successfully"];
		[Logger writeMessage:DEBUG message:message];
		[message release];
		
	}
	else 
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
}

-(void) createTable 
{	
	sqlite3 *database = nil;
	
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{

		[self createPendingAPNSNotificationTable:database];
		
		[self createInstructionsTable:database];
		
		[self createStyleTable:database];
		
		[self createMessageStreamTable:database];
		
		[self createUnViewedNotificationTable:database];
	}
	
	sqlite3_close(database);
	
}

#pragma mark -
#pragma mark DATABASE SETUP
#pragma mark -
- (void) createDatabase
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
		
	NSError *error = nil;
	
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:&error];
	
	if(error)
	{
		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, [error description]];
		[Logger writeMessage:DEBUG message:message];
		[message release];
	}
}

-(BOOL) checkDatabase
{
	BOOL success;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:databasePath];
	
	return success;
}

#pragma mark -
#pragma mark INSERT QUERY HANDLER
#pragma mark -
- (void) insertPendingNotification:(NSString *)guid category:(int)category
{
	sqlite3 *database = nil;
	@try 
	{
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
		{
			
			const char *sqlStatement = "insert into pending values(?,?)";
			
			sqlite3_stmt *compiledStatement;
			NSString  *categoryString= [[NSNumber numberWithInt:category] stringValue];
			const char* lcategory= (const char *) [categoryString UTF8String];
			
			const char* lguid = (const char *) [guid UTF8String];
			
			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
				
				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
				
				sqlite3_bind_text(compiledStatement, 2,lcategory, -1, SQLITE_TRANSIENT);
				
			}
			
			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			else 
			{
				NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
			}
			
			sqlite3_finalize(compiledStatement);
		}
		
		sqlite3_close(database);
	}
	@catch (NSException * e) 
	{
		NSLog(@"insertPendingNotification Exception ------------------- %@", [e description]);
		sqlite3_close(database);
	}
}

//-(void) insertMessageStream:(Notification *)message
//{
//	@synchronized(sharedInstance)
//	{
//	sqlite3 *database = nil;
//	@try 
//	{
//		
//		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			
//			const char *sqlStatement = "insert into message values(?, ?,?,?, ?)";
//			
//			sqlite3_stmt *compiledStatement;
//			const char* lguid= (const char *) [message.notificationId UTF8String];
//			const char* ltext = (const char *) [message.notificationTitle UTF8String];
//			const char* limage = (const char *) [message.notificationImage UTF8String];
//			NSString  *lposition= [[NSNumber numberWithInt:message.position] stringValue];
//			const char* lpos=(const char *) [lposition UTF8String];
//			NSDate *today = [NSDate date];
//	
//			NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
//			[dateFormat setDateFormat:@"yyyy-MM-dd"];
//			NSString *dateString = [dateFormat stringFromDate:today];
//			NSLog(@"datestring =======================================================================%@",dateString);
//			const char* date  = (const char *) [dateString UTF8String];
//			//const char* time = "current_timestamp";
//			//NSLog(@"while inserting id = %s text = %s  image name = %s",instruction,text,image);
//			
//			
//			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
//				
//				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
//				
//				sqlite3_bind_text(compiledStatement, 2,ltext , -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 3,limage, -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 4,lpos, -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 5,date , -1, SQLITE_TRANSIENT);
//				
//				//sqlite3_bind_text(compiledStatement, 6,time , -1, SQLITE_TRANSIENT);
//				
//			}
//			
//			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
//				
//				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//				[Logger writeMessage:DEBUG message:message];
//				[message release];
//				
//			} 
//			else {
//				
//				NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
//				
//			}
//			
//			sqlite3_finalize(compiledStatement);
//		}
//		
//		sqlite3_close(database);
//	}
//	@catch (NSException * e) {
//		NSLog(@"InsertMessageStream Exception ------------------- %@", [e description]);
//		sqlite3_close(database);
//	}
//	}
//	
//}

-(void) insertMessageStream:(Notification *)message
{
	sqlite3 *database = nil;
	@try 
	{
		sqlite3 *database = nil;
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
		{
			
			const char *sqlStatement = "insert into message values(?, ?,?,?, ?, ?)";
			
			sqlite3_stmt *compiledStatement;
			const char* lguid= (const char *) [message.notificationId UTF8String];
			const char* ltext = (const char *) [message.notificationTitle UTF8String];
			const char* limage = (const char *) [message.notificationImage UTF8String];
			NSString  *lposition= [[NSNumber numberWithInt:message.position] stringValue];
			const char* lpos=(const char *) [lposition UTF8String];
			//const char* date  = "CURRENT_DATE";
			const char* time = "current_timestamp";
			//NSLog(@"while inserting id = %s text = %s  image name = %s",instruction,text,image);
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"yyyy-MM-dd"];
			[dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			NSDate *currentdate = [NSDate date];
			NSString *date1 = [dateFormat stringFromDate:currentdate];
			const char* date=(const char *) [date1 UTF8String];
			
			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
				
				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
				
				sqlite3_bind_text(compiledStatement, 2,ltext , -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 3,limage, -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 4,lpos, -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 5,date , -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 6,time , -1, SQLITE_TRANSIENT);
				
			}
			
			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
				
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
				
			} 
			else {
				
				//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
				
			}
			
			sqlite3_finalize(compiledStatement);
		}
		
		sqlite3_close(database);
	}
	@catch (NSException * e) {
		NSLog(@"InsertMessageStream Exception ------------------- %@", [e description]);
		sqlite3_close(database);
	}
	
}


-(void) insertInstructions:(Instruction *)instruction //(NSString *)guid:(NSString *) name:(NSString *) startdate:(NSString *) enddate:(NSString *) imageurl: (int) status
{
	sqlite3 *database = nil;
	@try 
	{
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
		{
			
			const char *sqlStatement = "insert into instructions values(?, ?,?,?, ?,?,?)";
			sqlite3_stmt *compiledStatement;
			
			const char* lguid = (const char *) [instruction.instId UTF8String];
			const char* lname = (const char *) [instruction.title UTF8String];
			const char* lstartdate = (const char *) [instruction.startDate UTF8String];
			const char* lenddate = (const char *) [instruction.endDate UTF8String];
			const char* limageurl = (const char *) [instruction.instructionImage UTF8String];
			NSString  *state= [[NSNumber numberWithInt:instruction.isExecuted] stringValue];
			const char* ldescription = (const char *) [instruction.description UTF8String];
			const char* lstatus=(const char *) [state UTF8String];
					
			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
				
				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
				
				sqlite3_bind_text(compiledStatement, 2,lname , -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 3,lstartdate, -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 4,lenddate, -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 5,limageurl , -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 6,lstatus , -1, SQLITE_TRANSIENT);
				
				sqlite3_bind_text(compiledStatement, 7,ldescription , -1, SQLITE_TRANSIENT);
				
			}
			
			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
				
			} 
			else {
				
				//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
				
			}
			
			sqlite3_finalize(compiledStatement);
		}
		
		sqlite3_close(database);
	}
	@catch (NSException * e) 
	{
			NSLog(@"insertInstructions Exception ------------------- %@", [e description]);
			sqlite3_close(database);
		}
	
}

-(void) insertStyle:(NSString *)guid styleArray:(NSArray  *)styleArray//:(int) styleid:(NSString *) name:(int) quantity:(NSString *) imageurl
{
	sqlite3 *database = nil;
	@try 
	{
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
		{
			//for(int iLoop =0 ; iLoop < [styleArray count] ; iLoop++)
			for(Product *product in styleArray)
			{
				//Product *product = [styleArray objectAtIndex:iLoop];
				
				const char *sqlStatement = "insert into style values(?, ?,?,?,?,?,?,?)";
				sqlite3_stmt *compiledStatement;
				
				const char* lguid = (const char *) [guid UTF8String];
				//NSString  *style= [[NSNumber numberWithInt:product.productCode] stringValue];
				const char* lstyleid=(const char *) [product.productCode UTF8String];
				const char* lname = (const char *) [product.productName UTF8String];
				NSString  *quan= [[NSNumber numberWithInt:product.quantity] stringValue];
				const char* lquantity=(const char *) [quan UTF8String];
				const char* limageurl = (const char *) [product.thumbnailImageName UTF8String];
				
				NSString  *hotspotnumber= [[NSNumber numberWithInt:product.hotspotNumber] stringValue];
				const char* hotspot=(const char *) [hotspotnumber UTF8String];
				NSString  *xpos= [[NSNumber numberWithFloat:product.xCoordinater] stringValue];
				const char* posx=(const char *) [xpos UTF8String];
				NSString  *ypos= [[NSNumber numberWithFloat:product.yCoordinater] stringValue];
				const char* posy=(const char *) [ypos UTF8String];
				
				if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
					
					sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
					
					sqlite3_bind_text(compiledStatement, 2,lstyleid , -1, SQLITE_TRANSIENT);
					
					sqlite3_bind_text(compiledStatement, 3,lname, -1, SQLITE_TRANSIENT);
					
					sqlite3_bind_text(compiledStatement, 4,lquantity, -1, SQLITE_TRANSIENT);
					
					sqlite3_bind_text(compiledStatement, 5,limageurl , -1, SQLITE_TRANSIENT);
					
					sqlite3_bind_text(compiledStatement, 6,hotspot , -1, SQLITE_TRANSIENT);
					
					sqlite3_bind_text(compiledStatement, 7,posx, -1, SQLITE_TRANSIENT);
					
					sqlite3_bind_text(compiledStatement, 8,posy, -1, SQLITE_TRANSIENT);
					
				}
				
				if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
				{
					NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
					[Logger writeMessage:DEBUG message:message];
					[message release];
				} 
				else {
					
					//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
					
				}
				
				sqlite3_finalize(compiledStatement);
			}
		}
		
		sqlite3_close(database);
	}	
	@catch (NSException * e) {
		NSLog(@"insertStyle Exception ------------------- %@", [e description]);
		sqlite3_close(database);
	}
	
}

-(void) insertNotification:(Notification *)notification
{
	sqlite3 *database = nil;
	@try {
		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
		{
			
			const char *sqlStatement = "insert or replace into notifications values(?, ?)";
			
			sqlite3_stmt *compiledStatement;
			const char* lguid= (const char *) [notification.notificationId UTF8String];
			const char* lstatus= (const char *) [@"0" UTF8String];
			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
				
				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(compiledStatement, 2,lstatus , -1, SQLITE_TRANSIENT);
			}
			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
				
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			sqlite3_finalize(compiledStatement);
		}
		sqlite3_close(database);
	}
	@catch (NSException * e) 
	{
		NSLog(@"insertNotification Exception ------------------- %@", [e description]);
		sqlite3_close(database);
	}
}

#pragma mark -
#pragma mark READ DATABASE
#pragma mark -
-(NSDate *)stringToDate:(NSString *)stringDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];                      
	NSDate *date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return date;
}

-(NSArray *) readAllImagesandDate
{
	NSArray *allImages = [[NSMutableArray alloc] init];
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select imageurl,startdate from message"];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
	
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
			
				char *s;
				s=(char *)sqlite3_column_text(compiledStatement1, 0);
				NSString *limage = nil;
				NSString *ldate = nil;
				if(s!=nil)
				{
					limage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				}
				else {
					limage = @"";
				}


				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				if(s!=nil)
				{
					ldate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
				}
				else {
					ldate =@"";
				}

				
				NSLog(@"date = %@",ldate);
				NSDate * date;
				if(ldate)
				{
					date =[self stringToDate:ldate];
				}
				else {
					date = [NSDate date];
				}

				StoreImageObj *imageobject=[[StoreImageObj alloc]initWithImageName:limage onDate:date];
				
				if(![limage isEqualToString:@""])
					[(NSMutableArray*)allImages addObject:imageobject];
				
				NSLog(@"date = %@ name = %@",imageobject.imageDate, imageobject.imageName);
				[imageobject release];
				//sqlite3_reset(compiledStatement1);
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	return [allImages autorelease];
}


//-(NSMutableArray *) readFromMessageStream:(NSString * ) guid 
// {
//	 NSString *ltext,*limage,*lpos;
//	 
//	 int position;
//	 NSMutableArray *array=[[NSMutableArray alloc]init];
//	 
//	sqlite3 *database;
//	 if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	 {
//		 NSString *stmt = [[NSString alloc] initWithFormat:@"select * from message where guid ='%@'", guid];
//		 const char *sqlStatement = [stmt UTF8String];
//		 [stmt release];
//		 sqlite3_stmt *compiledStatement1;
//		 if(sqlite3_prepare_v2(mydatabase, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		 {
//		 
//			 while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			 {
//			 
//				 Notification *message=[[Notification alloc]init];
//				 char *s;
//				 NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				 message.notificationId=lguid;
//				 s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				 
//				 if(s!=nil)
//				 {
//					 ltext=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//					 message.notificationTitle=ltext;
//				 
//				 }
//				 else 
//				 {
//					 message.notificationTitle =@"";
//				 }
//				 
//				 s=(char *)sqlite3_column_text(compiledStatement1, 2);
//				 
//				 if(s!=nil)
//				 {
//					 limage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
//					 message.notificationImage=limage;
//				 }
//				 else 
//				 {
//					 message.notificationImage = @"";
//				 }
//				 
//				 lpos=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
//				 
//				 position = [lpos intValue];
//				 message.position=position;
//				 
//				 [array addObject:message];
//				 [message release];
//			 }
//			 
//		 }
//		 //sqlite3_reset(compiledStatement1);
//		 sqlite3_finalize(compiledStatement1);
//	 }
//	//sqlite3_finalize(compiledStatement1);
//	sqlite3_close(database);
//	
//	 NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(mydatabase)];
//	 [Logger writeMessage:DEBUG message:message];
//	 [message release];
//	 
//	 return [array autorelease];
// }

-(NSMutableArray *) readFromMessageStream:(NSString * ) guid 
{
	NSString *ltext,*limage,*lpos;
	
	int position;
	NSMutableArray *array=[[NSMutableArray alloc]init];
	//[self checkAndCreateDatabase];
	
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from message where guid ='%@'", guid];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				Notification *message=[[Notification alloc]init];
				char *s;
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				message.notificationId=lguid;
				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				
				if(s!=nil)
				{
					ltext=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
					message.notificationTitle=ltext;
					
				}
				else 
				{
					message.notificationTitle =@"";
				}
				
				s=(char *)sqlite3_column_text(compiledStatement1, 2);
				
				if(s!=nil)
				{
					limage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
					message.notificationImage=limage;
				}
				else 
				{
					message.notificationImage = @"";
				}
				
				lpos=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
				
				position = [lpos intValue];
				message.position=position;
				
				[array addObject:message];
				[message release];
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, array];
	[Logger writeMessage:DEBUG message:message];
	[message release];
	
	return [array autorelease];
	
}

-(Instruction *) readFromInstruction:(NSString * ) guid 
{
	Instruction *instruction = nil;
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions where guid ='%@'", guid];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			if(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				instruction=[[Instruction alloc]init];
				char *s;
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				instruction.instId=lguid;
				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				
				if(s!=nil)
				{
					instruction.title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
				}
				else 
				{
					instruction.title =@"";
				}
				
				s=(char *)sqlite3_column_text(compiledStatement1, 2);
				
				if(s!=nil)
				{
					instruction.startDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
				}
				else 
				{
					instruction.startDate = @"";
				}
				
				s=(char *)sqlite3_column_text(compiledStatement1, 3);
				
				if(s!=nil)
				{
					instruction.endDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
					NSLog(@"while retrieve %@ ",instruction.endDate);
				}
				else 
				{
					instruction.endDate = @"";
				}
				s=(char *)sqlite3_column_text(compiledStatement1, 4);
				if(s!=nil)
				{
					instruction.instructionImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
					
				}
				else 
				{
					instruction.instructionImage= @"";
				}
				NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 5)];
				BOOL state=[status boolValue];
				instruction.isExecuted=state;
				
				s=(char *)sqlite3_column_text(compiledStatement1, 6);
				if(s!=nil)
				{
					instruction.description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 6)];
					
				}
				else 
				{
					instruction.description= @"";
				}
				
				
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	return [instruction autorelease];	
}

//-(NSArray *) readAllNotification
//{
//	NSArray *allNotificationsList = [[NSMutableArray alloc] init];
//	sqlite3 *database;
//
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select guid,status from notifications"];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				NotificationStatus *notificationStatus = [[NotificationStatus alloc] init];
//				
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				notificationStatus.notificationId = lguid;
//				NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//				notificationStatus.status = [status intValue];
//				[(NSMutableArray*)allNotificationsList addObject:notificationStatus];
//				[notificationStatus release];
//
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
//	return [allNotificationsList autorelease];
//}

- (NSArray*) readAllNotification
{
	NSArray *notificationList = [[NSMutableArray alloc] init];
	sqlite3 *database;
	
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from notifications"];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				NotificationStatus *notificationStatus = [[NotificationStatus alloc] init];
				//NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				notificationStatus.notificationId = lguid;
				NSLog(@"Notification ===%@", lguid);
				NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
				notificationStatus.status = [status intValue];
				[(NSMutableArray*)notificationList addObject:notificationStatus];
				[notificationStatus release];
				
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	return [notificationList autorelease];	
}

-(NSArray *) readAllInstructionFromDatabase 
{
	NSArray *instructionList = [[NSMutableArray alloc] init];
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions"];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				Instruction *instruction =[[Instruction alloc]init];
				char *s;
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				instruction.instId=lguid;
				
				//NSLog(@"Instruction GUID == %@", instruction.instId);
				
				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				
				if(s!=nil)
				{
					instruction.title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
				}
				else 
				{
					instruction.title =@"";
				}
				
				//NSLog(@"Instruction Title == %@", instruction.title);
				
				s=(char *)sqlite3_column_text(compiledStatement1, 2);
				
				if(s!=nil)
				{
					instruction.startDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
					
				}
				else 
				{
					instruction.startDate = @"";
				}
				
				//NSLog(@"Instruction startDate == %@", instruction.startDate);
				
				s=(char *)sqlite3_column_text(compiledStatement1, 3);
				
				if(s!=nil)
				{
					instruction.endDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
					
				}
				else 
				{
					instruction.endDate = @"";
				}
				//NSLog(@"Instruction endDate == %@", instruction.endDate);
				
				s=(char *)sqlite3_column_text(compiledStatement1, 4);
				if(s!=nil)
				{
					instruction.instructionImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
					
				}
				else 
				{
					instruction.instructionImage= @"";
				}
				
				//NSLog(@"Instruction instructionImage == %@", instruction.instructionImage);
				
				NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 5)];
				BOOL state=[status boolValue];
				instruction.isExecuted=state;
				
				s=(char *)sqlite3_column_text(compiledStatement1, 6);
				if(s!=nil)
				{
					instruction.description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 6)];
					
				}
				else 
				{
					instruction.description= @"";
				}
				
			//	NSLog(@"Instruction description == %@", instruction.description);
				
				[(NSMutableArray*)instructionList addObject:instruction];
				[instruction release];
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	return [instructionList autorelease];	
}


-(NSMutableArray *) readFromStyle:(NSString * ) guid 
{
	NSMutableArray *ProductArray=[[NSMutableArray alloc]init];
	//[self checkAndCreateDatabase];
	
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from style where guid ='%@'", guid];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				Product *product=[[Product alloc]init];
				char *s;
				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				
				if(s!=nil)
				{
					product.productCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
					
				}
				else 
				{
					product.productCode =@"";
				}
				
				//NSLog(@"Style productCode == %@", product.productCode);
				
				s=(char *)sqlite3_column_text(compiledStatement1, 2);
				
				if(s!=nil)
				{
					product.productName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
				}
				else 
				{
					product.productName = @"";
				}
				
				//NSLog(@"Style productName == %@", product.productName);
				
				NSString *quan=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
				product.quantity = [quan intValue];
				
				s=(char *)sqlite3_column_text(compiledStatement1, 4);
				if(s!=nil)
				{
					product.thumbnailImageName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
				}
				else 
				{
					product.thumbnailImageName = @"";
				}
				
				//NSLog(@"Style thumbnailImageName == %@", product.thumbnailImageName);
				
				NSString *hotspotnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 5)];
				product.hotspotNumber = [hotspotnumber intValue];
				
				//NSLog(@"Style hotspotNumber == %d", product.hotspotNumber);
				
				NSString *posx=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 6)];
				product.xCoordinater= [posx floatValue];

				//NSLog(@"Style xCoordinater == %f", product.xCoordinater);
				
				NSString *posy=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 7)];
				product.yCoordinater = [posy floatValue];

				//NSLog(@"Style yCoordinater == %f", product.yCoordinater);
				

				[ProductArray addObject:product];
				[product release];
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	if([ProductArray count] > 0)
	{
		NSSortDescriptor *sortDescriptor;
		
		sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"hotspotNumber" ascending:YES] autorelease];
		
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
		
		NSMutableArray *newProductArray = (NSMutableArray*)[[ProductArray sortedArrayUsingDescriptors:sortDescriptors] copy];	
		
	//	[ProductArray autorelease];
		return [newProductArray autorelease];
	}
	
	return [ProductArray autorelease];
	
}

-(NSString *) readNotificationTitles : (NSString *) guid
{
	//NSDictionary *notificationDictionary = [[NSMutableDictionary alloc] init];
	
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions where guid ='%@'", guid];
		const char *sqlStatement = [stmt UTF8String];
		
		//NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions"];
		//const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			if(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				char *s;
				//NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				//notificationDictionary 
				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				
				if(s!=nil)
				{
					NSString *ltext=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
					//[(NSMutableDictionary*)notificationDictionary setObject:ltext forKey:lguid];
					return ltext;
					
				}
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	return nil;
}

#pragma mark -
#pragma mark DELETE QUERY HANDLER
#pragma mark -

- (void) deletefromPending:(NSString * ) guid
{
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sqlStatement;
		sqlite3_stmt *compiledStatement;
		sqlStatement = "delete from pending where guid = (?) ";
		const char* instruction= (const char *) [guid UTF8String];
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
			
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
		{
			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
			[Logger writeMessage:DEBUG message:message];
			[message release];
			
		} 
		else {
			
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	
}

-(void) deletefromInstructions:(NSString * ) guid
{
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sqlStatement;
		sqlite3_stmt *compiledStatement;
		sqlStatement = "delete from instructions where guid = (?) ";
		const char* instruction= (const char *) [guid UTF8String];
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
		{
			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
			[Logger writeMessage:DEBUG message:message];
			[message release];			
		} 
		else {
			
			//NSLog( @"Deleted ");
			
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	
}

-(void) deletefromMessageStream:(NSString * ) guid
{
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sqlStatement;
		sqlite3_stmt *compiledStatement;
		sqlStatement = "delete from message where guid = (?) ";
		const char* instruction= (const char *) [guid UTF8String];
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
			
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
		{
			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
			[Logger writeMessage:DEBUG message:message];
			[message release];
		} 
		else {
			
			//NSLog( @"Deleted ");
			
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	
}

#pragma mark -
#pragma mark getPendingNotificationMessageCount
#pragma mark -
-(int) getPendingNotificationMessageCount
{
	int result = 0;
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{ 
		NSString *stmt = [[NSString alloc] initWithFormat:@"select COUNT(*) from pending where category = 2"];
		const char *sqlStatement = [stmt UTF8String];
		
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				result=[lguid intValue];
				
			}
			if(sqlite3_step(compiledStatement1) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			
			sqlite3_finalize(compiledStatement1);
		}
	}
		sqlite3_close(database);
	return result;
}

-(int) getPendingInstructionCount
{
	int result = 0;
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{ 
		NSString *stmt = [[NSString alloc] initWithFormat:@"select COUNT(*) from pending where category = 1"];
		const char *sqlStatement = [stmt UTF8String];
		
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				result=[lguid intValue];
				
			}
			if(sqlite3_step(compiledStatement1) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	return result;
}

-(int) getPendingRatingCount
{
	int result = 0;
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{ 
		NSString *stmt = [[NSString alloc] initWithFormat:@"select COUNT(*) from pending where category = 3"];
		const char *sqlStatement = [stmt UTF8String];
		
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				result=[lguid intValue];
				
			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	return result;
}

-(NSArray *) getPendingInstructions
{
	sqlite3 *database;
	NSArray *guidArray=[[NSMutableArray alloc]init];
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{ 
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from pending where category = 1"];
		const char *sqlStatement = [stmt UTF8String];
		
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				NSString *guid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				[(NSMutableArray*)guidArray addObject:guid];
				
			}
			if(sqlite3_step(compiledStatement1) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	return [guidArray autorelease];
}

- (NSArray *)getPendingNotifications
{
	sqlite3 *database;
	NSArray *guidArray=[[NSMutableArray alloc]init];
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{ 
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from pending where category = 2"];
		const char *sqlStatement = [stmt UTF8String];
		
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				NSString *guid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				[(NSMutableArray*)guidArray addObject:guid];
				
			}
			if(sqlite3_step(compiledStatement1) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	return [guidArray autorelease];
}

-(int)howManyDaysHavePast:(NSDate*)lastDate today:(NSDate*)today 
{
	NSDate *startDate = lastDate;
	NSDate *endDate = today;
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSDayCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate options:0];
	int days = [components day];
	[gregorian release];
	return days;
}

-(int) getNonExecutedCount
{
	int pendingCount = 0;
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions where status=0"];
		const char *sqlStatement = [stmt UTF8String];
		[stmt release];
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				char *s;
				//NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				
				s=(char *)sqlite3_column_text(compiledStatement1, 3);
				
				if(s!=nil)
				{
					NSString *endDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
					
					if(endDate)
					{
						NSDate *today=[NSDate date];
						
						
						NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
						[dateFormatter1 setDateFormat:@"eee,MMM dd,yyyy"];                      
						NSDate *Date1 = [dateFormatter1 dateFromString:endDate];
						[dateFormatter1 release];

						int noDays = [self howManyDaysHavePast:today today:Date1];
						NSCalendar *calendar = [NSCalendar currentCalendar];
						NSDateComponents *differenceComponents = [calendar components:(NSDayCalendarUnit) fromDate:today
																			   toDate:Date1  options:0];
							
						noDays= [differenceComponents day];
		
						if(noDays<2)
						{
							pendingCount = pendingCount + 1;
						}
							
					}
				}

			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
	
	NSLog(@"getNonExecutedCount Total Pending Count == %d", pendingCount );
	return pendingCount;
	
}

#pragma mark -
#pragma mark UPDATA DatabaseHandler
#pragma mark -
-(void) updateInstruction:(NSString * ) guid aBool:(BOOL)aBool
{
	@synchronized(self)
	{
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sqlStatement;
		sqlite3_stmt *compiledStatement;
		if(aBool)
		{	sqlStatement = "UPDATE instructions SET status=1 where guid = (?) ";
		}
		else {
			sqlStatement = "UPDATE instructions SET status=0 where guid = (?) ";
		}

		const char* instruction= (const char *) [guid UTF8String];
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
			
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
		{
			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
			[Logger writeMessage:DEBUG message:message];
			[message release];
		} 
		else {
			
			//NSLog( @"Deleted ");
			
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	}
	
}

-(void) updateViewedNotification:(NSString *) guid
{
	@synchronized(self)
	{
		sqlite3 *database;
		if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
		{
			const char *sqlStatement;
			sqlite3_stmt *compiledStatement;
			sqlStatement = "UPDATE notifications SET status=1 where guid = (?) ";
			const char* instruction= (const char *) [guid UTF8String];
			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
			{
				sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
				
			}
			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
			{
				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
				[Logger writeMessage:DEBUG message:message];
				[message release];
			} 
			else {
				//NSLog( @"Deleted ");
			}
			
			sqlite3_finalize(compiledStatement);
		}
		
		sqlite3_close(database);
	}
}


#pragma mark -
#pragma mark MEMORY MANAGMENT
#pragma mark -
- (void) dealloc
{

	[super dealloc];
}
@end

//
//  DatabaseHandler.m
//  iShopShape
//
//  Created by Santosh B on 03/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

//#import "DatabaseHandler.h"
//#import "Logger.h"
//#import "Notification.h"
//#import "Product.h"
//#import "StoreImageObj.h"
//#import "NotificationStatus.h"
//
//static DatabaseHandler *sharedInstance;
//NSString *databaseName = @"iShopShape.sql";
//NSString *databasePath;
//
//@implementation DatabaseHandler
//
//+ (void) releaseIt
//{
//	sharedInstance = nil;
//}
//+ (id) sharedInstance 
//{
//	if(!sharedInstance)
//	{
//		sharedInstance = [[DatabaseHandler alloc] init];
//		
//		//m=[[Message alloc]init];
//		//databaseName = [[NSString alloc] initWithString:@"IShopShape.sql"];
//		
//		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//		NSString *documentsDir = [documentPaths objectAtIndex:0];
//		
//		databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
//		[databasePath retain];
//		
//		if(![sharedInstance checkDatabase])
//		{
//			[sharedInstance createDatabase];
//			[sharedInstance createTable];
//		}
//		//[self deletefromDatabase];
//	}
//	return sharedInstance;
//}
//
//#pragma mark -
//#pragma mark CREATE TABLES
//#pragma mark -
//- (void) createPendingAPNSNotificationTable : (sqlite3 *) database
//{
//	
//	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS pending( guid varchar ,category integer)";
//	
//	char *errorMsg = nil;
//	
//	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"pendingAPNSNotificationTable ----------- Created Successfully"];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//	else 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//}
//
//
//- (void) createInstructionsTable : (sqlite3 *) database
//{
//	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS instructions( guid varchar ,name VARCHAR(50),startdate VARCHAR(50),enddate VARCHAR(50),imageurl VARCHAR(70),status integer,description VARCHAR)";
//	char *errorMsg = nil;
//	
//	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"instructionTable ----------- Created Successfully"];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//	else 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//}
//
//- (void) createStyleTable : (sqlite3 *) database
//{
//	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS style(guid varchar ,styleid varchar,name VARCHAR(50),quantity INTEGER,imageurl VARCHAR(70),hotspotnumber INTEGER,posx INTEGER,posy INTEGER)";
//	char *errorMsg = nil;
//	
//	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"styleTable ----------- Created Successfully"];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//		
//	}
//	else 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//}
//
//- (void) createMessageStreamTable : (sqlite3 *) database
//{
//	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS message( guid varchar ,text VARCHAR(1000),imageurl VARCHAR(100),position integer,CURRENT_DATE,current_timestamp)";
//	char *errorMsg = nil;
//	
//	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"notificationTable ----------- Created Successfully"];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//		
//	}
//	else 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//}
//
//-(void) createUnViewedNotificationTable : (sqlite3 *)database
//{
//	const char *sqlStatement = "CREATE TABLE IF NOT EXISTS notifications( guid varchar,status integer,primary key(guid))";
//	char *errorMsg = nil;
//	
//	if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, @"notificationTable ----------- Created Successfully"];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//		
//	}
//	else 
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, errorMsg];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//}
//
//-(void) createTable 
//{	
//	sqlite3 *database = nil;
//	
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		
//		[self createPendingAPNSNotificationTable:database];
//		
//		[self createInstructionsTable:database];
//		
//		[self createStyleTable:database];
//		
//		[self createMessageStreamTable:database];
//		
//		[self createUnViewedNotificationTable:database];
//	}
//	
//	sqlite3_close(database);
//	
//}
//
//#pragma mark -
//#pragma mark DATABASE SETUP
//#pragma mark -
//- (void) createDatabase
//{
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//	
//	NSError *error = nil;
//	
//	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
//	
//	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:&error];
//	
//	if(error)
//	{
//		NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, [error description]];
//		[Logger writeMessage:DEBUG message:message];
//		[message release];
//	}
//}
//
//-(BOOL) checkDatabase
//{
//	BOOL success;
//	
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//	
//	success = [fileManager fileExistsAtPath:databasePath];
//	
//	return success;
//}
//
//#pragma mark -
//#pragma mark INSERT QUERY HANDLER
//#pragma mark -
//- (void) insertPendingNotification:(NSString *)guid category:(int)category
//{
//	sqlite3 *database = nil;
//	@try 
//	{
//		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			
//			const char *sqlStatement = "insert into pending values(?,?)";
//			
//			sqlite3_stmt *compiledStatement;
//			NSString  *categoryString= [[NSNumber numberWithInt:category] stringValue];
//			const char* lcategory= (const char *) [categoryString UTF8String];
//			
//			const char* lguid = (const char *) [guid UTF8String];
//			
//			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
//				
//				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
//				
//				sqlite3_bind_text(compiledStatement, 2,lcategory, -1, SQLITE_TRANSIENT);
//				
//			}
//			
//			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//			{
//				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//				[Logger writeMessage:DEBUG message:message];
//				[message release];
//			} 
//			else 
//			{
//				NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
//			}
//			
//			sqlite3_finalize(compiledStatement);
//		}
//		
//		sqlite3_close(database);
//	}
//	@catch (NSException * e) 
//	{
//		NSLog(@"insertPendingNotification Exception ------------------- %@", [e description]);
//		sqlite3_close(database);
//	}
//}
//
//-(void) insertMessageStream:(Notification *)message
//{
//	sqlite3 *database = nil;
//	@try 
//	{
//		sqlite3 *database = nil;
//		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			
//			const char *sqlStatement = "insert into message values(?, ?,?,?, ?, ?)";
//			
//			sqlite3_stmt *compiledStatement;
//			const char* lguid= (const char *) [message.notificationId UTF8String];
//			const char* ltext = (const char *) [message.notificationTitle UTF8String];
//			const char* limage = (const char *) [message.notificationImage UTF8String];
//			NSString  *lposition= [[NSNumber numberWithInt:message.position] stringValue];
//			const char* lpos=(const char *) [lposition UTF8String];
//			const char* date  = "CURRENT_DATE";
//			const char* time = "current_timestamp";
//			//NSLog(@"while inserting id = %s text = %s  image name = %s",instruction,text,image);
//			
//			
//			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
//				
//				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
//				
//				sqlite3_bind_text(compiledStatement, 2,ltext , -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 3,limage, -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 4,lpos, -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 5,date , -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 6,time , -1, SQLITE_TRANSIENT);
//				
//			}
//			
//			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//			{
//				sqlite3_finalize(compiledStatement);
//				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//				[Logger writeMessage:DEBUG message:message];
//				[message release];
//				
//			} 
//			else {
//				
//				//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
//				
//			}
//			
//			sqlite3_finalize(compiledStatement);
//		}
//		
//		sqlite3_close(database);
//	}
//	@catch (NSException * e) {
//		NSLog(@"InsertMessageStream Exception ------------------- %@", [e description]);
//		sqlite3_close(database);
//	}
//	
//}
//
//-(void) insertInstructions:(Instruction *)instruction //(NSString *)guid:(NSString *) name:(NSString *) startdate:(NSString *) enddate:(NSString *) imageurl: (int) status
//{
//	sqlite3 *database = nil;
//	@try 
//	{
//		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			
//			const char *sqlStatement = "insert into instructions values(?, ?,?,?, ?,?,?)";
//			sqlite3_stmt *compiledStatement;
//			
//			const char* lguid = (const char *) [instruction.instId UTF8String];
//			const char* lname = (const char *) [instruction.title UTF8String];
//			const char* lstartdate = (const char *) [instruction.startDate UTF8String];
//			const char* lenddate = (const char *) [instruction.endDate UTF8String];
//			const char* limageurl = (const char *) [instruction.instructionImage UTF8String];
//			NSString  *state= [[NSNumber numberWithInt:instruction.isExecuted] stringValue];
//			const char* ldescription = (const char *) [instruction.description UTF8String];
//			const char* lstatus=(const char *) [state UTF8String];
//			
//			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
//				
//				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
//				
//				sqlite3_bind_text(compiledStatement, 2,lname , -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 3,lstartdate, -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 4,lenddate, -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 5,limageurl , -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 6,lstatus , -1, SQLITE_TRANSIENT);
//				
//				sqlite3_bind_text(compiledStatement, 7,ldescription , -1, SQLITE_TRANSIENT);
//				
//			}
//			
//			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//			{
//				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//				[Logger writeMessage:DEBUG message:message];
//				[message release];
//				
//			} 
//			else {
//				
//				//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
//				
//			}
//			
//			sqlite3_finalize(compiledStatement);
//		}
//		
//		sqlite3_close(database);
//	}
//	@catch (NSException * e) 
//	{
//		NSLog(@"insertInstructions Exception ------------------- %@", [e description]);
//		sqlite3_close(database);
//	}
//	
//}
//
//-(void) insertStyle:(NSString *)guid styleArray:(NSArray  *)styleArray//:(int) styleid:(NSString *) name:(int) quantity:(NSString *) imageurl
//{
//	sqlite3 *database = nil;
//	@try 
//	{
//		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			//for(int iLoop =0 ; iLoop < [styleArray count] ; iLoop++)
//			for(Product *product in styleArray)
//			{
//				//Product *product = [styleArray objectAtIndex:iLoop];
//				
//				const char *sqlStatement = "insert into style values(?, ?,?,?,?,?,?,?)";
//				sqlite3_stmt *compiledStatement;
//				
//				const char* lguid = (const char *) [guid UTF8String];
//				//NSString  *style= [[NSNumber numberWithInt:product.productCode] stringValue];
//				const char* lstyleid=(const char *) [product.productCode UTF8String];
//				const char* lname = (const char *) [product.productName UTF8String];
//				NSString  *quan= [[NSNumber numberWithInt:product.quantity] stringValue];
//				const char* lquantity=(const char *) [quan UTF8String];
//				const char* limageurl = (const char *) [product.thumbnailImageName UTF8String];
//				
//				NSString  *hotspotnumber= [[NSNumber numberWithInt:product.hotspotNumber] stringValue];
//				const char* hotspot=(const char *) [hotspotnumber UTF8String];
//				NSString  *xpos= [[NSNumber numberWithFloat:product.xCoordinater] stringValue];
//				const char* posx=(const char *) [xpos UTF8String];
//				NSString  *ypos= [[NSNumber numberWithFloat:product.yCoordinater] stringValue];
//				const char* posy=(const char *) [ypos UTF8String];
//				
//				if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
//					
//					sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);                               
//					
//					sqlite3_bind_text(compiledStatement, 2,lstyleid , -1, SQLITE_TRANSIENT);
//					
//					sqlite3_bind_text(compiledStatement, 3,lname, -1, SQLITE_TRANSIENT);
//					
//					sqlite3_bind_text(compiledStatement, 4,lquantity, -1, SQLITE_TRANSIENT);
//					
//					sqlite3_bind_text(compiledStatement, 5,limageurl , -1, SQLITE_TRANSIENT);
//					
//					sqlite3_bind_text(compiledStatement, 6,hotspot , -1, SQLITE_TRANSIENT);
//					
//					sqlite3_bind_text(compiledStatement, 7,posx, -1, SQLITE_TRANSIENT);
//					
//					sqlite3_bind_text(compiledStatement, 8,posy, -1, SQLITE_TRANSIENT);
//					
//				}
//				
//				if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//				{
//					NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//					[Logger writeMessage:DEBUG message:message];
//					[message release];
//				} 
//				else {
//					
//					//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
//					
//				}
//				
//				sqlite3_finalize(compiledStatement);
//			}
//		}
//		
//		sqlite3_close(database);
//	}	
//	@catch (NSException * e) {
//		NSLog(@"insertStyle Exception ------------------- %@", [e description]);
//		sqlite3_close(database);
//	}
//	
//}
//
//-(void) insertNotification:(Notification *)notification
//{
//	sqlite3 *database = nil;
//	@try {
//		if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			
//			const char *sqlStatement = "insert or replace into notifications values(?, ?)";
//			
//			sqlite3_stmt *compiledStatement;
//			const char* lguid= (const char *) [notification.notificationId UTF8String];
//			const char* lstatus= (const char *) [@"0" UTF8String];
//			if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
//				
//				sqlite3_bind_text(compiledStatement, 1,lguid , -1, SQLITE_TRANSIENT);
//				sqlite3_bind_text(compiledStatement, 2,lstatus , -1, SQLITE_TRANSIENT);
//			}
//			if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
//				
//				NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//				[Logger writeMessage:DEBUG message:message];
//				[message release];
//			} 
//			sqlite3_finalize(compiledStatement);
//		}
//		sqlite3_close(database);
//	}
//	@catch (NSException * e) 
//	{
//		NSLog(@"insertNotification Exception ------------------- %@", [e description]);
//		sqlite3_close(database);
//	}
//}
//
//#pragma mark -
//#pragma mark READ DATABASE
//#pragma mark -
//-(NSDate *)stringToDate:(NSString *)stringDate
//{
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateFormat:@"yyyy-MM-dd"];                      
//	NSDate *date = [dateFormatter dateFromString:stringDate];
//	[dateFormatter release];
//	return date;
//}
//
//-(NSArray *) readAllImagesandDate
//{
//	NSArray *allImages = [[NSMutableArray alloc] init];
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select imageurl,CURRENT_DATE from message"];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				char *s;
//				s=(char *)sqlite3_column_text(compiledStatement1, 0);
//				NSString *limage = nil;
//				NSString *ldate = nil;
//				if(s!=nil)
//				{
//					limage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				}
//				else {
//					limage = @"";
//				}
//				
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				if(s!=nil)
//				{
//					ldate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//				}
//				else {
//					ldate =@"";
//				}
//				
//				
//				NSLog(@"date = %@",ldate);
//				NSDate * date;
//				if(ldate)
//				{
//					date =[self stringToDate:ldate];
//				}
//				else {
//					date = [NSDate date];
//				}
//				
//				StoreImageObj *imageobject=[[StoreImageObj alloc]initWithImageName:limage onDate:date];
//				
//				if(![limage isEqualToString:@""])
//					[(NSMutableArray*)allImages addObject:imageobject];
//				
//				NSLog(@"date = %@ name = %@",imageobject.imageDate, imageobject.imageName);
//				[imageobject release];
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
//	return [allImages autorelease];
//}
//-(NSMutableArray *) readFromMessageStream:(NSString * ) guid 
//{
//	NSString *ltext,*limage,*lpos;
//	
//	int position;
//	NSMutableArray *array=[[NSMutableArray alloc]init];
//	//[self checkAndCreateDatabase];
//	
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from message where guid ='%@'", guid];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				Notification *message=[[Notification alloc]init];
//				char *s;
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				message.notificationId=lguid;
//				s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				
//				if(s!=nil)
//				{
//					ltext=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//					message.notificationTitle=ltext;
//					
//				}
//				else 
//				{
//					message.notificationTitle =@"";
//				}
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 2);
//				
//				if(s!=nil)
//				{
//					limage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
//					message.notificationImage=limage;
//				}
//				else 
//				{
//					message.notificationImage = @"";
//				}
//				
//				lpos=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
//				
//				position = [lpos intValue];
//				message.position=position;
//				
//				[array addObject:message];
//				[message release];
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
////	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, array];
////	[Logger writeMessage:DEBUG message:message];
////	[message release];
//	
//	return [array autorelease];
//	
//}
//
//-(Instruction *) readFromInstruction:(NSString * ) guid 
//{
//	Instruction *instruction = nil;
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions where guid ='%@'", guid];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			if(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				instruction=[[Instruction alloc]init];
//				char *s;
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				instruction.instId=lguid;
//				s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				
//				if(s!=nil)
//				{
//					instruction.title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//				}
//				else 
//				{
//					instruction.title =@"";
//				}
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 2);
//				
//				if(s!=nil)
//				{
//					instruction.startDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
//				}
//				else 
//				{
//					instruction.startDate = @"";
//				}
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 3);
//				
//				if(s!=nil)
//				{
//					instruction.endDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
//					NSLog(@"while retrieve %@ ",instruction.endDate);
//				}
//				else 
//				{
//					instruction.endDate = @"";
//				}
//				s=(char *)sqlite3_column_text(compiledStatement1, 4);
//				if(s!=nil)
//				{
//					instruction.instructionImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
//					
//				}
//				else 
//				{
//					instruction.instructionImage= @"";
//				}
//				NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 5)];
//				BOOL state=[status boolValue];
//				instruction.isExecuted=state;
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 6);
//				if(s!=nil)
//				{
//					instruction.description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 6)];
//					
//				}
//				else 
//				{
//					instruction.description= @"";
//				}
//				
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
//	return [instruction autorelease];	
//}
//
//-(NSArray *) readAllNotification
//{
//	NSArray *allNotificationsList = [[NSMutableArray alloc] init];
//	@try {
//		sqlite3 *database;
//		if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//		{
//			NSString *stmt = [[NSString alloc] initWithFormat:@"select * from notifications"];
//			const char *sqlStatement = [stmt UTF8String];
//			[stmt release];
//			sqlite3_stmt *compiledStatement1;
//			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//			{
//				while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//				{
//					NotificationStatus *notificationStatus = [[NotificationStatus alloc] init];
//					
//					NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//					notificationStatus.notificationId = lguid;
//					NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//					notificationStatus.status = [status intValue];
//					[(NSMutableArray*)allNotificationsList addObject:notificationStatus];
//					[notificationStatus release];
//					
//				}
//				sqlite3_finalize(compiledStatement1);
//			}
//		}
//		sqlite3_close(database);
//	}
//	@catch (NSException * e) {
//		NSLog(@"Error = %@", [e description]);
//	}
//	
//	return [allNotificationsList autorelease];
//}
//
//-(NSArray *) readAllInstructionFromDatabase 
//{
//	NSArray *instructionList = [[NSMutableArray alloc] init];
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions"];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				Instruction *instruction =[[Instruction alloc]init];
//				char *s;
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				instruction.instId=lguid;
//				
//				//NSLog(@"Instruction GUID == %@", instruction.instId);
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				
//				if(s!=nil)
//				{
//					instruction.title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//				}
//				else 
//				{
//					instruction.title =@"";
//				}
//				
//				//NSLog(@"Instruction Title == %@", instruction.title);
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 2);
//				
//				if(s!=nil)
//				{
//					instruction.startDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
//					
//				}
//				else 
//				{
//					instruction.startDate = @"";
//				}
//				
//				//NSLog(@"Instruction startDate == %@", instruction.startDate);
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 3);
//				
//				if(s!=nil)
//				{
//					instruction.endDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
//					
//				}
//				else 
//				{
//					instruction.endDate = @"";
//				}
//				//NSLog(@"Instruction endDate == %@", instruction.endDate);
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 4);
//				if(s!=nil)
//				{
//					instruction.instructionImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
//					
//				}
//				else 
//				{
//					instruction.instructionImage= @"";
//				}
//				
//				//NSLog(@"Instruction instructionImage == %@", instruction.instructionImage);
//				
//				NSString *status=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 5)];
//				BOOL state=[status boolValue];
//				instruction.isExecuted=state;
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 6);
//				if(s!=nil)
//				{
//					instruction.description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 6)];
//					
//				}
//				else 
//				{
//					instruction.description= @"";
//				}
//				
//				//	NSLog(@"Instruction description == %@", instruction.description);
//				
//				[(NSMutableArray*)instructionList addObject:instruction];
//				[instruction release];
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
//	return [instructionList autorelease];	
//}
//
//
//-(NSMutableArray *) readFromStyle:(NSString * ) guid 
//{
//	NSMutableArray *ProductArray=[[NSMutableArray alloc]init];
//	//[self checkAndCreateDatabase];
//	
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from style where guid ='%@'", guid];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				Product *product=[[Product alloc]init];
//				char *s;
//				s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				
//				if(s!=nil)
//				{
//					product.productCode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//					
//				}
//				else 
//				{
//					product.productCode =@"";
//				}
//				
//				//NSLog(@"Style productCode == %@", product.productCode);
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 2);
//				
//				if(s!=nil)
//				{
//					product.productName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
//				}
//				else 
//				{
//					product.productName = @"";
//				}
//				
//				//NSLog(@"Style productName == %@", product.productName);
//				
//				NSString *quan=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
//				product.quantity = [quan intValue];
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 4);
//				if(s!=nil)
//				{
//					product.thumbnailImageName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 4)];
//				}
//				else 
//				{
//					product.thumbnailImageName = @"";
//				}
//				
//				//NSLog(@"Style thumbnailImageName == %@", product.thumbnailImageName);
//				
//				NSString *hotspotnumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 5)];
//				product.hotspotNumber = [hotspotnumber intValue];
//				
//				//NSLog(@"Style hotspotNumber == %d", product.hotspotNumber);
//				
//				NSString *posx=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 6)];
//				product.xCoordinater= [posx floatValue];
//				
//				//NSLog(@"Style xCoordinater == %f", product.xCoordinater);
//				
//				NSString *posy=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 7)];
//				product.yCoordinater = [posy floatValue];
//				
//				//NSLog(@"Style yCoordinater == %f", product.yCoordinater);
//				
//				
//				[ProductArray addObject:product];
//				[product release];
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
//	if([ProductArray count] > 0)
//	{
//		NSSortDescriptor *sortDescriptor;
//		
//		sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"hotspotNumber" ascending:YES] autorelease];
//		
//		NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//		
//		NSMutableArray *newProductArray = (NSMutableArray*)[[ProductArray sortedArrayUsingDescriptors:sortDescriptors] copy];	
//		
//		[ProductArray autorelease];
//		return [newProductArray autorelease];
//	}
//	
//	return [ProductArray autorelease];
//	
//}
//
//-(NSString *) readNotificationTitles : (NSString *) guid
//{
//	//NSDictionary *notificationDictionary = [[NSMutableDictionary alloc] init];
//	
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions where guid ='%@'", guid];
//		const char *sqlStatement = [stmt UTF8String];
//		
//		//NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions"];
//		//const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			if(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				char *s;
//				//NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				//notificationDictionary 
//				s=(char *)sqlite3_column_text(compiledStatement1, 1);
//				
//				if(s!=nil)
//				{
//					NSString *ltext=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
//					//[(NSMutableDictionary*)notificationDictionary setObject:ltext forKey:lguid];
//					return ltext;
//					
//				}
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	return nil;
//}
//
//#pragma mark -
//#pragma mark DELETE QUERY HANDLER
//#pragma mark -
//
//- (void) deletefromPending:(NSString * ) guid
//{
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		
//		const char *sqlStatement;
//		sqlite3_stmt *compiledStatement;
//		sqlStatement = "delete from pending where guid = (?) ";
//		const char* instruction= (const char *) [guid UTF8String];
//		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
//		{
//			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
//			
//		}
//		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//		{
//			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//			[Logger writeMessage:DEBUG message:message];
//			[message release];
//			
//		} 
//		else {
//			
//		}
//		
//		sqlite3_finalize(compiledStatement);
//	}
//	
//	sqlite3_close(database);
//	
//}
//
//-(void) deletefromInstructions:(NSString * ) guid
//{
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		
//		const char *sqlStatement;
//		sqlite3_stmt *compiledStatement;
//		sqlStatement = "delete from instructions where guid = (?) ";
//		const char* instruction= (const char *) [guid UTF8String];
//		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
//		{
//			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
//		}
//		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//		{
//			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//			[Logger writeMessage:DEBUG message:message];
//			[message release];			
//		} 
//		else {
//			
//			//NSLog( @"Deleted ");
//			
//		}
//		
//		sqlite3_finalize(compiledStatement);
//	}
//	
//	sqlite3_close(database);
//	
//}
//
//-(void) deletefromMessageStream:(NSString * ) guid
//{
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		
//		const char *sqlStatement;
//		sqlite3_stmt *compiledStatement;
//		sqlStatement = "delete from message where guid = (?) ";
//		const char* instruction= (const char *) [guid UTF8String];
//		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
//		{
//			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
//			
//		}
//		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//		{
//			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//			[Logger writeMessage:DEBUG message:message];
//			[message release];
//		} 
//		else {
//			
//			//NSLog( @"Deleted ");
//			
//		}
//		
//		sqlite3_finalize(compiledStatement);
//	}
//	
//	sqlite3_close(database);
//	
//}
//
//#pragma mark -
//#pragma mark getPendingNotificationMessageCount
//#pragma mark -
//-(int) getPendingNotificationMessageCount
//{
//	int result = 0;
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{ 
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select COUNT(*) from pending where category = 2"];
//		const char *sqlStatement = [stmt UTF8String];
//		
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				result=[lguid intValue];
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	return result;
//}
//
//-(int) getPendingInstructionCount
//{
//	int result = 0;
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{ 
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select COUNT(*) from pending where category = 1"];
//		const char *sqlStatement = [stmt UTF8String];
//		
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				result=[lguid intValue];
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	return result;
//}
//
//-(int) getPendingRatingCount
//{
//	int result = 0;
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{ 
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select COUNT(*) from pending where category = 3"];
//		const char *sqlStatement = [stmt UTF8String];
//		
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				result=[lguid intValue];
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	return result;
//}
//
//-(NSArray *) getPendingInstructions
//{
//	sqlite3 *database;
//	NSArray *guidArray=[[NSMutableArray alloc]init];
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{ 
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from pending where category = 1"];
//		const char *sqlStatement = [stmt UTF8String];
//		
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				NSString *guid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				[(NSMutableArray*)guidArray addObject:guid];
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	return [guidArray autorelease];
//}
//
//- (NSArray *)getPendingNotifications
//{
//	sqlite3 *database;
//	NSArray *guidArray=[[NSMutableArray alloc]init];
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{ 
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from pending where category = 2"];
//		const char *sqlStatement = [stmt UTF8String];
//		
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				
//				NSString *guid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				[(NSMutableArray*)guidArray addObject:guid];
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	return [guidArray autorelease];
//}
//
//-(int)howManyDaysHavePast:(NSDate*)lastDate today:(NSDate*)today 
//{
//	NSDate *startDate = lastDate;
//	NSDate *endDate = today;
//	NSCalendar *gregorian = [[NSCalendar alloc]
//							 initWithCalendarIdentifier:NSGregorianCalendar];
//	unsigned int unitFlags = NSDayCalendarUnit;
//	NSDateComponents *components = [gregorian components:unitFlags
//												fromDate:startDate
//												  toDate:endDate options:0];
//	int days = [components day];
//	[gregorian release];
//	return days;
//}
//
//-(int) getNonExecutedCount
//{
//	int pendingCount = 0;
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		NSString *stmt = [[NSString alloc] initWithFormat:@"select * from instructions where status=0"];
//		const char *sqlStatement = [stmt UTF8String];
//		[stmt release];
//		sqlite3_stmt *compiledStatement1;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
//		{
//			
//			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
//			{
//				char *s;
//				//NSString *lguid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
//				
//				s=(char *)sqlite3_column_text(compiledStatement1, 3);
//				
//				if(s!=nil)
//				{
//					NSString *endDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
//					
//					if(endDate)
//					{
//						NSDate *today=[NSDate date];
//						
//						
//						NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//						[dateFormatter1 setDateFormat:@"eee,MMM dd,yyyy"];                      
//						NSDate *Date1 = [dateFormatter1 dateFromString:endDate];
//						[dateFormatter1 release];
//						
//						int noDays = [self howManyDaysHavePast:today today:Date1];
//						//						NSCalendar *calendar = [NSCalendar currentCalendar];
//						//						NSDateComponents *differenceComponents = [calendar components:(NSDayCalendarUnit) fromDate:today
//						//																			   toDate:Date1  options:0];
//						//							
//						//						int noDays= [differenceComponents day];
//						
//						if(noDays<2)
//						{
//							pendingCount = pendingCount + 1;
//						}
//						
//					}
//				}
//				
//			}
//			sqlite3_finalize(compiledStatement1);
//		}
//	}
//	sqlite3_close(database);
//	
//	NSLog(@"getNonExecutedCount Total Pending Count == %d", pendingCount );
//	return pendingCount;
//	
//}
//
//#pragma mark -
//#pragma mark UPDATA DatabaseHandler
//#pragma mark -
//-(void) updateInstruction:(NSString * ) guid aBool:(BOOL)aBool
//{
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		
//		const char *sqlStatement;
//		sqlite3_stmt *compiledStatement;
//		if(aBool)
//		{	sqlStatement = "UPDATE instructions SET status=1 where guid = (?) ";
//		}
//		else {
//			sqlStatement = "UPDATE instructions SET status=0 where guid = (?) ";
//		}
//		
//		const char* instruction= (const char *) [guid UTF8String];
//		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
//		{
//			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
//			
//		}
//		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//		{
//			NSString *message = [[NSString alloc] initWithFormat:@" %@ - %s",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//			[Logger writeMessage:DEBUG message:message];
//			[message release];
//		} 
//		else {
//			
//			//NSLog( @"Deleted ");
//			
//		}
//		
//		sqlite3_finalize(compiledStatement);
//	}
//	
//	sqlite3_close(database);
//	
//}
//
//-(void) updateViewedNotification:(NSString *) guid
//{
//	sqlite3 *database;
//	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
//	{
//		
//		const char *sqlStatement;
//		sqlite3_stmt *compiledStatement;
//		sqlStatement = "UPDATE notifications SET status=1 where guid = (?) ";
//		const char* instruction= (const char *) [guid UTF8String];
//		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
//		{
//			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
//			
//		}
//		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) 
//		{
//			//NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, sqlite3_errmsg(database)];
//			//[Logger writeMessage:DEBUG message:message];
//			//[message release];
//		} 
//		else {
//			//NSLog( @"Deleted ");
//		}
//		
//		sqlite3_finalize(compiledStatement);
//	}
//	
//	sqlite3_close(database);
//}
//
//
//#pragma mark -
//#pragma mark MEMORY MANAGMENT
//#pragma mark -
//- (void) dealloc
//{
//	[databaseName release];
//	[databasePath release];
//	[super dealloc];
//}
//@end

