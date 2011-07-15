//
//  DatabaseHandler.h
//  iShopShape
//
//  Created by Santosh B on 03/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Notification.h"
#import "Instruction.h"

@interface DatabaseHandler : NSObject {
	 sqlite3 *mydatabase;
}
+ (void) releaseIt;
+(id) sharedInstance;
-(BOOL) checkDatabase;
-(void) createDatabase;
-(void) createTable; 


/*
 *Database Insert Operation
 */

- (void) insertPendingNotification:(NSString *)guid category:(int)category;
- (void) insertMessageStream:(Notification *)message;
- (void) insertInstructions:(Instruction*) instruction;
- (void) insertStyle:(NSString *)guid styleArray:(NSArray  *)styleArray;
- (void) insertNotification:(Notification *)notification;

/*
 *Database Get Count Operation
 */

-(int) getPendingInstructionCount;
-(int) getPendingNotificationMessageCount;
-(int) getPendingRatingCount;
-(int) getNonExecutedCount;

/*
 * Database Get Pending Events Operation
 */
-(NSArray *) getPendingInstructions;
-(NSArray *)getPendingNotifications;

/*
 * Database Read Operation
 */

-(NSMutableArray *) readFromMessageStream:(NSString *)guid;
-(NSMutableArray *) readFromStyle:(NSString * )guid;
-(Instruction *) readFromInstruction:(NSString * )guid;
-(NSArray *) readAllInstructionFromDatabase;
-(NSArray *) readAllNotification;
-(NSArray *) readAllImagesandDate;
-(NSString *) readNotificationTitles : (NSString *) guid;

/*
 * Database Update Operation
 */
-(void) updateInstruction:(NSString * ) guid aBool:(BOOL)aBool;
-(void) updateViewedNotification:(NSString *) guid;

/*
 * Database Delete Operation
 */
-(void) deletefromPending:(NSString * )guid;
-(void) deletefromInstructions:(NSString * ) guid;

@end
