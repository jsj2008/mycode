//
//  locationViewController.h
//  location
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface locationViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate> 
{
    CLLocationManager *locationManager;
    MKMapView *mapView;
    float latitude;
    float longitude;
    NSMutableArray *mapAnnotations;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain)  MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;

- (void)gotoLocation;
+ (CGFloat)annotationPadding;
+ (CGFloat)calloutHeight;

@end
