//
//  InstructionsScreen.m
//  iShopShape
//
//  Created by Santosh B on 15/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "InstructionsScreen.h"
#import "InstructionsCutomCell.h"
#import "InstructionDetailsScreen.h"
#import "NSMutableArray(Reverse).h"
#import "DatabaseHandler.h"
#import "Instruction.h"
#import "Product.h"
#import "Logger.h"
#import "Parser.h"



@implementation InstructionsScreen
@synthesize instructionsTable;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[self setTitle:@"Instructions"];

	instructionList = (NSMutableArray *)[[NSMutableArray alloc] init];

	NSArray *array = [[DatabaseHandler sharedInstance] getPendingInstructions];

	//for(int iLoop=0; iLoop < [array count]; iLoop++)
	for(NSString *instructionId in array)
	{
		[activityIndicator startAnimating];
		//[self getInstructionDetailsFromServer:[array objectAtIndex:iLoop]];
		[self getInstructionDetailsFromServer:instructionId];
	}
	[self loadInstructionFromLocalDatabase];
    [super viewDidLoad];
}

- (void) loadInstructionFromLocalDatabase
{
	NSMutableArray *array = (NSMutableArray*)[[DatabaseHandler sharedInstance] readAllInstructionFromDatabase];
	
	//for(int iLoop = 0 ; iLoop < [array count]; iLoop++)
	for(Instruction *instruction in array)
	{
		//Instruction *instruction = [array objectAtIndex:iLoop];
		NSArray *styleId = [[DatabaseHandler sharedInstance] readFromStyle:instruction.instId];
		instruction.styleProductArray = styleId;
	}
	
	if(array && [array count])
	{
		[array reverse];
	}
	[(NSMutableArray *)instructionList addObjectsFromArray:array];
	[instructionsTable reloadData];
	[activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	NSLog(@"InstructionsScreen ------------- Release");
	[instructionList release];
	[instructionsTable release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{	
	return [instructionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	static NSString *identifier =@"HOME_MENU";
	
	InstructionsCutomCell *cell = (InstructionsCutomCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(nil == cell)
	{
		cell =[[[InstructionsCutomCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	
	Instruction *instruction = [instructionList objectAtIndex:indexPath.row];

	[cell setCellData:instruction];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	InstructionDetailsScreen *instructionDetailsScreen = [[InstructionDetailsScreen alloc] initWithNibName:@"InstructionDetailsScreen" bundle:[NSBundle mainBundle] instruction:[instructionList objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:instructionDetailsScreen animated:YES];
	[instructionDetailsScreen release];
}


#pragma mark -
- (void) getInstructionDetailsFromServer : (NSString *)instructionID
{	
	NSString *urlString = [NSString stringWithFormat:@"%@%@", INSTRUCTION_DETAILS_URL, instructionID];//@"11111111-1111-1111-1111-111111111111"];
	NSLog(@"URLSTRING %@", urlString);
	NSURL *url = [NSURL URLWithString:urlString];
	HTTPServiceHandler *HTTPServiceHandlerObj = [[HTTPServiceHandler alloc] autorelease];
	[HTTPServiceHandlerObj initWithRequest:url];
	HTTPServiceHandlerObj.delegate = self;
}

- (void) stopActivityIndicator
{
	[activityIndicator stopAnimating];
	[instructionsTable reloadData];
}


#pragma mark -
- (void) insertInstructionToDatabase : (Instruction *)instruction
{
	[[DatabaseHandler sharedInstance] insertInstructions:instruction];
	
	[[DatabaseHandler sharedInstance] insertStyle:instruction.instId styleArray:instruction.styleProductArray];
	
	[[DatabaseHandler sharedInstance] deletefromPending:instruction.instId];
	//[[DatabaseHandler sharedInstance] read
}
#pragma mark -
#pragma mark HTTPServiceHandlerDelegate
#pragma mark -
-(void) httpServiceFinish : (NSDictionary *)dict
{
	if(dict)
	{
		Instruction *instruction = [Parser parseInstructionDetails:dict];
		//[(NSMutableArray *)instructionList addObject:instruction];
		[(NSMutableArray *)instructionList insertObject:instruction atIndex:0];
		[self performSelectorOnMainThread:@selector(insertInstructionToDatabase:) withObject:instruction waitUntilDone:NO];
	}
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
}

-(void) httpServiceFinishWithError : (NSError *)error
{
	NSString *message = [[NSString alloc] initWithFormat:@" %@ - %@",DEBUG_MESSAGE, [error description]];
	[Logger writeMessage:DEBUG message:message];
	[message release];
	
	[self performSelectorOnMainThread:@selector(stopActivityIndicator) withObject:nil waitUntilDone:NO];
}
@end
