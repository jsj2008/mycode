//
//  UIHTTPImageView.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "UIHTTPImageView.h"
#import "ASIDownloadCache.h"

@implementation UIHTTPImageView        

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [request setDelegate:nil];
    [request cancel];
    [request release];
    
    request = [[ASIHTTPRequest requestWithURL:url] retain];
    [request setCacheStoragePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    
    if (placeholder)
        self.image = placeholder;
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)dealloc {
    [request setDelegate:nil];
    [request cancel];
    [request release];
    [super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)req {
    if (request.responseStatusCode != 200)
        return;
    
    self.image = [UIImage imageWithData:request.responseData];
}

@end