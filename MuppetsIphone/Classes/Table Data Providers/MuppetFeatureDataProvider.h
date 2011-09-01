//
//  MuppetFeatureDataProvider.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/5/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataProvider.h"

typedef enum {
    MuppetFeatureTypeHair,
    MuppetFeatureTypeFace,
    MuppetFeatureTypeShirt,
    MuppetFeatureTypePant
} MuppetFeatureType;

@interface MuppetFeatureDataProvider : BaseDataProvider {
    MuppetFeatureType featureType;
    
    id delegate;
}

@property (nonatomic, retain) id delegate;

- (void)loadFeature:(MuppetFeatureType)aFeatureType;

@end
