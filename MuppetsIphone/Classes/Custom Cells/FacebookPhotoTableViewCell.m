//
//  FacebookPhotoTableViewCell.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/27/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "FacebookPhotoTableViewCell.h"
#import "MuppetAccount.h"

@implementation FacebookPhotoTableViewCell

- (void)dealloc {
    [super dealloc];
}

- (void)setSourceData:(id)sourceData{
    NSString *_url = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?access_token=%@", [sourceData objectForKey:@"id"], [[MuppetAccount shared].facebook.accessToken stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    [self.imageView setImageWithURL:[NSURL URLWithString:_url] placeholderImage:nil];
    self.label.text = [sourceData objectForKey:@"name"];  
}

@end
