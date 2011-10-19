//
//  xmlToDictionaryParserViewController.h
//  xmlToDictionaryParser
//
//  Created by Aneesh on 05/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xmlToDictionaryParserViewController : UIViewController<NSXMLParserDelegate> {
    
    NSMutableArray * arraySuperDictionary;
    NSMutableDictionary * currentDictionary;
    NSMutableDictionary * mainDictionary;
    NSString * prevElement;
   // NSString * firstTag;
    BOOL firstTagFlag;
    //NSMutableDictionary * dictionarySuperHierarchy;
   // NSMutableDictionary * superDictionary;
    BOOL cameFromEndElement;
    BOOL foundChar;
    BOOL flag;
    
     NSString * currentElement;
    NSMutableString * currentElementData;
}
-(NSMutableDictionary *)pop;
-(void)push:(NSMutableDictionary*)dictionaryToPush;
-(void) parseRssAtUrl:(NSString *) path;

@end
