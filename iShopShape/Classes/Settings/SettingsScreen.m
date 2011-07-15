//
//  SettingsScreen.m
//  iShopShape
//
//  Created by Santosh B on 05/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "SettingsScreen.h"
#import "DatabaseHandler.h"


@implementation SettingsScreen

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


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

- (void)viewDidLoad 
{
	tableTitlArray = [[NSArray alloc] initWithObjects:@"User Name", @"Reset", @"Logout", nil];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackground.png"]]];
	
	[self setTitle:@"Settings"];
	
	[settingTable setBackgroundColor:[UIColor clearColor]];
//	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//	if([userDefault valueForKey:@"STORE_NAME"])
//	{
//		[storeNameLbl setText:[userDefault valueForKey:@"STORE_NAME"]];
//	}
//	else {
//		[storeNameLbl setText:@"Amsterdam"];
//	}

	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
									   initWithTitle:@"Done" 
									   style:UIBarButtonItemStyleBordered
									   target:self
									   action:@selector(cancelButtonAction:)
									   ];
	[[self navigationItem] setRightBarButtonItem:settingsButton];
	[settingsButton release];
	
	[super viewDidLoad];
}


- (IBAction) cancelButtonAction : (id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[tableTitlArray release];
    [super dealloc];
}

- (IBAction) clearCacheButtonAction : (id)sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear Cache" message:@"Do you want to clear cache ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No" , nil];
	[alert show];
	[alert release];
}

- (IBAction) unregisterUserButtonAction : (id)sender
{	
	NSString *str = [NSString stringWithFormat:@"%@", UNREGISTER_USER_URL];
	NSURL *url = [NSURL URLWithString:str];
	HTTPServicePOSTHandlerObj = [[HTTPServicePOSTHandler alloc] autorelease];
	[HTTPServicePOSTHandlerObj unregisterUser:url];
	HTTPServicePOSTHandlerObj.delegate = self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		NSFileManager *fm = [NSFileManager defaultManager];
		
		NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
		NSArray *arr = [fm contentsOfDirectoryAtPath:documentsDirectory error:nil];
		//for(int iLoop =0; iLoop < [arr count]; iLoop++)
		for(NSString *fileName in arr)
		{
			NSString *newPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
			[fm removeItemAtPath:newPath error:nil];
		}
		[DatabaseHandler releaseIt];
		[DatabaseHandler sharedInstance];
		
	}
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{	
	return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section==1)
		return 18.0f;
	return 28.0f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *kCustomCellID = @"MyCellID";
	
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
		
	if (cell == nil) 
	{
		//cell = [[[CustomCalendarEvent alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
	}	
	
	//[tableTitlArray objectAtIndex:indexPath.row];
	if(indexPath.row == 0)
	{
		NSString *storeName = @"";
		NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
		if([userDefault valueForKey:@"STORE_NAME"])
		{
			storeName = [userDefault valueForKey:@"STORE_NAME"];
		}
		
		[cell.textLabel setText:[ NSString stringWithFormat:@"%@ : %@",[tableTitlArray objectAtIndex:indexPath.row], storeName]];
	}
	else {
		[cell.textLabel setText:[tableTitlArray objectAtIndex:indexPath.row]];
	}

	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(indexPath.row == 1)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear Cache" message:@"Do you want to clear cache ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No" , nil];
		[alert show];
		[alert release];
	}
	else if(indexPath.row ==2)
	{
		NSString *str = [NSString stringWithFormat:@"%@", UNREGISTER_USER_URL];
		NSURL *url = [NSURL URLWithString:str];
		HTTPServicePOSTHandlerObj = [[HTTPServicePOSTHandler alloc] autorelease];
		[HTTPServicePOSTHandlerObj unregisterUser:url];
		HTTPServicePOSTHandlerObj.delegate = self;
	}

}


#pragma mark -
#pragma mark HTTPServicePOSTHandlerDelegate
#pragma mark -

-(void) httpPOSTServiceFinish : (NSDictionary *)dict
{
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setValue:nil forKey:@"STORE_NAME"];
	[userDefault setValue:nil forKey:@"STORE_ID"];
	[userDefault setValue:nil forKey:@"USER_ID"];
	[userDefault synchronize];
	NSLog(@"POST ====== %@",dict);
}

-(void) httpPOSTServiceFinishWithError : (NSError *)error
{
	NSLog(@"POST ====== %@",[error description]);
}
@end
