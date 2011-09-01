//
//  MuppetFeatureTableViewCell.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/5/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "MuppetFeatureTableViewCell.h"


@implementation MuppetFeatureTableViewCell

- (void)setSourceData:(NSString *)data{
    self.imageView.image = [UIImage imageNamed:data];
}


@end
