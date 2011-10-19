//
//  Login.m
//  eg
//
//  Created by Aneesh on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Login.h"
#import "Register.h"
#import "Brain.h"
#import "WelcomeScreen.h"
@implementation Login


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) loginChk:(id) sender
{
    Brain * br = [[Brain alloc] init];
    NSString * name = [br loginBrain: uid.text pass:pwd.text];
    if(name)
    {
        NSUserDefaults * chk = [NSUserDefaults standardUserDefaults];
        [chk setObject:name forKey:@"Current"];
        [chk setObject:uid.text forKey:@"CurrentUid"];
        [chk synchronize];
        WelcomeScreen * wel = [[WelcomeScreen alloc] init];
        [self.navigationController pushViewController:wel animated:YES];
    }
    else
        NSLog(@"Failed");
}

-(IBAction) regiUser:(id) sender
{
    Register *reg = [[Register alloc] init];
    [self.navigationController pushViewController:reg animated:YES];
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
