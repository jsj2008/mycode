//
//  flatteningViewController.m
//  flattening
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "flatteningViewController.h"

@implementation flatteningViewController

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
     mainView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320, 480)];
    [self.view addSubview:mainView];
    [mainView release];
    
    firstview=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50,200, 200)];
    firstview.image=[UIImage imageNamed:@"a1.jpeg"];
    [mainView addSubview:firstview];
    [firstview release];
    
    secondview=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100,200, 200)];
    secondview.image=[UIImage imageNamed:@"a2.jpeg"];
    [mainView addSubview:secondview];
    [secondview release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20,350,100,20);
    [btn setTitle:@"FLATTEN" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onFlatten) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    
    [super viewDidLoad];
}
-(void) onFlatten
{
    dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    /*CGRect rect = firstview.bounds;
     NSLog(@"x  %f   y %f ",rect.origin.x,rect.origin.y);*/
    
    
    NSNumber *x1 = [NSNumber numberWithInt:50];
    NSNumber *y1 = [NSNumber numberWithInt:50];
    NSNumber *w = [NSNumber numberWithInt:200];
    NSNumber *h = [NSNumber numberWithInt:200];
    NSMutableDictionary *detaildict = [NSMutableDictionary dictionaryWithCapacity:4];
    [detaildict setValue:x1 forKey:@"x"];
    [detaildict setValue:y1 forKey:@"y"];
    [detaildict setValue:w forKey:@"w"];
    [detaildict setValue:h forKey:@"h"];
    [dict setObject:detaildict forKey:@"first"];

    
    
    x1 = [NSNumber numberWithInt:100];
    y1 = [NSNumber numberWithInt:100];
    w = [NSNumber numberWithInt:200];
    h = [NSNumber numberWithInt:200];
    NSMutableDictionary *detaildict1 = [NSMutableDictionary dictionaryWithCapacity:4];
    [detaildict1 setValue:x1 forKey:@"x"];
    [detaildict1 setValue:y1 forKey:@"y"];
    [detaildict1 setValue:w forKey:@"w"];
    [detaildict1 setValue:h forKey:@"h"];
    [dict setObject:detaildict1 forKey:@"second"];
    
    [self save];
    
}

-(void) save
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"myPlistFile.plist"];
   /* if (![fileManager fileExistsAtPath: plistPath])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@”myPlistFile” ofType:@”plist”];
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
    }*/
   
    [dict writeToFile:plistPath atomically: YES];
    //and restore them
    NSMutableDictionary  *restored = [NSDictionary dictionaryWithContentsOfFile: plistPath];
    NSLog(@"RETRIEVED DICT %@",restored);
    
    
}

/* -(void) flatten
 {
  UIGraphicsBeginImageContext(self.view.bounds.size);
 [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
 newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 [firstview removeFromSuperview];
 [secondview removeFromSuperview];
 UIImageView *newView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50,200, 200)];
 newView.image=newImage;
 [self.view addSubview:newView];
 [newView release]; 
 }
*/
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
