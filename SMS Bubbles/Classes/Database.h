//
//  Database.h
//  SMS Bubbles
//
//  Created by Ayush Goel on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Message.h"
@interface Database : NSObject 
{

	NSString *databaseName;
	NSString *databasePath;
	Message *m;
	
	
}
-(IBAction) settings;
-(IBAction) createtable;
-(IBAction) checkAndCreateDatabase;
-(NSMutableArray *) readFromDatabase;
-(IBAction) update;
-(IBAction) deletefromDatabase;
-(void) insertDatabase:(int ) i:(NSString *) a:(NSString *) b:(int ) k;



@end
