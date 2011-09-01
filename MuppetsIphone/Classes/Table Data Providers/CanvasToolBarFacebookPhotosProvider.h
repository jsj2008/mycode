//
//  CanvasToolBarFacebookPhotosProvider.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/27/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataProvider.h"

@interface CanvasToolBarFacebookPhotosProvider : BaseDataProvider {
    NSString *albumId;
}

@property (nonatomic, retain) NSString *albumId;

- (id)initWithAlbumId:(NSString *)anAlbumId;

@end
