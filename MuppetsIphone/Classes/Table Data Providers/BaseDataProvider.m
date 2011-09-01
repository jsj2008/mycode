//
//  BaseDataProvider.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "BaseDataProvider.h"
#import "BaseTableViewCell.h"


@implementation BaseDataProvider

@synthesize data;
@synthesize tableView;
@synthesize rootView;

- (id)init{
    self = [super initWithNibName:@"BaseDataProviderView" bundle:nil];
    if (self) {
        data = [NSArray new];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = self.view.bounds.size;
}

- (void)dealloc{
    [tableView release];
    [data release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *_cell = (BaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
}


@end
