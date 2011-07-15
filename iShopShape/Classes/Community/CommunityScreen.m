//
//  CommunityScreen.m
//  iShopShape
//
//  Created by Santosh B on 23/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import "CommunityScreen.h"


@implementation CommunityScreen

@synthesize communityTable;
@synthesize storeArray;



- (void)viewDidLoad {
	[self setTitle:@"Stores"];
	storeArray = [[NSMutableArray alloc]init];	//array of store
	
	[self generateStoreDummyData];
	
    [super viewDidLoad];
}

- (void) generateStoreDummyData
{
	NSMutableArray *storeImageObjArray = [[NSMutableArray alloc]init];		//array of storeimageobj
	
//	StoreImageObj *imageObj = [[StoreImageObj alloc]initWithImageName:@"376" onDate:[self stringToDate:@"01-01-2011"]];
//	[storeImageObjArray addObject:imageObj];
//	[imageObj release];
//	
//	imageObj = [[StoreImageObj alloc]initWithImageName:@"383" onDate:[self stringToDate:@"02-02-2011"]];
//	[storeImageObjArray addObject:imageObj];
//	[imageObj release];
//	
//	imageObj = [[StoreImageObj alloc]initWithImageName:@"405" onDate:[self stringToDate:@"04-02-2011"]];
//	[storeImageObjArray addObject:imageObj];
//	[imageObj release];
//	
//	imageObj = [[StoreImageObj alloc]initWithImageName:@"065" onDate:[self stringToDate:@"012-02-2011"]];
//	[storeImageObjArray addObject:imageObj];
//	[imageObj release];
//	
//	StorePhotoInfo *store = [[StorePhotoInfo alloc]initWithStoreName:@"Amsterdam" withPhotoHistory:storeImageObjArray];
//	[storeImageObjArray release];
//	[storeArray addObject:store];	
//	[store release];
	
	////--------------next store berlin--------------
	
	
	//storeImageObjArray = [[NSMutableArray alloc]init];
	StoreImageObj *imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backall with Graphic_b" onDate:[self stringToDate:@"01-01-2011"]];//1
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall shelves" onDate:[self stringToDate:@"04-01-2011"]];//2
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	//Dedicat2//Mannequin
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall with Graphic_a" onDate:[self stringToDate:@"11-01-2011"]];//3
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall with shelves" onDate:[self stringToDate:@"18-01-2011"]];	//4
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall with shelves" onDate:[self stringToDate:@"22-12-2011"]];//52
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_c" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Display Cube" onDate:[self stringToDate:@"25-01-2011"]];//5
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Glass cube" onDate:[self stringToDate:@"03-02-2011"]];	//6
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Mannequin_Men" onDate:[self stringToDate:@"09-02-2011"]];//7
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Mannequin_Men_a" onDate:[self stringToDate:@"09-02-2011"]];//7
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_a" onDate:[self stringToDate:@"16-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_b" onDate:[self stringToDate:@"17-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	StorePhotoInfo * store = [[StorePhotoInfo alloc]initWithStoreName:@"Berlin" withPhotoHistory:storeImageObjArray];
	[storeImageObjArray release];
	[storeArray addObject:store];	
	[store release];
	//----------------------------------------------------------------------------------------
	
	storeImageObjArray = [[NSMutableArray alloc]init];
	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Backwall with Graphic_Women_b" onDate:[self stringToDate:@"22-12-2011"]];//52
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Bangkok_Shelves" onDate:[self stringToDate:@"19-12-2011"]];//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Bangkok_Backwall with Graphic_Men" onDate:[self stringToDate:@"12-01-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Bangkok_Backwall with Graphic_Men_a" onDate:[self stringToDate:@"18-01-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Bangkok_Backwall with Graphic_Women" onDate:[self stringToDate:@"25-01-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Bangkok_Table_a" onDate:[self stringToDate:@"04-01-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Bangkok_Table_b" onDate:[self stringToDate:@"01-01-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall with Graphic_FW" onDate:[self stringToDate:@"16-02-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_FW_a" onDate:[self stringToDate:@"02-02-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_FW_b" onDate:[self stringToDate:@"08-02-2011"]];
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	store = [[StorePhotoInfo alloc]initWithStoreName:@"Bangkok" withPhotoHistory:storeImageObjArray];
	[storeImageObjArray release];
	[storeArray addObject:store];	
	[store release];
	//------------------------------------------------------
	storeImageObjArray = [[NSMutableArray alloc]init];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Hang rail" onDate:[self stringToDate:@"01-01-2011"]];//1
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Glass cubes" onDate:[self stringToDate:@"04-01-2011"]];//2
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall with Graphic_a" onDate:[self stringToDate:@"11-01-2011"]];//3
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Backwall with shelves" onDate:[self stringToDate:@"18-01-2011"]];	//4
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Store Front 1" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Store Front 2" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Store Front 3" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Cash desk" onDate:[self stringToDate:@"22-12-2011"]];//52
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Display Cube" onDate:[self stringToDate:@"25-01-2011"]];//5
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Glass cube" onDate:[self stringToDate:@"03-02-2011"]];	//6
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Mannequin_Men" onDate:[self stringToDate:@"09-02-2011"]];//7
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Mannequin_Men_a" onDate:[self stringToDate:@"10-02-2011"]];//7
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_a" onDate:[self stringToDate:@"16-02-2011"]];//8
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Berlin_Table_b" onDate:[self stringToDate:@"17-02-2011"]];//8
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	
	store = [[StorePhotoInfo alloc]initWithStoreName:@"Miami" withPhotoHistory:storeImageObjArray];
	[storeImageObjArray release];
	[storeArray addObject:store];	
	[store release];
	
	//------------------------------------------moscow -----------
	storeImageObjArray = [[NSMutableArray alloc]init];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Backwall 2 Kopie" onDate:[self stringToDate:@"01-01-2011"]];//1
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Hang rail 1 Kopie" onDate:[self stringToDate:@"04-01-2011"]];//2
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Hang rail Kopie" onDate:[self stringToDate:@"04-01-2011"]];//2
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	//Dedicat2//Mannequin
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Mannequin" onDate:[self stringToDate:@"11-01-2011"]];//3
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Moscow_Backwall with Graphic_Men Kopie" onDate:[self stringToDate:@"11-01-2011"]];//3
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001595" onDate:[self stringToDate:@"18-01-2011"]];	//4
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001820" onDate:[self stringToDate:@"18-01-2011"]];	//4
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001830" onDate:[self stringToDate:@"18-01-2011"]];	//4
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Acc Tower Kopie" onDate:[self stringToDate:@"22-12-2011"]];//52
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"Backwall 1 Kopie" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001838" onDate:[self stringToDate:@"25-01-2011"]];//5
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001844" onDate:[self stringToDate:@"25-01-2011"]];//5
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001881" onDate:[self stringToDate:@"03-02-2011"]];	//6
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001884" onDate:[self stringToDate:@"09-02-2011"]];//7
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
//	imageObj = [[StoreImageObj alloc]initWithImageName:@"jmp_009_001892" onDate:[self stringToDate:@"10-02-2011"]];//7
//	[storeImageObjArray addObject:imageObj];
//	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"JMP_009E3_00213" onDate:[self stringToDate:@"16-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Moscow_overview" onDate:[self stringToDate:@"17-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"Overview1 Kopie" onDate:[self stringToDate:@"17-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	
	store = [[StorePhotoInfo alloc]initWithStoreName:@"Moscow" withPhotoHistory:storeImageObjArray];
	[storeImageObjArray release];
	[storeArray addObject:store];	
	[store release];
	
	//----------------------------------------Paris --------------
	storeImageObjArray = [[NSMutableArray alloc]init];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020188" onDate:[self stringToDate:@"01-01-2011"]];//1
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020189" onDate:[self stringToDate:@"04-01-2011"]];//2
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020192" onDate:[self stringToDate:@"11-01-2011"]];//3
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020193" onDate:[self stringToDate:@"11-01-2011"]];//3
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020196" onDate:[self stringToDate:@"11-01-2011"]];//3
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020197" onDate:[self stringToDate:@"18-01-2011"]];	//4
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020186" onDate:[self stringToDate:@"22-12-2011"]];//52
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020187" onDate:[self stringToDate:@"22-12-2011"]];//52
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020181" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	//	
	//	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020185" onDate:[self stringToDate:@"19-12-2011"]];	//51
	//	[storeImageObjArray addObject:imageObj];
	//	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020200" onDate:[self stringToDate:@"25-01-2011"]];//5
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020201" onDate:[self stringToDate:@"25-01-2011"]];//5
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020203" onDate:[self stringToDate:@"03-02-2011"]];	//6
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020205" onDate:[self stringToDate:@"09-02-2011"]];//7
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020206" onDate:[self stringToDate:@"10-02-2011"]];//7
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020208" onDate:[self stringToDate:@"16-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	imageObj = [[StoreImageObj alloc]initWithImageName:@"P1020218" onDate:[self stringToDate:@"17-02-2011"]];//8
	[storeImageObjArray addObject:imageObj];
	[imageObj release];
	
	
	
	store = [[StorePhotoInfo alloc]initWithStoreName:@"Paris" withPhotoHistory:storeImageObjArray];
	[storeImageObjArray release];
	[storeArray addObject:store];	
	[store release];
	NSLog(@"storeArray count = %d",[storeArray count]);
	
	
	storeDictonary = [[NSMutableDictionary alloc] init];
    keyArray = [[NSMutableArray alloc] init];
	
	for(int i=0;i<[storeArray count];i++)
		//for(StorePhotoInfo *store in storeArray)
	{
		NSArray *lkeyArray = [storeDictonary allKeys];
		StorePhotoInfo *name = [storeArray objectAtIndex:i ] ;// store.storeName;
		NSRange firstCharRange = NSMakeRange(0,1);
		NSString* firstCharacter = [[[[storeArray objectAtIndex:i ] storeName]substringWithRange:firstCharRange] capitalizedString];
		
		if([lkeyArray containsObject:firstCharacter])
		{
			NSMutableArray *localEventArray = [storeDictonary objectForKey:firstCharacter];
			[localEventArray addObject:name];
			[storeDictonary setObject:localEventArray forKey:firstCharacter];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:name,nil];
			[storeDictonary setObject:localEventArray forKey:firstCharacter];
			[localEventArray release];
			[keyArray addObject:firstCharacter];
		}
		
	}
	[keyArray release];
	
	NSArray * picDicKey = [storeDictonary allKeys];		
	
	namedickey = [[NSArray alloc]initWithArray:[picDicKey sortedArrayUsingSelector:@selector(compare:)]];
	
}

//function to get NSdate from the NSString
-(NSDate *)stringToDate:(NSString *)stringDate{
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];		
	
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;
	
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
	//[detailViewController release];
	[storeArray release];
    [super dealloc];
}
#pragma mark tableDelegate
#pragma mark begin

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return [namedickey count];	
	return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [namedickey objectAtIndex:section];
	//retrun @"store";
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{	
	NSString *key=[namedickey objectAtIndex:section];
	NSMutableArray *sectionArray=[storeDictonary objectForKey:key];
	return [sectionArray count];
}


// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CUSTOM_CELL"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CUSTOM_CELL"]autorelease];
	}
	
	NSString *tempkey=[namedickey objectAtIndex:indexPath.section];
	NSMutableArray *nameArray=[storeDictonary objectForKey:tempkey];
	StorePhotoInfo * storeInfo1 = [nameArray objectAtIndex:indexPath.row];
	//for(int i=0;i<[nameArray count];i++)
	for(StorePhotoInfo *name in nameArray)
	{
		cell.textLabel.text= storeInfo1.storeName; //name;//[nameArray objectAtIndex:indexPath.row];
	}	
	
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *tempkey=[namedickey objectAtIndex:indexPath.section];
	NSMutableArray *nameArray=[storeDictonary objectForKey:tempkey];
	StorePhotoInfo * storeInfo1 = [nameArray objectAtIndex:indexPath.row];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	//PhotoHistory *photoHistory = [[PhotoHistory alloc] initwithPicsArray:[[storeArray objectAtIndex:indexPath.section ] photohistoryArray ]] ;
	PhotoHistory *photoHistory = [[PhotoHistory alloc] initWithNibName:@"PhotoHistory" bundle:[NSBundle mainBundle] picArray:[storeInfo1 photohistoryArray ]];
	
	
	NSString *name = [storeInfo1 storeName];
	NSLog(@"name if store is: %@",name);
	[photoHistory setTitle:name];
	[self.navigationController pushViewController:photoHistory animated:YES];
	[photoHistory release];
}



@end
