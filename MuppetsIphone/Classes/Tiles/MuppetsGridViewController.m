//
//  MuppetsListViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "MuppetsGridViewController.h"
#import "DataLoader.h"
#import "MuppetListViewController.h"

@implementation MuppetsGridViewController

- (id)init
{
    self = [super initWithNibName:@"MuppetsGridView" bundle:nil];
    if (self) {
        self.data = [DataLoader shared].characters;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)gridItemSelected:(id)details{
    MuppetListViewController *_muppet = [[MuppetListViewController alloc] init];
    _muppet.data = details;
    [self.navigationController pushViewController:_muppet usingTransition:kCATransitionFade];
    [_muppet release];
    
}
@end
