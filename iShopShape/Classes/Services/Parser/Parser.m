//
//  Parser.m
//  iShopShape
//
//  Created by Santosh B on 03/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "Parser.h"
#import "JSON.h"
#import "Product.h"

@implementation Parser

+ (NSArray *)parseStyleArray : (NSArray *)aStyle
{	
	NSArray *styleArray = [[NSMutableArray alloc] init];

	@try {

		//for(int iLoop = 0; iLoop < [aStyle count]; iLoop++)
		for(NSDictionary *aStyleDict in aStyle)
		{
			//NSDictionary *aStyleDict = [aStyle objectAtIndex:iLoop];
			Product *product = [[Product alloc] init];
			product.hotspotNumber = [[aStyleDict valueForKey:@"hotspotnumber"] intValue];
			
			NSDictionary *productDict = [aStyleDict valueForKey:@"product"];
			
			product.productCode = [[productDict valueForKey:@"Product_Id"] stringValue];
			NSLog(@"Product_Id =%@", product.productCode);
			
			product.productName = [productDict valueForKey:@"Product_Name"];
			NSLog(@"Product_Name =%@", product.productName);

			product.thumbnailImageName = [productDict valueForKey:@"Product_Path"];
			NSLog(@"Product_Path =%@", product.thumbnailImageName);
			
			
			product.quantity = [[aStyleDict valueForKey:@"quantity"] intValue];
			NSLog(@"Quantity =%d", product.quantity);
			
			product.xCoordinater = [[aStyleDict valueForKey:@"xcordinate"] floatValue];
			
			product.yCoordinater = [[aStyleDict valueForKey:@"ycordinate"] floatValue];
			
			[(NSMutableArray *)styleArray addObject:product];
			[product release];
		}
	}
	@catch (NSException * e) {
		
	}
	
	return [styleArray autorelease];
}

#pragma -
#pragma mark ParserInstructionDetails
#pragma mark -
+ (Instruction *) parseInstructionDetails : (NSDictionary *)data
{
	Instruction *instruction = [[Instruction alloc] init];
	
	NSDictionary *result = data;
	@try
	{
		if(result)
		{
			if([result valueForKey:@"instructionid"] != [NSNull null])
			{
				instruction.instId = [result valueForKey:@"instructionid"];
				NSLog(@"Instruction_Id =%@", instruction.instId);
			}
			
			if([result valueForKey:@"title"] != [NSNull null])
			{
				instruction.title = [result valueForKey:@"title"];
				NSLog(@"Title =%@", instruction.title);
			}
			
			if([result valueForKey:@"description"] != [NSNull null])
			{
				instruction.description = [result valueForKey:@"description"];
				NSLog(@"Description =%@", instruction.description);
			}
			
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"dd/MM/yyyy"];
			
			[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			//NSLog(@"Start_Date==%@", [result valueForKey:@"Start_Date"]);
			
			if([result valueForKey:@"startdate"] != [NSNull null])
			{
				NSDate *date = [dateFormatter dateFromString:[result valueForKey:@"startdate"]];
			
				[dateFormatter setDateFormat:@"eee,MMM dd,yyyy"];
				NSString *date1 = [dateFormatter stringFromDate:date];
			
				instruction.startDate = date1;
				NSLog(@"Start_Date =%@", instruction.startDate);
			}
			
			if([result valueForKey:@"enddate"]!= [NSNull null])
			{
				[dateFormatter setDateFormat:@"dd/MM/yyyy"];
				[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
				NSDate * date = [dateFormatter dateFromString:[result valueForKey:@"enddate"]];
				[dateFormatter setDateFormat:@"eee,MMM dd,yyyy"];
				NSString *date1 = [dateFormatter stringFromDate:date];
				
				instruction.endDate = date1;
				NSLog(@"enddate =%@", instruction.endDate);
			}
			
			instruction.isExecuted = NO;
			
			if([result valueForKey:@"imgpath"] != [NSNull null])
			{
				instruction.instructionImage = [result valueForKey:@"imgpath"];
				NSLog(@"imgpath =%@", instruction.instructionImage);
			}
			
			NSArray *arr = [result valueForKey:@"productlist"];
			
			if(arr && [arr count])
			{
				NSArray *styleArray = [Parser parseStyleArray:arr];
			
				if([styleArray count])
				{
					instruction.styleProductArray = styleArray;
				}
			}
			
			[dateFormatter release];
		}
	}
	@catch (NSException *e) {
		
	}
	return [instruction autorelease];
}

#pragma -
#pragma mark ParserNotificationDetails
#pragma mark -

+ (Notification *)parseNotificationDetails:(NSArray*)data
{
	//{"Image":"jkslj","Message":"ok good work done","NotificationID":"a5663b6d-8a7c-4a34-a467-8f9b64417bf0"}
	
	//for(int iLoop =0 ; iLoop < [data count]; iLoop++)
	for(NSDictionary *result in data)
	{
		Notification *notification = [[Notification alloc] init];
		
		//NSDictionary *result = [data objectAtIndex:iLoop];
		@try
		{
			if(result)
			{
				if([result valueForKey:@"notificationid"])
				{
					notification.notificationId = [result valueForKey:@"notificationid"];
				}
				
				if([result valueForKey:@"message"])
				{
					notification.notificationTitle = [result valueForKey:@"message"];
				}
				if([result valueForKey:@"imageurl"])
				{
					notification.notificationImage = [result valueForKey:@"imageurl"];
				}
				notification.position = 1;
			}
			return [notification autorelease];
		}
		@catch (NSException *exception) 
		{
			[notification release];
			NSLog(@"Error to parse - parseNotificationDetails - %@", [exception description]);
		}
	}
	return nil;
	
}

#pragma mark -
#pragma mark StorListParser
#pragma mark -
+ (NSArray*)parseStoreList:(NSArray *)array
{
	NSArray *storeList = [[NSMutableArray alloc] init];
	//for(int iLoop =0 ; iLoop < [array count]; iLoop++)
	for(NSDictionary *result in array)
	{
		//NSDictionary *result = [array objectAtIndex:iLoop];
		NSLog(@"WebService - Response Result ===== %@", result);
		@try
		{
			
			NSString *key = nil;
			NSString *value = nil;
			if(result)
			{
				if([result valueForKey:@"storeid"])
				{
					key = [result valueForKey:@"storeid"];
				}
				
				if([result valueForKey:@"storename"])
				{
					value = [result valueForKey:@"storename"];
				}
				NSDictionary *dict = [[NSMutableDictionary alloc] init];
				[(NSMutableDictionary*)dict setObject:value forKey:key];
				[(NSMutableArray*)storeList addObject:dict];
			}
			
		}
		@catch (NSException *exception) 
		{
			NSLog(@"Error to parse - parseStoreList - %@", [exception description]);
		}
	}
	return [storeList autorelease];
}
@end
