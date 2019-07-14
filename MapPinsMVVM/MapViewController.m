//
//  MapViewController.m
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/14/19.
//  Copyright © 2019 Harry Netzer. All rights reserved.
//

#import "MapViewController.h"
#import "MapPinsMVVM-Swift.h"
@import Mapbox;

@interface MapViewController () <MGLMapViewDelegate>
@property (strong, nonatomic) IBOutlet MGLMapView *mapView;
@end

@implementation MapViewController

// refresh button on navigation bar
- (IBAction)resetPins:(UIBarButtonItem *)sender {
    [_viewModel resetPins];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayPins];
    
    [_mapView setDelegate:self]; // for clickable pins
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayPins)
                                                 name:@"pinsDidDownload"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pinWasDeleted)
                                                 name:@"pinWasDeleted"
                                               object:nil];
}

// delete annotation whose title matches the title of the last pin deleted
- (void)pinWasDeleted {
    NSArray *annotations = [_mapView annotations];
    NSString *toDelete = [_viewModel lastRemovedPinName];
    for (id<MGLAnnotation> annotation in annotations) {
        if ([annotation title] == toDelete) {
            [_mapView removeAnnotation:annotation];
            return;
        }
    }
    
}

// called when pins download, and on viewDidLoad
- (void)displayPins {
    [_mapView removeAnnotations:[_mapView annotations]]; // remove all old annotations
    [_mapView addAnnotations:[_viewModel makeAnnotations]];
}


// delegate method lets map view display popup when you click pins
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id<MGLAnnotation>)annotation {
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
