//
//  Parser.h
//  iShopShape
//
//  Created by Santosh B on 03/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instruction.h"
#import "Notification.h"
@interface Parser : NSObject {

}
+ (Instruction *) parseInstructionDetails : (NSDictionary *)data;
+ (Notification *)parseNotificationDetails:(NSArray*)data;
+ (NSArray*)parseStoreList:(NSArray *)array;
@end
