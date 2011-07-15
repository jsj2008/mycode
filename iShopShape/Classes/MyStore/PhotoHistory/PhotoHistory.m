//
//  PhotoHistory.m
//  iShopShape
//
//  Created by Santosh B on 03/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "PhotoHistory.h"
#import "PhotoViewController.h"
#import "PhotoHistoryCountCell.h"
@implementation PhotoHistory

#pragma mark -
#pragma mark View lifecycle

@synthesize pics;
@synthesize sortedArrayPic;
@synthesize picDictionary;
@synthesize sortedPicDicKey;

#pragma mark -
#pragma mark View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil picArray:(NSMutableArray*)pictures{
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
	 self.pics = pictures;
 }
 return self;
 }



//-(id)initwithPicsArray:(NSMutableArray *)pictures
//{	
//	self.pics = pictures;
//	return self;
//}

-(float)weekno:(NSDate *)from and:(NSDate *)end
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *components = [gregorian components:NSDayCalendarUnit
												fromDate:from
												  toDate:end
												 options:0];
	NSInteger days = [components day];  
	days=days+1;
	[gregorian release];
	float weeknumber=(float)days/7+1;
	return weeknumber;
	
}

- (void)viewDidLoad {
	

	//self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	[self setDate];
	NSLog(@"date =%@",refdate);
	
	
	if([self.pics count])
	{	
		
		
		NSSortDescriptor *sortDescriptor;
		
		sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"imageDate"ascending:YES] autorelease];
		
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];	
		
		sortedArrayPic = [[NSArray alloc]initWithArray:[self.pics sortedArrayUsingDescriptors:sortDescriptors] ];//aray of sorted image by date
		
		picDictionary = [[NSMutableDictionary alloc] init];	//dictionary where imgae is stored week wise
		
		
		NSDate *tempdate = [[sortedArrayPic objectAtIndex:0] imageDate];
		int startweekno=[self weekno:refdate and:tempdate];
		
		tempdate = [[sortedArrayPic objectAtIndex:[sortedArrayPic count]-1] imageDate];
		int endweekno=[self weekno:refdate and:tempdate];
		
		
		NSMutableArray *imgObjArrayForKey;
		
		for (int i = startweekno; i <= endweekno; i++) 
		{
			imgObjArrayForKey = [self arrayOfImageForWeek:i];
			
			if ([imgObjArrayForKey count] > 0) 
			{	
				[picDictionary setObject:imgObjArrayForKey forKey:[NSNumber numberWithInt:i]];
			}
		}
		
		//NSLog(@"pics Dictionary %@",picDictionary);		//dictionary recieved
		
		NSArray * picDicKey = [picDictionary allKeys];		//@selector(sortedArrayUsingSelector:) for nsstring
		
		sortedPicDicKey = [[NSArray alloc]initWithArray:[picDicKey sortedArrayUsingSelector:@selector(compare:)]];	///
	}
	//[nameLabel setText:[NSString stringWithFormat:@"%d photos", [sortedArrayPic count]]];
	[photoHistoryTableView setSeparatorColor:[UIColor clearColor]];
    [super viewDidLoad];
	
}

//to get the array of immage for given month

-(void) setDate
{
	
	refdate = [NSDate date];//arbitary date
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:refdate];
	
	[comp setDay:1];
	
	[comp setMonth:1];
	
	refdate = [gregorian dateFromComponents:comp];
	
	int weekday=[self weekday:refdate];
	
	comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:refdate];
	
	comp.day=1-weekday+2;
	
	[comp setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	refdate = [gregorian dateFromComponents:comp];
	NSLog(@"REF DATE %@", refdate);
	[gregorian release];
	
	
}

-(NSMutableArray *)arrayOfImageForWeek:(int)week{
	
	
    NSDate *firstDayOfWeek;
	
	NSDate *lastDayOfWeek;
	
	firstDayOfWeek = [NSDate dateWithTimeInterval:((week-1) * 7 * 24 *3600) sinceDate:refdate];
	
	lastDayOfWeek = [NSDate dateWithTimeInterval:(week * 7 * 24 *3600) sinceDate:refdate];
	
	return [self arrayOfImageFrom:firstDayOfWeek till:lastDayOfWeek];
	
}

-(NSInteger )weekday:(NSDate *)from
{
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit fromDate:from];
	
	NSInteger weekdays = [components weekday]; 
	
	[gregorian release];
	
	return weekdays;
	
}



-(NSMutableArray *)arrayOfImageFrom:(NSDate *)fromdate till:(NSDate *)tilldate{
	
	NSMutableArray * picOfWeek = [[NSMutableArray alloc]init];
	
	for (int i = 0; (i < [sortedArrayPic count]); i++) 
	{
		
		if ( ([fromdate compare:[[sortedArrayPic objectAtIndex:i] imageDate]] == NSOrderedAscending ||
			  [fromdate compare:[[sortedArrayPic objectAtIndex:i] imageDate]] == NSOrderedSame)
			&& ([[[sortedArrayPic objectAtIndex:i] imageDate] compare:tilldate] == NSOrderedAscending ||
				[[[sortedArrayPic objectAtIndex:i] imageDate] compare:tilldate] == NSOrderedSame) ){
				
				[picOfWeek addObject:[sortedArrayPic objectAtIndex:i]];
			}
		
	}
	return [picOfWeek autorelease] ;
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	int numberOfWeek = [sortedPicDicKey count];
	return numberOfWeek;
	
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(section == [sortedPicDicKey count]-1)
	{
		return 2;
	}
	return 1;
	
}

//tittle for footer and header of section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [NSString stringWithFormat:@"Week %@, 2011", [sortedPicDicKey objectAtIndex:section] ];	
}

// Customize the appearance of table view cells.


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	static NSString *lastIdentifier = @"COUNT";
	int indexpathSection = indexPath.section;
	
	
	NSMutableArray *arrayOfImg = [picDictionary objectForKey:[sortedPicDicKey objectAtIndex:indexpathSection]];
	
	if(indexPath.section != [sortedPicDicKey count]-1)
	{
		NSLog(@"%d %d", indexPath.section, indexPath.row);
		
		CostumCell *cell = (CostumCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if(nil == cell)
		{
			cell = [[[CostumCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:CellIdentifier 
									   withImageArray:arrayOfImg withkey:[[sortedPicDicKey objectAtIndex:indexpathSection]intValue]] autorelease];
		}
		[cell setCellData:arrayOfImg withKey:[[sortedPicDicKey objectAtIndex:indexpathSection]intValue]];
		
		[cell setDelegate:self];
		
		return cell;
	}
	else //if(indexPath.section != [sortedPicDicKey count]-1 && indexPath.row == 1)
	{
		switch (indexPath.row) {
			case 0:
			{
				CostumCell *cell = (CostumCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				
				if(nil == cell)
				{
					cell = [[[CostumCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:CellIdentifier 
											   withImageArray:arrayOfImg withkey:[[sortedPicDicKey objectAtIndex:indexpathSection]intValue]] autorelease];
				}
				[cell setCellData:arrayOfImg withKey:[[sortedPicDicKey objectAtIndex:indexpathSection]intValue]];
				
				[cell setDelegate:self];
				
				return cell;
				}
				break;
			case 1:
			{
				PhotoHistoryCountCell *countCell = (PhotoHistoryCountCell*)[tableView dequeueReusableCellWithIdentifier:lastIdentifier];
				if(nil == countCell)
				{
					countCell = [[[PhotoHistoryCountCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:lastIdentifier total:[sortedArrayPic count]] autorelease];
					if(totalTableHeight<500)
					{
						[countCell.countLable setHidden:YES];
					}
				}
				return countCell;
			}
		}

	}

	return nil;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSMutableArray * arrayOfPicAtIndex = [picDictionary objectForKey:[sortedPicDicKey objectAtIndex:indexPath.section]];
	int x = [arrayOfPicAtIndex count];
	
	int ceilling;	//to get the number of IMAGE rows
	
	if ((x % 4) == 0) {
		ceilling = x/4;
	}
	else {
		ceilling =( x/4 +1 );
	}
	
	totalTableHeight += ceilling *85;
	return ceilling	* 85;
	
	
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

#pragma mark -
#pragma mark CostumCellImageTouchEvent

- (void) CostumCellImageTouchEvent: (int)aIndex weekKey : (int)weekKey	//add new imagelib View here
{
	
	NSLog(@"weekno = %d, indexno = %d",weekKey,aIndex);
	//calucalte the index no in the main array
	int count = 0;
	int iloop = 0;
	
	while (weekKey != [[sortedPicDicKey objectAtIndex:iloop]intValue]) 
	{
		count = count + [ [picDictionary objectForKey:[sortedPicDicKey objectAtIndex:iloop]] count];
		iloop++;
	}
	count = count + aIndex;
	NSLog(@"count ==  %d", count);
	
	PhotoViewController *imageLibrary = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:[NSBundle mainBundle] imageArray :sortedArrayPic index:count];
	[self.navigationController pushViewController:imageLibrary animated:YES];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	//[self.navigationController setHidesBottomBarWhenPushed:YES];
	[imageLibrary release];
	
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
	NSLog(@"Photo History ------------------------- Release");
	
	[pics release];
    
	[super dealloc];
	
}


@end
