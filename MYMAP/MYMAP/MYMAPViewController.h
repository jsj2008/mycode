//
//  MYMAPViewController.h
//  MYMAP
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MYMAPViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate> 
{
    CLLocationManager *locationManager;
     MKMapView *mapView;
    float latitude;
    float longitude;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain)  MKMapView *mapView;
- (void)gotoLocation;
@end
