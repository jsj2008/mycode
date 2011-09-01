//
//  locationViewController.m
//  location
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "locationViewController.h"
#import "SFAnnotation.h"
#import "BridgeAnnotation.h"

@implementation locationViewController

@synthesize locationManager;
@synthesize mapView;
@synthesize mapAnnotations;



- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}
+ (CGFloat)calloutHeight;
{
    return 40.0f;
}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
    
     self.locationManager = [[[CLLocationManager alloc] init] autorelease];
     self.locationManager.delegate = self; // Tells the location manager to send updates to this object
     
     [locationManager startUpdatingLocation];
     [super viewDidLoad];
     CLLocation *current=[[[CLLocation alloc]init] autorelease];
     latitude=current.coordinate.latitude;
     longitude=current.coordinate.longitude;
     mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0,0,320,480)];
     [self.view addSubview:mapView];
    mapView.delegate=self;
     [mapView release];
     self.mapView.mapType = MKMapTypeStandard;
     
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
    
    // annotation for the City of San Francisco
    SFAnnotation *sfAnnotation = [[SFAnnotation alloc] init];
    [self.mapAnnotations insertObject:sfAnnotation atIndex:0];
    [sfAnnotation release];
    
    // annotation for Golden Gate Bridge
    BridgeAnnotation *bridgeAnnotation = [[BridgeAnnotation alloc] init];
    [self.mapAnnotations insertObject:bridgeAnnotation atIndex:1];
    [bridgeAnnotation release];
   
    [self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist
    [self.mapView addAnnotations:self.mapAnnotations];

}



-(void)locationManager: (CLLocationManager *)manager
   didUpdateToLocation: (CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    
    [manager stopUpdatingLocation];
  
    latitude=newLocation.coordinate.latitude;
    longitude=newLocation.coordinate.longitude;
     [self gotoLocation];
    
    NSLog(@"lat== %f long == %f",latitude,longitude);
    
}

- (void)gotoLocation
{
    latitude = 28.786996;
    longitude = 77.419281;
    MKCoordinateRegion newRegion;
    newRegion.center.latitude =latitude;
    newRegion.center.longitude =longitude;
    newRegion.span.latitudeDelta = 1.0012872;
    newRegion.span.longitudeDelta = 1.0009863;
    
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error
{
    NSLog(@"error == %@",error);
}

- (void)showDetails:(id)sender
{
    NSLog(@"i m here");
}
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    NSLog(@"I m here");
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
   
    if ([annotation isKindOfClass:[BridgeAnnotation class]])
    {
        // try to dequeue an existing pin view first
        static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
          
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    else if ([annotation isKindOfClass:[SFAnnotation class]])   
    {
        static NSString* SFAnnotationIdentifier = @"SFAnnotationIdentifier";
        MKPinAnnotationView* pinView =
        (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
        if (!pinView)
        {
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:SFAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorGreen;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
