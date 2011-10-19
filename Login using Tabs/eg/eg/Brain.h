//
//  Brain.h
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Brain : NSObject {
    sqlite3 *database;
    NSString * databaseName;
    NSString * databasePath;
}
-(NSString *) loginBrain: (NSString *) uid 
              pass: (NSString *) pwd;
-(BOOL) regiBrain: (NSString *) uid 
             pass: (NSString *) pwd 
             Name: (NSString *) name 
              Age: (NSString *) age 
              Add: (NSString *) add 
            Image: (NSString *) img;
-(NSString *) getData: (NSString *) request;
@end
