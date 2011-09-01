//
//  MYMAPViewController.m
//  MYMAP
//
//  Created by Ayush Goel on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYMAPViewController.h"

@implementation MYMAPViewController
@synthesize locationManager;
@synthesize mapView;


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

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
      
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self; // Tells the location manager to send updates to this object
   
    [locationManager startUpdatingLocation];
    [super viewDidLoad];
    
    
    
   
}



-(void)locationManager: (CLLocationManager *)manager
   didUpdateToLocation: (CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    
    [manager stopUpdatingLocation];

     latitude=newLocation.coordinate.latitude;
     longitude=newLocation.coordinate.longitude;
     mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0,0,320,480)];
     [self.view addSubview:mapView];
     [mapView release];
      self.mapView.mapType = MKMapTypeStandard;
      [self gotoLocation];

    NSLog(@"lat== %f long == %f",latitude,longitude);
   
}

- (void)gotoLocation
{

    MKCoordinateRegion newRegion;
    newRegion.center.latitude =latitude;
    newRegion.center.longitude =longitude;
    newRegion.span.latitudeDelta = 0.012872;
    newRegion.span.longitudeDelta = 0.009863;
    
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error
{
    NSLog(@"error == %@",error);
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
