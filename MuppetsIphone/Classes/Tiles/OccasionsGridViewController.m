//
//  OccasionsListViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/12/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "OccasionsGridViewController.h"
#import "DataLoader.h"
#import "OccasionListViewController.h"


@implementation OccasionsGridViewController

- (id)init
{
    self = [super initWithNibName:@"OccasionsGridView" bundle:nil];
    if (self) {
        self.data = [DataLoader shared].occasions;
		CFShow(self.data);
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)gridItemSelected:(id)details{
    OccasionListViewController *_occasion = [[OccasionListViewController alloc] init];
    _occasion.data = details;
    [self.navigationController pushViewController:_occasion usingTransition:kCATransitionFade];
    [_occasion release];
}

@end
