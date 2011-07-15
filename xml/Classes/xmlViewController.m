//
//  xmlViewController.m
//  xml
//
//  Created by Ayush on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "xmlViewController.h"
#import "ModelTip.h"
@implementation xmlViewController
@synthesize delegate = mDelegate; 
@synthesize tipDetailArr;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(id) initWithTipDetails
{
	self = [super init];
	if(self != nil)
	{
		self.tipDetailArr = [[NSMutableArray alloc] initWithCapacity:6];
		
		if (xmlParser)
		{
			[xmlParser release];
		}
		xmlParser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TipDetails.xml"]]];
		[xmlParser setDelegate:self];
		[xmlParser setShouldResolveExternalEntities:YES];
		[xmlParser parse];
		[xmlParser release];
	}
	return self;
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self initWithTipDetails];
	NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"books.xsd"];
	NSLog(@"path =-===== %@",filePath);
	
	/*
	 <Target Name="Generate_XSD_Schema" Condition=" '$(BuildType)' != 'Clean' "
	Inputs="$/Users/ayush/desktop/book.xsd;"
	Outputs="/Users/ayush/desktop/newfile.h">
	<Exec Command="xsd $(SourcesPath)file.xsd /c /l:CPP /o:$(SourcesPath)Gen"  ContinueOnError="false" />
	</Target>
	 */

	< Target Name="Generate_XSD_Schema" Condition=" '$(BuildType)' != 'Clean' "
	Inputs="$(SourcesPath)\file.xsd;"
	Outputs="$(SourcesPath)Gen\file.h">
	<Exec Command="xsd $(SourcesPath)file.xsd /c /l:CPP /o:$(SourcesPath)Gen"  ContinueOnError="false" />
	</Target>
	
    [super viewDidLoad];
}

#pragma mark XML Parsing methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if([elementName isEqualToString:@"Country"])
	{
		cName = [attributeDict valueForKey:@"Name"];
	}
	if([elementName isEqualToString:@"Tip"])
	{
		parsedVal = [[ModelTip alloc] init];
		parsedVal.countryName = cName;
		parsedVal.category = [attributeDict valueForKey:@"Category"];
	}		
}
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
	percentVal = [string doubleValue];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if([elementName isEqualToString:@"Tip"])
	{
		[tipDetailArr addObject:parsedVal ];
		[parsedVal release];
		parsedVal = nil;
		
	}
	if([elementName isEqualToString:@"TipDetails"])
	{
		xmlError = YES;
		[self.delegate responseFromXmlParser:xmlError ArrayData:tipDetailArr];
		xmlError = NO;
		
	}
	if([elementName isEqualToString:@"MinimumValue"])
	{
		parsedVal.minVal = percentVal; 
	}
	if([elementName isEqualToString:@"MaximumValue"])
	{
		parsedVal.maxVal = percentVal;
	}
	if([elementName isEqualToString:@"DefaultValue"])
	{
		parsedVal.defVal = percentVal;
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
