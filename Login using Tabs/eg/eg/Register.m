//
//  Register.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Register.h"
#import "Brain.h"
#import "WelcomeScreen.h"
@implementation Register

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) regiUser
{
    Brain *br = [[Brain alloc] init];
    if([br regiBrain: uid.text 
             pass: pwd.text 
             Name: name.text 
              Age: age.text 
              Add: add.text 
            Image: img.text])
    {
        NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
        [chk setObject:name.text forKey:@"Current"];
        [chk setObject:uid.text forKey:@"CurrentUid"];
        [chk synchronize];
        WelcomeScreen *wel = [[WelcomeScreen alloc] init];
        [self.navigationController pushViewController:wel animated:YES];
    }
    else
        NSLog(@"Failed at regiUser");

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
    // Do any additional setup after loading the view from its nib.
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
