//
//  xmlToDictionaryParserViewController.m
//  xmlToDictionaryParser
//
//  Created by Aneesh on 05/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "xmlToDictionaryParserViewController.h"

@implementation xmlToDictionaryParserViewController

- (void)dealloc
{
    [super dealloc];
}
-(void) parseRssAtUrl:(NSString *) path
{
  NSURL * url = [NSURL URLWithString:path];
    NSXMLParser * xmlParse = [[NSXMLParser alloc]initWithContentsOfURL:url ];
   // NSXMLParser *xmlParse = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"resp_selectcstemplate.xml"]]];
    [xmlParse setDelegate:self];
    [xmlParse parse];
    
}
-(NSDictionary *)pop
{
    NSDictionary * tempDict = [arraySuperDictionary objectAtIndex:([arraySuperDictionary count]-1)];
    [arraySuperDictionary removeObjectAtIndex:([arraySuperDictionary count]-1)];
    return tempDict;
}
-(void)push:(NSMutableDictionary *)dictionaryToPush
{
    if(arraySuperDictionary)
    {
        [arraySuperDictionary addObject:dictionaryToPush];
    }
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    arraySuperDictionary = [[NSMutableArray alloc] init];
    mainDictionary = [[NSMutableDictionary alloc] init];
    currentDictionary = mainDictionary;
    firstTagFlag = YES;
    flag = NO;
    foundChar = NO;
    cameFromEndElement = NO;
//    if([@"\n\t\t" hasPrefix:[NSString 
//    {
//        NSLog(@"Done");
//    }
//    NSString *string = @"spaces in front and at the end ";
//    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
//                               [NSCharacterSet characterSetWithCharactersInString:@" "]];
//    NSLog(@"%@",trimmedString);
    [self parseRssAtUrl:[NSString stringWithFormat:@"http://cyber.law.harvard.edu/rss/examples/sampleRss092.xml"]];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
//    if(firstTagFlag)
//    {
//        firstTag = elementName;
//        firstTagFlag = NO;
//    }
  
    if(foundChar == NO || cameFromEndElement == NO)
    {
       
      //  NSMutableDictionary * temp2 = superDictionary;
      //  superDictionary = currentDictionary;
        // [dictionarySuperHierarchy setObject:temp2 forKey:currentDictionary];//chngd...
        cameFromEndElement = NO;
        [self push:currentDictionary];
        currentDictionary = [[NSMutableDictionary alloc] init];
        flag = YES;
    }
    else
    {
        foundChar = NO;
        cameFromEndElement = NO;
       // flag = NO;
    }
    currentElement = [elementName copy];
    currentElementData = [[NSMutableString alloc] init];   
    
}
-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    if([trimmedString hasPrefix:@"\n"]||[trimmedString hasPrefix:@"\t"])
        {
            foundChar = NO;
        }
        else
        {
            if(foundChar == NO && cameFromEndElement == NO && flag == YES)
            {
                //NSMutableDictionary * temp3 = currentDictionary;
               
                currentDictionary = [self pop];
               // superDictionary = [dictionarySuperHierarchy objectForKey:currentDictionary];
                // [dictionarySuperHierarchy removeObjectForKey:currentDictionary];
                flag = NO;
            }
            [currentElementData appendString:string];
            foundChar = YES;
        }
    if([prevElement isEqualToString:currentElement])
    {
        foundChar = YES;
    }
    prevElement = currentElement;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if(foundChar)
    {
        [currentDictionary setObject:currentElementData forKey:[NSString stringWithFormat:@"%@",currentElement]];
        foundChar = NO;
    }
    else //array in array prb
    {
       // if(![elementName isEqualToString:firstTag])
        //{
        NSLog(@"%@",mainDictionary);
        if(!([[arraySuperDictionary objectAtIndex:[arraySuperDictionary count]-1] objectForKey:elementName]))
        {
            NSMutableDictionary * temp = currentDictionary;
            currentDictionary = [self pop];
            [currentDictionary setObject:temp forKey:elementName];
         //   NSLog(@"%@",arraySuperDictionary);
        
        }
        else if(([[arraySuperDictionary objectAtIndex:[arraySuperDictionary count]-1] objectForKey:elementName]))
        {
            NSMutableDictionary * tempDict = [self pop];
            if([[tempDict objectForKey:elementName]isKindOfClass:[NSMutableArray class] ])
            {
                NSMutableArray * temp = [tempDict objectForKey:elementName];
                [temp addObject:currentDictionary];
       
            }
            else
            {
                NSMutableDictionary *dict = [tempDict objectForKey:elementName];
                
                NSMutableArray * arr = [[NSMutableArray alloc] init];
                [arr addObject:dict];
                [arr addObject:currentDictionary];
                [tempDict setObject:arr forKey:elementName];
                
            }
                     currentDictionary = tempDict;
        }
      //  }
//        else
//        {
//            
//        }
        //set super dictionary if error is received

        
    }
    cameFromEndElement = YES;

   //  NSLog(@"%@",arraySuperDictionary);
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Parsing Started");
}
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error Ocurred: %@",parseError);
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Parsing Ended");
    NSLog(@"%@",mainDictionary);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
