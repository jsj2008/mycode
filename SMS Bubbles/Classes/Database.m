//
//  Database.m
//  DatabaseHandler
//
//  Created by Ayush Goel on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Database.h"
#import "Message.h"

@implementation Database

- (void)settings {
	
	m=[[Message alloc]init];
	databaseName = @"IShopShape.sql";
	
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	[self checkAndCreateDatabase];
	[self createtable];
	//[self deletefromDatabase];
	
	
}


-(void) checkAndCreateDatabase
{
	BOOL success;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:databasePath];
	
	if(success) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
}

-(void) insertDatabase:(int ) i:(NSString *) a:(NSString *) b:(int ) j
{

	sqlite3 *database;
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
			
		const char *sqlStatement = "insert into  message values(?, ?,?,?, ?, ?)";
		
		sqlite3_stmt *compiledStatement;
		NSString  *a1= [[NSNumber numberWithInt:i] stringValue];
		const char* instruction= (const char *) [a1 UTF8String];
	
		const char* text = (const char *) [a UTF8String];
		const char* image = (const char *) [b UTF8String];
		NSString  *a2= [[NSNumber numberWithInt:j] stringValue];
		const char* pos=(const char *) [a2 UTF8String];
		const char* date  = "CURRENT_DATE";
		const char* time = "current_timestamp";
	    //NSLog(@"while inserting id = %s text = %s  image name = %s",instruction,text,image);
		
	
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK){//inserting data to table
				
			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT);                               
				
			sqlite3_bind_text(compiledStatement, 2,text , -1, SQLITE_TRANSIENT);
				
			sqlite3_bind_text(compiledStatement, 3,image, -1, SQLITE_TRANSIENT);
			
			sqlite3_bind_text(compiledStatement, 4,pos, -1, SQLITE_TRANSIENT);

			sqlite3_bind_text(compiledStatement, 5,date , -1, SQLITE_TRANSIENT);
				
			sqlite3_bind_text(compiledStatement, 6,time , -1, SQLITE_TRANSIENT);
			
		}
		
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
			
			NSLog( @"Error!!: %s", sqlite3_errmsg(database) );
			
		} 
		else {
			
			//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
			
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	
}
-(void) deletefromDatabase
{sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sqlStatement;
		sqlite3_stmt *compiledStatement;
		sqlStatement = "delete from message where id = (?) ";
		int i=0;
		NSString  *a1= [[NSNumber numberWithInt:i] stringValue];
		NSLog(@"id in del %@",a1);
		const char* instruction= (const char *) [a1 UTF8String];
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(compiledStatement, 1,instruction , -1, SQLITE_TRANSIENT); 
			NSLog(@"dele successfully");
			
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
			
			NSLog( @"Error!!: %s", sqlite3_errmsg(database) );
			
		} 
		else {
			
			//NSLog( @"Insert into row id = %d", sqlite3_last_insert_rowid(database));
			
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	
	
}



-(NSMutableArray *) readFromDatabase 
{
	
	NSMutableArray *array=[[NSMutableArray alloc]init];
	[self checkAndCreateDatabase];
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		const char *sqlStatement = "select * from message";
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement1, NULL) == SQLITE_OK) 
		{
			
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{
				
				m=[[Message alloc]init];
				NSString *a1;
				 char *s;
				a1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 0)];
				int id2 = [a1 intValue];
				m.id1=id2;
				s=(char *)sqlite3_column_text(compiledStatement1, 1);
				if(s!=nil)
				{
					a1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 1)];
					m.text=a1;
				
				}
				else {
					m.image =@"NULL";
				}
				s=(char *)sqlite3_column_text(compiledStatement1, 2);
				if(s!=nil)
				{
					a1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 2)];
					m.image=a1;
				}
				else {
					m.image = @"NULL";
				}
				a1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1, 3)];
				id2 = [a1 intValue];
				m.pos=id2;
				[array addObject:m];
				
				

			}
			sqlite3_finalize(compiledStatement1);
		}
	}
	sqlite3_close(database);
    
	return array;
	
}

-(void) update
{
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sqlStatement = "UPDATE instructions SET status=0 WHERE id=2";
		char *errorMsg;
		if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
		{
			NSLog(@"update successfully");
			
		}
		
	}
	
	sqlite3_close(database);
	
	
	
	
}





-(void) createtable 
{
	
	sqlite3 *database;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
	{
		
		
		const char *sqlStatement = "CREATE TABLE IF NOT EXISTS pending( id INTEGER PRIMARY KEY,category VARCHAR(50))";
		char *errorMsg;
		if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
		{
			//NSLog(@"instruction table SUCCESSFULLY");
			
		}
		
		
		sqlStatement = "CREATE TABLE IF NOT EXISTS instructions( id INTEGER ,name VARCHAR(50),startdate VARCHAR(50),enddate VARCHAR(50),imageurl VARCHAR(70),status integer,foreign key(id) references pending)";
		if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
		{
			//NSLog(@"instruction table SUCCESSFULLY");
			
		}
		
		sqlStatement = "CREATE TABLE IF NOT EXISTS style( id INTEGER ,styleid INTEGER,name VARCHAR(50),quantity INTEGER,imageurl VARCHAR(70),foreign key(id) references pending)";
		
		if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
		{
			//NSLog(@"style table SUCCESSFULLY");
			
		}
		sqlStatement = "CREATE TABLE IF NOT EXISTS message( id INTEGER ,text VARCHAR(1000),imageurl VARCHAR(70),position integer,CURRENT_DATE,current_timestamp,foreign key(id) references pending)";
		
		if(sqlite3_exec(database, sqlStatement,NULL, NULL,&errorMsg)== SQLITE_OK) 
		{
			//NSLog(@"notification tbales SUCCESSFULLY");
			
		}
	}
	
	
	sqlite3_close(database);
	
	
}

@end
