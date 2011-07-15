//
//  FilwHandlerSampleViewController.m
//  FilwHandlerSample
//
//  Created by Santosh on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FilwHandlerSampleViewController.h"

@implementation FilwHandlerSampleViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSString *) getFilePath 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	return [documentsDirectoryPath stringByAppendingPathComponent:@"Myfile.txt"];
}

- (NSString *) getNewFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	return [documentsDirectoryPath stringByAppendingPathComponent:@"Myfilecopy.txt"];
}

- (NSString *) getMovedFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	return [documentsDirectoryPath stringByAppendingPathComponent:@"MyfileMoved.txt"];
}

- (void) fileChangeAttributes
{
	NSFileManager *manager = [NSFileManager defaultManager];
	NSString *logFilePath =[self getFilePath];
	
	NSDictionary *newAttributes;
	NSError *error;
	newAttributes = [NSDictionary dictionaryWithObject:[NSNumber  numberWithBool:YES]
												forKey:NSFileExtensionHidden];
	[manager setAttributes:newAttributes
							ofItemAtPath:logFilePath error:&error];
	
	if(!error)
	{
		NSLog(@"Attribute Changed..........");
	}
}

- (IBAction) changeAttribute :(id) sender
{
	[self fileChangeAttributes];
}

- (IBAction) getFileAttribute : (id)sender
{
	NSLog(@"******************* File Attributes  *******************");
	NSFileManager *manager = [NSFileManager defaultManager];
	NSString *logFilePath =[self getFilePath];
	NSDictionary *dict = [manager attributesOfItemAtPath:logFilePath error:nil];
	
	NSLog(@"%@", dict);
	
	if([manager isReadableFileAtPath:logFilePath])
	{
		NSLog(@"Readable");
	}
	else {
		NSLog(@"Not Readable");
	}
	if([manager isExecutableFileAtPath:logFilePath])
	{
		NSLog(@"Executable");
	}
	else {
		NSLog(@"Not Executable");
	}
	if([manager isWritableFileAtPath:logFilePath])
	{
		NSLog(@"Writeable");
	}
	else {
		NSLog(@"Not Writeable");
	}
	
	/////
	[self seekFile];
	
}

- (IBAction) copyFile : (id)sender
{
	NSLog(@"******************* Copy File *******************");
	NSString *logfile = [self getFilePath];
	NSString *newfile = [self getNewFilePath];
	
	NSFileManager *manager = [NSFileManager defaultManager];
	
	NSError *error = nil;
	[manager copyItemAtPath:logfile toPath:newfile error:&error];
	if(!error)
	{
		NSLog(@"Successfully copied the file to new location == \n %@", newfile);
	}
	else
	{
		NSLog(@"Error to copy : %@", [error description]);
	}
}


- (IBAction) moveFile : (id)sender
{
	NSLog(@"******************* Move File *******************");
	NSString *logfile = [self getFilePath];
	NSString *newfile = [self getMovedFilePath];
	
	NSFileManager *manager = [NSFileManager defaultManager];
	
	NSError *error = nil;
	[manager moveItemAtPath:logfile toPath:newfile error:&error];
	if(!error)
	{
		NSLog(@"Successfully movied the file to new location == \n %@", newfile);
	}
}

- (IBAction) deleteFile : (id) sender
{
	NSLog(@"******************* Delete File *******************");
	NSString *logfile = [self getFilePath];
	
	NSFileManager *manager = [NSFileManager defaultManager];
	
	//check - log file exist
	if([manager fileExistsAtPath:logfile])
	{
		NSLog(@"File Exist - Delete it");
		NSError *error = nil;
		[manager removeItemAtPath:logfile error:&error];
		if(error)
		{
			NSLog(@"%@", error);
		}
	}
	
}

- (void) seekFile
{
	NSFileHandle *file;
	NSString *logfile = [self getFilePath];
	file = [NSFileHandle fileHandleForUpdatingAtPath:logfile];
	
	if (file == nil)
        NSLog(@"Failed to open file");
	
	NSLog (@"Offset = %llu", [file offsetInFile]);
	
	[file seekToEndOfFile];
	
	NSLog (@"Offset = %llu", [file offsetInFile]);
	
	[file seekToFileOffset: 30];
	
	NSLog (@"Offset = %llu", [file offsetInFile]);
	
	[file closeFile];
	
}

- (IBAction)createFile : (id)sender
{
	NSLog(@"******************* Create File *******************");
	NSFileManager *manager = [NSFileManager defaultManager];

	NSString *logFilePath =[self getFilePath];
	
	if(![manager fileExistsAtPath:logFilePath])
	{
		NSLog(@"Create it.........");
		[manager createFileAtPath:logFilePath contents:nil attributes:nil];
		NSLog(@"File Path : %@",logFilePath);
	}

}

- (IBAction) writeToFile :(id) sender
{
	NSLog(@"******************* Write to file *******************");
	NSString *logFilePath =[self getFilePath];
	NSFileHandle *fileHandler = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
	
	if(!fileHandler)
	{
		return;
	}
	
	[fileHandler seekToEndOfFile];
	
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	[format setDateFormat:@"dd MMM yyyy"];
	
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	[timeFormat setDateFormat:@"HH:mm:ss:ms"];
	
	NSDate *now = [[NSDate alloc] init];
	
	NSString *theDate = [format stringFromDate:now];
	
	NSString *theTime = [timeFormat stringFromDate:now];
	
	NSString *completeMessage = [[NSString alloc] initWithFormat:@"\nSantosh ===%s - %s", [theDate UTF8String], [theTime UTF8String]];		
	NSData *data = [completeMessage dataUsingEncoding:NSASCIIStringEncoding];
	
	[fileHandler writeData:data];
	
	[fileHandler closeFile];
	
}


- (IBAction) readToFile : (id)sender
{
	NSLog(@"******************* Read File *******************");
	NSString *logFilePath =[self getFilePath];

	NSFileHandle *fileHandler = [NSFileHandle fileHandleForReadingAtPath:logFilePath];
	if(!fileHandler)
	{
		return;
	}
	
	[fileHandler seekToEndOfFile];
	int totalFileLength = [fileHandler offsetInFile];
	[fileHandler seekToFileOffset:0];
	NSData *data = [fileHandler readDataOfLength:totalFileLength];
	
	unsigned char aBuffer[[data length]];
	[data getBytes:aBuffer length:[data length]];
	NSLog(@"%s\n", aBuffer);
	
	[fileHandler closeFile];
	
}

/*
 
 Working with Plist files
 */


#pragma mark -
#pragma mark MAP SETTINGS
#pragma mark -


- (IBAction) readPlistFile: (id)sender
{
	[self getPlistFileSettings];
}

- (IBAction) writePlistFile : (id)sender
{
	static int iCount = 0;
	NSString *stringValue = [NSString stringWithFormat:@"Value_%d",iCount];
	NSString *stringKey = [NSString stringWithFormat:@"Key%d",iCount];
	[self setPlistFileSettings:stringValue key:stringKey];
	iCount++;
}
/**
 *	@functionName	: getMapSettings
 *	@parameters		: void
 *	@return			: NSMutableDictionary
 *	@description	: This method return the map settings dictionary.
 */

- (NSMutableDictionary *) getPlistFileSettings
{	
	
	NSLog(@"******************* Read Plist File *******************");
	NSMutableDictionary *values = nil;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:@"MySettings.plist"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if([fileManager fileExistsAtPath:path])
	{
		values = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		
		NSLog(@"Values == %@", values);
	}
	else {
		[fileManager createFileAtPath:path contents:nil attributes:nil];
	}


	return values;
}

/**
 *	@functionName	: setMapSettings
 *	@parameters		: (id) value
 *					  (NSString *)key
 *	@return			: void
 *	@description	: This method set the map settings.
 */

- (void) setPlistFileSettings : (id) value key:(NSString *)key
{
	NSLog(@"******************* Write Plist File *******************");
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:@"MySettings.plist"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSMutableDictionary *values = nil;
	
	if([fileManager fileExistsAtPath:path])
	{
		values = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		if(!values)
		{
			values = [[NSMutableDictionary alloc] init];
		}
		[values setObject:value forKey:key];
		
		[values writeToFile:path atomically:YES];
		
		[values release];
		values =  nil;
	}
}


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
