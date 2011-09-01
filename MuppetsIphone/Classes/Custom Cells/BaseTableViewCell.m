//
//  DraggableTableViewCell.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell

@synthesize imageView;
@synthesize label;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {        
    }
    return self;
}

- (void)setSourceData:(NSDictionary *)data{
    self.imageView.image = [UIImage imageNamed:[data objectForKey:@"image"]];
}

- (void)dealloc {
    [label release];
    [imageView release];
    [super dealloc];
}

@end
