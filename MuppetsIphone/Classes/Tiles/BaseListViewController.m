//
//  BaseListViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "BaseListViewController.h"
#import "ProjectViewController.h"

#import "MuppetsIphoneAppDelegate.h"


@implementation BaseListViewController

@synthesize scrollView;
@synthesize data;

- (void)dealloc
{
    [scrollView release];
    [data release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *_list = [data objectForKey:@"list"];
    for (NSDictionary *_occasionTheme in _list) {
        UIView *_themeContainer = [[UIView alloc] initWithFrame:scrollView.bounds];
        UIImageView *_theme     = [[UIImageView alloc] initWithFrame:CGRectInset(_themeContainer.bounds, 90.0f, 60.0f)];
        _theme.contentMode      = UIViewContentModeScaleAspectFill;
        _theme.image            = [UIImage imageNamed:[_occasionTheme objectForKey:@"preview"]];
        float _rotation         = ((float)rand())/RAND_MAX * 4.0 - 2.0;
        _theme.transform        = CGAffineTransformMakeRotation(degreesToRadian(_rotation));
        
        [_themeContainer addSubview:_theme];
        [scrollView addSubview:_themeContainer];
    }
    [scrollView relayoutChildrenHorizontallyWithMargin:0.0f];
    scrollView.showsHorizontalScrollIndicator=NO;
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)gotoHome:(id)sender{
    [self.navigationController popToRootViewControllerUsingTransition:kCATransitionFade];
}

- (IBAction)gotoGrid:(id)sender{
    [self.navigationController popViewControllerUsingTransition:kCATransitionFade];
}

- (IBAction)addFlair:(id)sender
{
    
    ProjectViewController *_project = [[ProjectViewController alloc] init];
    MuppetsIphoneAppDelegate *del=[UIApplication sharedApplication].delegate;
    del.choice=1;
    NSLog(@"here choice== %d",del.choice);
    UIImage *img=[UIImage imageNamed:@"Character1v1.png"];
    [_project loadImage:img];
     [self.navigationController pushViewController:_project usingTransition:kCATransitionFade];
    [_project release];

}
@end
