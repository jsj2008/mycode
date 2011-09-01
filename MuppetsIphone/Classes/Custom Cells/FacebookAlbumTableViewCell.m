//
//  FacebookAlbumTableViewCell.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "FacebookAlbumTableViewCell.h"
#import "MuppetAccount.h"

@implementation FacebookAlbumTableViewCell

- (void)dealloc
{
    [super dealloc];
}

- (void)setSourceData:(id)sourceData{
    NSString *_url = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?access_token=%@", [sourceData objectForKey:@"id"], [[MuppetAccount shared].facebook.accessToken stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    
    [self.imageView setImageWithPath:_url placeholderImage:nil];
    self.label.text = [sourceData objectForKey:@"name"];  
}

@end
