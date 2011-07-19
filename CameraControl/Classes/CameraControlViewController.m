//
//  CameraControlViewController.m
//  CameraControl
//
//  Created by basant on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraControlViewController.h"
#import <sqlite3.h> 
@implementation CameraControlViewController

@synthesize i;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
- (void)viewDidLoad {
    [super viewDidLoad];
}


-(IBAction)Click
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		
	
	UIActionSheet *photoSourceSheet=[[UIActionSheet alloc]initWithTitle:@"Select a Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a new Photo",@"Choose an Existing Photo", nil,nil];
	[photoSourceSheet showInView:self.view];
	[photoSourceSheet release];
}
	else {
		UIImagePickerController * picker=[[UIImagePickerController alloc]init];
		picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		picker.delegate=self;
		picker.allowsEditing=YES;
		[self presentModalViewController:picker animated:YES];
	}
}



//delegate methods

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	
	UIImagePickerController *picker=[[UIImagePickerController alloc]init];
	picker.delegate=self;
	picker.allowsEditing=YES;
	
	switch (buttonIndex) {
		case 0:
			NSLog(@"User wants to take a new picture");
			picker.sourceType=UIImagePickerControllerSourceTypeCamera;
			break;
			
		case 1:
			picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			break;

			

		default:
			[picker release];
			return;
	}
	[self presentModalViewController:picker animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo
{
	//NSData *image1 = UIImagePNGRepresentation(image);
//	sqlite3 *database;
//	static sqlite3_stmt *insert_statement;
//	const char *sql="INSERT INTO emp1 (6,image) VALUES (null,null,null,null,null,?,null)";
//	
//	if(sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK)
//	{
//		NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
//		
//	
//	sqlite3_bind_blob(insert_statement, 6, [image1 bytes], [image1 length], NULL);
//}
//else {
//	sqlite3_bind_blob(insert_statement, 6, nil, -1, NULL);
//}
	
	i.image=image;
	[self dismissModalViewControllerAnimated:YES];
	[picker release];
}








/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
