//
//  RootViewController.m
//  SMS Bubbles
//
//  Created by Santosh B on 1/12/10.
//  Copyright Cybage 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Database.h"
#import "Message.h"
#import "CustomCell.h"


@implementation RootViewController

@synthesize tbl, field, toolbar, messagearray;

- (void)viewDidLoad {
	DatabaseHandler=[[Database alloc]init];
	m=[[Message alloc]init];
	[DatabaseHandler settings];
	self.title = @"Message Stream";
	messagearray = [[NSMutableArray alloc] init];
	[DatabaseHandler deletefromDatabase];
	messagearray=[DatabaseHandler readFromDatabase];  	
	
	/* Set the background color */
	 
	tbl.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1.0];
	
	/* Create header with two buttons */
/*	CGSize screenSize = [[UIScreen mainScreen] applicationFrame].size;	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 55)];
	UIButton *refresh = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[refresh addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];		
	refresh.frame = CGRectMake((screenSize.width / 2) + 10, 10, (screenSize.width / 2) - 20, 35);
	[refresh setTitle:@"Refresh" forState:UIControlStateNormal];
	[headerView addSubview:refresh];
	
	tbl.tableHeaderView = headerView;*/
	  [super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}

- (void)add {
	if(![field.text isEqualToString:@""])
	{
		count=m.id1;
		m=[[Message alloc]init];
		m.id1=count;
		NSLog(@"id %d",count);
		m.text=field.text;
		m.pos=0;
		//m.image=@"image.jpg";
		m.image=@"NULL";
		[messagearray addObject:m];
	    [DatabaseHandler settings];
		[DatabaseHandler insertDatabase: m.id1 :m.text :m.image:m.pos];
		messagearray = [[NSMutableArray alloc] init];
		messagearray=[DatabaseHandler readFromDatabase];
		[tbl reloadData];
		NSUInteger index = [messagearray count] - 1;
		[tbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		field.text = @"";
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];	
	toolbar.frame = CGRectMake(0, 372, 320, 44);
	tbl.frame = CGRectMake(0, 0, 320, 372);	
	[UIView commitAnimations];
	
	return YES;
}

- (void)keyboardWillShow:(NSNotification *)notif {
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];	
	toolbar.frame = CGRectMake(0, 156, 320, 44);
	tbl.frame = CGRectMake(0, 0, 320, 156);	
	[UIView commitAnimations];
	
	if([messagearray count] > 0)
	{
		NSUInteger index = [messagearray count]-1;
		[tbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	}
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messagearray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *kCustomCellID = @"MyCellID";
	CustomCell *cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;	
	 

	cell.message.frame = CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height);
	m=[messagearray objectAtIndex:indexPath.row];
	count=m.id1;
	
	NSString *text=m.text;
	NSString *image=m.image;
	NSLog(@"%d",m.pos);
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
	UIImage *balloon;
	
	if(m.pos== 0)
	{
		
		cell.balloonView.frame = CGRectMake(300.0f - (size.width + 8.0f), 2.0f, size.width + 28.0f, size.height + 15.0f);
		balloon = [[UIImage imageNamed:@"green.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		cell.label.frame = CGRectMake(310.0f - (size.width + 8.0f), 8.0f, size.width + 5.0f, size.height);
		
		if([image isEqualToString:@"NULL"])
		{
			
		}
		else
		{	
		
			cell.ImageView.image= [UIImage imageNamed:image];
			cell.ImageView.frame = CGRectMake(5,size.height +5,50.0f,50.0f);
			
			cell.balloonView.frame = CGRectMake(310.0f - (size.width + 50.0f) , 2.0f, size.width+60.0f, size.height + 65.0f);
			cell.label.frame = CGRectMake(320.0f - (size.width + 50.0f), 8.0f, size.width + 5.0f, size.height);
			
			
		}
	}
	else
	{
		cell.balloonView.frame = CGRectMake(0.0, 2.0, size.width + 28, size.height + 15);
		balloon = [[UIImage imageNamed:@"grey.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		cell.label.frame = CGRectMake(16, 8, size.width + 5, size.height);
		
		if([image isEqualToString:@"NULL"])
		{
		
			
		}
		else 
		{
			NSLog(@"%@",image);
			cell.ImageView.image= [UIImage imageNamed:image];
			cell.ImageView.frame = CGRectMake(10,size.height +5,50,50);
			cell.balloonView.frame = CGRectMake(0.0f , 2.0f, size.width + 60, size.height + 70);;
		
			
		}
	}
	cell.balloonView.image = balloon;
	cell.label.text = text;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	m=[messagearray objectAtIndex:indexPath.row];
	NSString *body=m.text;
	CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0, 480.0) lineBreakMode:UILineBreakModeWordWrap];

	if([m.image isEqualToString:@"NULL"])
	{
		return size.height +20;
	}
	else 
	{
		return size.height +20+60;
	}
	
}

#pragma mark -

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.tbl = nil;
	self.field = nil;
	self.toolbar = nil;
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[tbl release];
	[field release];
	[toolbar release];
	[messagearray release];
    [super dealloc];
}


@end

