//
//  AppleMapViewController.m
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "AppleMapViewController.h"
#import <MapKit/MapKit.h>
#import "MKCustomAnnotationView.h"
#import "Annotation.h"

@interface AppleMapViewController () <MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end

@implementation AppleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mapWasTapped:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D location =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = location;
    mapRegion.span.latitudeDelta = 2;
    mapRegion.span.longitudeDelta = 2;
    
    [self.mapView setRegion:mapRegion animated: YES];
    
    
    CLLocation *locationGeocoding = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    
    [self.geocoder getAdressByLocation:locationGeocoding withCompletionHandler:^(NSDictionary *dict) {
        
        if ([[self.mapView annotations] count])
            [self.mapView removeAnnotation:[[self.mapView annotations] lastObject]];
        
        Annotation *point = [[Annotation alloc] initWithCoordinate:location dictData:dict];
        
        [self.mapView addAnnotation:point];

        
    }];
    
    NSLog(@"Location found from Apple Map: %f %f",location.latitude,location.longitude);
}

#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKCustomAnnotationView *pinView = nil;
    Annotation *annotationc = (Annotation *)annotation;
    if(annotation != self.mapView.userLocation)
    {
        static NSString *defaultAnnotationID = @"MKCustomAnnotation";
        pinView = (MKCustomAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultAnnotationID];
        if ( pinView == nil)
            pinView = [[MKCustomAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultAnnotationID];
        
        [pinView reloadViewWithInfo:annotationc.dictData];
    }
    
    return pinView;
}


@end
