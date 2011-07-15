//
//  ColorPickerController.m
//  MathMonsters
//
//  Created by Ray Wenderlich on 5/3/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "ClickController.h"
#import "TestHarmonyAppDelegate.h"

@implementation ClickController
@synthesize myarray;
@synthesize delegate = _delegate;


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    TestHarmonyAppDelegate *del=[UIApplication sharedApplication].delegate;
    count=del.click;
   
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(250.0, 400.0);
    self.myarray = [NSMutableArray array];
      [myarray addObject:@"Favourites"];
      [myarray addObject:@"Popular"];
      [myarray addObject:@"Movies"];
      [myarray addObject:@"Action/Adventure"];
      [myarray addObject:@"Comedy"];
      [myarray addObject:@"Drama"];
      [myarray addObject:@"Indie/Foreign"];
      [myarray addObject:@"News"];
      [myarray addObject:@"Reality TV"];
      [myarray addObject:@"Sci-Fi & Fantasy"];
      [myarray addObject:@"Sports"];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section==0)
        return 1;
    if(section==1)
        return 1;
    if(section==2)
        return 1;
    if(section==3)
        return 8;
    return 0; 
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    int lcount=indexPath.row+indexPath.section;
   
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
       cell.textLabel.text = [myarray objectAtIndex:indexPath.row+indexPath.section];
    
    if (lcount==count) 
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
   
    return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   
    if (_delegate != nil) {
        
        count=indexPath.row+indexPath.section;
    
        TestHarmonyAppDelegate *del1=[UIApplication sharedApplication].delegate;
        del1.click=count;
        

        [tableView reloadData];
        NSString *temp=[myarray objectAtIndex:indexPath.row+indexPath.section];
        [_delegate colorSelected:temp];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return 44;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    self.myarray = nil;
    self.delegate = nil;
    [super dealloc];
}


@end

