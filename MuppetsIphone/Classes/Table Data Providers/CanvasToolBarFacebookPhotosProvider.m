//
//  CanvasToolBarFacebookPhotosProvider.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/27/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "CanvasToolBarFacebookPhotosProvider.h"
#import "FacebookPhotoTableViewCell.h"
#import "MuppetAccount.h"

#define kCellIdentifier @"FacebookPhotoTableViewCell"

@interface CanvasToolBarFacebookPhotosProvider (private)

- (void)facebookAccountStatusChanged;

@end

@implementation CanvasToolBarFacebookPhotosProvider

@synthesize albumId;

- (id)initWithAlbumId:(NSString *)anAlbumId{
    self = [super init];
    if (self) {
        albumId = anAlbumId;
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(facebookAccountStatusChanged) 
                                                     name: AccountLoginStatusChanged 
                                                   object: nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [albumId release];
    [super dealloc];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self facebookAccountStatusChanged];
}

- (void)facebookAccountStatusChanged{
    if ([MuppetAccount shared].status == AccountStatusFacebookLoggedIn) {
        [[MuppetAccount shared] fetchPicturesWithParams:nil andAlbumId:albumId andResponseBlock:^(NSArray *pictures) {
            self.data = [self.data arrayByAddingObjectsFromArray:pictures];
            [self.tableView reloadData];
        } andErrorBlock:^(NSError *error) {
            
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FacebookPhotoTableViewCell *cell = (FacebookPhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:kCellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    [cell setSourceData:[data objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
