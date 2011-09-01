//
//  BridgeAnnotation.m
//  location
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BridgeAnnotation.h"

@implementation BridgeAnnotation

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 28.386996;
    theCoordinate.longitude = 77.719281;
    return theCoordinate; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return @"BulandSaher";
}

// optional
- (NSString *)subtitle
{
    return @"Delhi";
}

- (void)dealloc
{
    [super dealloc];
}

@end