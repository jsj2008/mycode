//
//  Brain.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Brain.h"
#import <sqlite3.h>

@implementation Brain
-(NSString *) loginBrain: (NSString *) uid 
              pass: (NSString *) pwd
{
//    
//    sqlite3 * database;
//    NSString * databaseName = @"app3";
//    NSString * databasePath;
//	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDir = [documentPaths objectAtIndex:0];
//	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];

	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
    {

		const char *sqlStatement = [[NSString stringWithFormat:@"select pwd,name from userdb where uid='%@'",uid]UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
            {
				// Read the data from the result row
				NSString *paswd = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                if([paswd isEqualToString:pwd])
                {
                    return [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];

                }
                else
                    return NO;
            }
            return NO;
		}
        else
            return NO;


        
	}
    else
        return NO;

}
-(id) init
{
    databaseName = @"app3";
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    return self;
}


-(NSString *) getData: (NSString *) request
{
    NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];

    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
    {
        
		const char *sqlStatement = [[NSString stringWithFormat:@"select %@ from userdb where uid='%@'",request,[chk stringForKey:@"CurrentUid"]] UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
            {
				// Read the data from the result row
				NSString *data = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                return data;
            }
            return NO;
		}
        else
            return NO;
        
        
        
	}
    else
        return NO;

}


-(BOOL) regiBrain: (NSString *) uid 
             pass: (NSString *) pwd 
             Name: (NSString *) name 
              Age: (NSString *) age 
              Add: (NSString *) add 
            Image: (NSString *) img
{
    
//    sqlite3 * database;
//    NSString * databaseName = @"app3";
//    NSString * databasePath;
//	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDir = [documentPaths objectAtIndex:0];
//	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
    {
        
        
        const char *sqlStatement;
        
        sqlite3_stmt *compiledStatement;
               //        sqlStatement = [[NSString stringWithFormat:@"insert into userdb VALUES('Anre','jk','ads','fr','hy','yhr')"] UTF8String];
        sqlStatement = [[NSString stringWithFormat:@"insert into userdb VALUES('%@','%@','%@','%@','%@','%@')",uid,pwd,name,age,add,img] UTF8String];
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
            return YES;
        }
        else
            return NO;
    }
    else
        return NO;

}
@end
