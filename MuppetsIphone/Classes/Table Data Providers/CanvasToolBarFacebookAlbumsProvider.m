//
//  CanvasToolBarFacebookAlbumsProvider.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "CanvasToolBarFacebookAlbumsProvider.h"
#import "CanvasToolBarFacebookPhotosProvider.h"
#import "FacebookAlbumTableViewCell.h"
#import "MuppetAccount.h"

#define kCellIdentifier @"FacebookAlbumTableViewCell"

@interface CanvasToolBarFacebookAlbumsProvider (private)

- (void)facebookAccountStatusChanged;

@end

@implementation CanvasToolBarFacebookAlbumsProvider

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(facebookAccountStatusChanged) 
                                                     name: AccountLoginStatusChanged 
                                                   object: nil];
        [self facebookAccountStatusChanged];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [super dealloc];
}

- (void)facebookAccountStatusChanged{
    if ([MuppetAccount shared].status == AccountStatusFacebookLoggedIn) {
        [[MuppetAccount shared] fetchAlbumsWithParams:nil andResponseBlock:^(NSArray *albums) {
            self.data = [self.data arrayByAddingObjectsFromArray:albums];
            [self.tableView reloadData];
        } andErrorBlock:^(NSError *error) {
            
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FacebookAlbumTableViewCell *cell = (FacebookAlbumTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:kCellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    [cell setSourceData:[data objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CanvasToolBarFacebookPhotosProvider *_facebookPhotosProvider = [[CanvasToolBarFacebookPhotosProvider alloc] initWithAlbumId:[[data objectAtIndex:indexPath.row] objectForKey:@"id"]];
    [self.navigationController pushViewController:_facebookPhotosProvider animated:YES];
}


@end
