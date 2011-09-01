//
//  SFAnnotation.m
//  location
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SFAnnotation.h"

@implementation SFAnnotation 




- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 28.786996;
    theCoordinate.longitude = 77.419281;
    return theCoordinate; 
}

- (void)dealloc
{
   
    [super dealloc];
}

- (NSString *)title
{
    return @"Murad Nagar";
}

// optional
- (NSString *)subtitle
{
    return @"Delhi";
}

@end
