//
//  CharacterView.m
//  MuppetsIphone
//
//  Created by Ayush Goel on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CharacterView.h"
#import "FacebookFriendsViewController.h"
#import "CustomCell.h"


@implementation CharacterView
@synthesize tableView;
@synthesize _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        
    }
    return self;
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableView.showsVerticalScrollIndicator=NO;
    NSError *error;
    NSString *_Path    = [[NSBundle mainBundle] pathForResource:@"ProjectCharacter" ofType:@"json"];
    NSString *_Data    = [NSString stringWithContentsOfFile:_Path encoding:NSASCIIStringEncoding error:&error];
    project              = [[_Data JSONValue] retain];
   
    
 
      // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)close
{
	[self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return [project count];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    static NSString *kCustomCellID = @"MyCellID";
     NSDictionary *temp=[project objectAtIndex:indexPath.row];
    
   
	CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	
	if (cell == nil) 
	{
		cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.titleLabel.text=[temp objectForKey:@"title"];
    
   cell.checkImageView.image=[UIImage imageNamed:[temp objectForKey:@"thumb"]];
 
	return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate != nil) {
        
       NSDictionary *temp=[project objectAtIndex:indexPath.row];
                
        [_delegate characterSelected:[temp objectForKey:@"thumb"]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
