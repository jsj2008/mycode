//
//  CanvasToolBarMuppetsListProvider.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/16/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "CanvasToolBarMuppetsListProvider.h"
#import "MuppetTableViewCell.h"

#define kCellIdentifier @"MuppetTableViewCell"

@implementation CanvasToolBarMuppetsListProvider

- (id)init{
    self = [super init];
    if (self) {
        data = [[NSArray alloc] initWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys:@"muppet-big.png", @"image", @"AAA", @"title", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"muppet-big.png", @"image", @"AAA", @"title", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"muppet-big.png", @"image", @"AAA", @"title", nil],
                nil];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MuppetTableViewCell *cell = (MuppetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:kCellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    [cell setSourceData:[data objectAtIndex:indexPath.row]];

    return cell;
}

@end
