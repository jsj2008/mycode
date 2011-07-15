//
//  BlogAppViewController.m
//  BlogApp
//
//  Created by Ayush Goel on 11/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlogAppViewController.h"
#import "WebServiceHandler.h"
#import "WebServicePost.h"

@implementation BlogAppViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

WebServiceHandler *obj;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    first=0;
    
    [[NSNotificationCenter defaultCenter]  addObserver:self  selector:@selector(castDict) name:@"unique"  object:nil];
    NSURL *url = [NSURL URLWithString: @"http://localhost/xampp/aayush1.php"];
    obj=[[WebServiceHandler alloc]initWithWord:url]; 

    blogView=[[UITextField alloc]initWithFrame:CGRectMake(0,0,320,300)];
    [self.view addSubview:blogView];
    [blogView release];
    blogView.hidden=YES;
    
    save = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	save.frame = CGRectMake(100,350,100,50);
	[save setTitle:@"save" forState:UIControlStateNormal];
    [save addTarget:self action:@selector(onSave) forControlEvents:UIControlEventTouchUpInside];
    [save setUserInteractionEnabled:YES];
    [self.view addSubview:save];
      [self performSelector:@selector(Datareload) withObject:nil afterDelay:3.0];
    [super viewDidLoad];
}
-(void) Datareload
{
    NSURL *url = [NSURL URLWithString: @"http://localhost/xampp/aayush1.php"];
    obj=[[WebServiceHandler alloc]initWithWord:url]; 
    [myTable reloadData];
    [self performSelector:@selector(Datareload) withObject:nil afterDelay:3.0];
}
-(void)onSave
{
    
    blogView.hidden=YES;
    myTable.hidden=NO;
    NSString *key=[keyArray objectAtIndex:selected];
   [result setValue:blogView.text forKey:key];
    NSURL *url1 = [NSURL URLWithString: @"http://localhost/xampp/aayush2.php"];
     WebServicePost *obj1=[[WebServicePost alloc]initWithRequest:url1 aDict:result];
    [obj1 release];
   
}
-(void)castDict
{

    result=[obj returnData];
    [result retain];
    [obj release];
    if(first==0)
    {
    myTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,320,480) style:UITableViewStylePlain];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
        first=1;
    }
  
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
     
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
 
    return [result count]; 
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
 
  keyArray=[result allKeys];
  keyArray = [keyArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [keyArray retain];
   
   // NSLog(@"keyArray== %@",keyArray);
    cell.textLabel.text =[keyArray objectAtIndex:indexPath.row];
    
        
    return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    myTable.hidden=YES;
    blogView.hidden=NO;
    NSString *key=[keyArray objectAtIndex:indexPath.row];
    selected=indexPath.row;
    blogView.text= [result objectForKey:key];
    blogView.delegate=self;
        
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return 44;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
