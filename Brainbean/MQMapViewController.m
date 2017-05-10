//
//  MQMapViewController.m
//  Brainbean_test
//
//  Created by local_adm on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "MQMapViewController.h"
#import "Geocoder.h"
#import "AppleCLGeocoder.h"
#import "MGGeocoding.h"
#import "Annotation.h"
#import "MGLCustomAnnotationView.h"

@interface MQMapViewController () <MGLMapViewDelegate, GeocodingDelegate>
@property (nonatomic, weak) IBOutlet MQMapView *mapView;
@end

@implementation MQMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.mapType = MQMapTypeNormal;
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)useGeocodingType:(kGeocodingType)geocodingType
{
    [super useGeocodingType:geocodingType];
    self.geocoder.delegate = self;
}

- (IBAction)mapWasTapped:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D location =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    CLLocation *locationGeocoding = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    
    [self.geocoder getAdressByLocation:locationGeocoding];
}


- (nullable MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id <MGLAnnotation>)annotation
{
    MGLCustomAnnotationView *pinView = nil;
    Annotation *annotationc = (Annotation *)annotation;
    if(annotation != self.mapView.userLocation)
    {
        static NSString *defaultAnnotationID = @"MGLAnnotation";
        pinView = (MGLCustomAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultAnnotationID];
        if ( pinView == nil )
            pinView = [[MGLCustomAnnotationView alloc] initWithReuseIdentifier:defaultAnnotationID];
        
        [pinView reloadViewWithInfo:annotationc.dictData];
    }
    
    return pinView;
    
}

#pragma GeocodingDelegate
- (void)geocodingResult:(NSDictionary *)dict location:(CLLocation *)location
{
    if ([self.mapView annotations].count)
    {
        [self.mapView removeAnnotation:[[self.mapView annotations] lastObject]];
    }
    
    Annotation *annotation = [[Annotation alloc] initWithCoordinate:location.coordinate dictData:dict];

    [self.mapView addAnnotation:annotation];
    [self.mapView setCenterCoordinate:annotation.coordinate zoomLevel:5 animated:YES];
}

@end
