//
//  FirstViewController.m
//  graphTest
//
//  Created by Yogesh Bhople on 30/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "GraphView.h"
#import "RawData.h"

@implementation FirstViewController



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
- (void)viewDidLoad {

	myArray = [[NSMutableArray alloc]init];
	
	RawData* obj = [[RawData alloc]init];
	
	obj.month  = 1;	
	NSMutableArray* weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:5 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:5 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	obj = [[RawData alloc]init];	
	obj.month  = 2;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:5 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:5 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	obj = [[RawData alloc]init];	
	obj.month  = 3;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:2 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	obj = [[RawData alloc]init];	
	obj.month  = 4;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:5 ]];
	[weekRate addObject:[NSNumber numberWithInt:2 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	
	obj = [[RawData alloc]init];	
	obj.month  = 5;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:1 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:4 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	
	obj = [[RawData alloc]init];	
	obj.month  = 6;	
	weekRate = [[NSMutableArray alloc]init];	
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];
	[weekRate addObject:[NSNumber numberWithInt:3 ]];		 
	obj.weekRatingData = weekRate;	
	[weekRate release];	
	[myArray addObject:obj];
	[obj release];
	
	CGRect curRect = [self.view frame];
	
	int width = curRect.size.width;//200;
	int ht = 200;//curRect.size.width;//curRect.size.height;//100;
	
	
	secArr = [[NSMutableArray alloc]init];
	[secArr addObject:[NSNumber numberWithInt:4 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:1 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:1 ]];
	
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:4 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	

	
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:4 ]];
	[secArr addObject:[NSNumber numberWithInt:2 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	
	[secArr addObject:[NSNumber numberWithInt:3 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:5 ]];
	[secArr addObject:[NSNumber numberWithInt:3 ]];
//////////////////////////////////////////////////////////////	
	firArr = [[NSMutableArray alloc]init];
	[firArr addObject:[NSNumber numberWithInt:5 ]];
	[firArr addObject:[NSNumber numberWithInt:3 ]];
	[firArr addObject:[NSNumber numberWithInt:2 ]];
	[firArr addObject:[NSNumber numberWithInt:1 ]];
	
	
	[firArr addObject:[NSNumber numberWithInt:3 ]];
	[firArr addObject:[NSNumber numberWithInt:3 ]];
	[firArr addObject:[NSNumber numberWithInt:3 ]];
	[firArr addObject:[NSNumber numberWithInt:3 ]];
	
	[firArr addObject:[NSNumber numberWithInt:5 ]];
	[firArr addObject:[NSNumber numberWithInt:5 ]];
	[firArr addObject:[NSNumber numberWithInt:5 ]];
	[firArr addObject:[NSNumber numberWithInt:5 ]];

	
	[firArr addObject:[NSNumber numberWithInt:1 ]];
	[firArr addObject:[NSNumber numberWithInt:1 ]];
	[firArr addObject:[NSNumber numberWithInt:1 ]];
	[firArr addObject:[NSNumber numberWithInt:1 ]];
	
	[firArr addObject:[NSNumber numberWithInt:2 ]];
	[firArr addObject:[NSNumber numberWithInt:2 ]];
	[firArr addObject:[NSNumber numberWithInt:2 ]];
	[firArr addObject:[NSNumber numberWithInt:2 ]];
	
	[firArr addObject:[NSNumber numberWithInt:4 ]];
	[firArr addObject:[NSNumber numberWithInt:4 ]];
	[firArr addObject:[NSNumber numberWithInt:4 ]];
	[firArr addObject:[NSNumber numberWithInt:4 ]];
	gpRect = CGRectMake(0,20,width,ht);
	
	vw = [[GraphView alloc]initWithFrame:CGRectMake(0,20,width,ht) graphdata:myArray CountryName:@"South Africa NA" Rating:5 secongraph:secArr];
	[self.view addSubview:vw];
	
    [super viewDidLoad];
}

-(void) reload:(int) choice
{
	
	[vw removeFromSuperview];
	
	if (choice == 1) {
//		[vw setSecondGraphArray:firArr];
//		//[vw drawRect:self.view.frame];
//		[vw setNeedsDisplay];
		vw = [[GraphView alloc]initWithFrame:gpRect graphdata:myArray CountryName:@"South Africa NA" Rating:5 secongraph:firArr];
		[self.view addSubview:vw];
	}else {
//		[vw setSecondGraphArray:secArr];
//		//[vw drawRect:self.view.frame];
//		[vw setNeedsDisplay];
		vw = [[GraphView alloc]initWithFrame:gpRect graphdata:myArray CountryName:@"South Africa NA" Rating:5 secongraph:secArr];
		[self.view addSubview:vw];
	}

}

 //Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations
//	if (interfaceOrientation !=UIInterfaceOrientationPortrait) {
//		return TRUE;
//	} else {
//		return FALSE;
//	}
//	
//}

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


- (void)dealloc {
	[myArray release];
	[firArr release];
	[secArr release];
	[vw release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	//NSLog(@"Inside numberOfSectionsInTableView");
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog(@"Inside numberOfRowsInSection");
	//NSLog(@"ROW COUNT: %d",rowCount);
    return 2;
	
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return 70;
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	//NSLog(@"Inside cellForRowAtIndexPath");
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];//[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		[cell setText:@"asda"];
		[cell setTextColor:[UIColor redColor]];
	//	ResourceStore* resource = (ResourceStore*)[resList objectAtIndex:indexPath.row];
		
	//	cell = [[[ResourceCell alloc] initWithResource:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier resourceObject:resource ] autorelease];
		//[cell.textLabel setText:resource.empname];
		
		//cell.backgroundColor = [UIColor redColor];
		
		
		//NSLog(resource.empname);
    }
    
    // Configure the cell...
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	[self reload:indexPath.row];


}

@end
