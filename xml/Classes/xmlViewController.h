//
//  xmlViewController.h
//  xml
//
//  Created by Ayush on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ModelTip.h"
@protocol TipCalculatorParserDelegate 

@required
- (void)responseFromXmlParser:(BOOL)isError ArrayData:(NSMutableArray *)data;
@end

@interface xmlViewController :UIViewController <NSXMLParserDelegate>
{
	NSXMLParser *xmlParser; 
	ModelTip *parsedVal;
	id mDelegate;
	NSMutableArray *tipDetailArr;
	NSString *cName;
	double percentVal;
	BOOL xmlError;

}
@property(nonatomic, retain) id delegate;
@property(nonatomic, retain) NSMutableArray *tipDetailArr;

//-----------------------------------------------------------------------------------------------------------------------------
//method for getting the XML file for tip Details and send it for parsing
//-----------------------------------------------------------------------------------------------------------------------------
-(id)initWithTipDetails;
@end


