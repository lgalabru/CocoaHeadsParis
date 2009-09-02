//
//  MapViewController.m
//  CocoaHeadsParis
//
//  Created by Michel Ho Fong Fat on 8/27/09.
//  Copyright 2009 Michel Ho Fong Fat. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize mMapView;
@synthesize mMapType;
@synthesize mWhereView;

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	//NSLog(@"MapViewController - viewDidUnload");
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	//NSLog(@"MapViewController - viewWillAppear");
	
	[mMapView setDelegate:self];
	[mMapView setShowsUserLocation:YES];
	[mMapView setScrollEnabled:YES];
	[mMapView setZoomEnabled:YES];

	[[mMapView userLocation] setTitle:@"You"];
	[[mMapView userLocation] setSubtitle:@"are here"];
	
	// Spirit Cafe GPS coordinates 48.867886,2.336922
#define SpiritCafeLatitude	48.867886
#define SpiritCafeLongitude	 2.336922

	CLLocation *mSpiritCafeLocation = [[CLLocation alloc]
									   initWithLatitude:SpiritCafeLatitude
									   longitude:SpiritCafeLongitude];
	// Changes the center coordinate of the map and optionally animates the change.
	[mMapView setCenterCoordinate:mSpiritCafeLocation.coordinate animated:NO];
	
	// Create the region
	MKCoordinateRegion region;
	region.center = [mSpiritCafeLocation coordinate];
	// Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta = .01;
	span.longitudeDelta = .01;
	region.span = span;
	
	[mMapView setRegion:region animated:NO];
	
	// Create Spirit Cafe annotation
	mSpiritCafeAnnotation = [[[Annotation alloc] init] retain];
	[mSpiritCafeAnnotation setTitle:@"CocoaHeads Paris"];
	[mSpiritCafeAnnotation setSubtitle:@"Session 5"]; 
	[mSpiritCafeAnnotation setCurrentPoint:[NSNumber numberWithInt:1]];
	[mSpiritCafeAnnotation setCoordinate:[mSpiritCafeLocation coordinate]];
	[mMapView addAnnotation:mSpiritCafeAnnotation];

	// Release objects
	[mSpiritCafeLocation release];	
	
	// Initialize the CoreLocation manager
	mLocationManager = [[CLLocationManager alloc] init];
	// Set self to receive update events
	[mLocationManager setDelegate:self];
	// Set the accuracy of a coordinate value in meters.
	[mLocationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	// Set minimum distance (measured in meters) a device must move laterally
	// before an update event is generated.
	[mLocationManager setDistanceFilter:5.0f];

	// Look whether location services are enabled on the device
	if (![mLocationManager locationServicesEnabled]) {
		//NSLog(@"Location Services Are Not Enabled");
		// TODO: Replace with alert saying "Location Services Are Not Enabled"
	} else {
		// Start
		[mLocationManager startUpdatingLocation];	
	}
}

- (void)viewDidAppear:(BOOL)animated {
	//NSLog(@"MapViewController - viewDidAppear:");

}

- (void)viewDidDisappear:(BOOL)animated {
	//NSLog(@"MapViewController - viewDidDisappear:");
	[mLocationManager stopUpdatingLocation];
	
}

- (void)dealloc {
	[mLocationManager release];
	mLocationManager = nil;
	
	[mMapView release];
	mMapView = nil;

	[mSpiritCafeAnnotation release];
	mSpiritCafeAnnotation = nil;
    [super dealloc];
}

// Change the map type
- (IBAction)changeMapType:(UISegmentedControl *)segmentPick {
	//NSLog(@"MapViewController - changeMapType:");
	
	switch (segmentPick.selectedSegmentIndex) {
		case 0:
			// Plain View
			[mMapView setMapType:MKMapTypeStandard];
			break;
		case 1:
			// Satellite View
			[mMapView setMapType:MKMapTypeSatellite];
			break;
		case 2:
			// Hybrid View
			[mMapView setMapType:MKMapTypeHybrid];
			break;
		default:
			//default
			break;
	}	
}

// Change the map location
- (IBAction)changeMapLocation:(UISegmentedControl *)segmentPick {
	//NSLog(@"MapViewController - changeMapLocation:");
	
	switch (segmentPick.selectedSegmentIndex) {
		case 0:
			// CocoaHeads Location
			[mMapView setCenterCoordinate:[mSpiritCafeAnnotation coordinate] animated:YES];
			[mMapLocation setSelectedSegmentIndex:UISegmentedControlNoSegment];
			break;
		case 1:
			// User Location
			[mMapView setCenterCoordinate:[[mMapView userLocation] coordinate] animated:YES];
			[mMapLocation setSelectedSegmentIndex:UISegmentedControlNoSegment];
			break;
		default:
			//default
			break;
	}		
}


#pragma mark -
#pragma mark MKMapViewDelegate

// Tell that the region displayed by the map view is about to change.
- (void)mapView:(MKMapView *)mapView
							regionWillChangeAnimated:(BOOL)animated {
	//NSLog(@"MapViewController - mapView:regionWillChangeAnimated:");

}

// Tell that the region displayed by the map view just changed.
- (void)mapView:(MKMapView *)mapView
							regionDidChangeAnimated:(BOOL)animated {
	//NSLog(@"MapViewController - mapView:regionDidChangeAnimated:");
	
}

// Tell that the specified map view successfully loaded the needed map data.
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
	//NSLog(@"MapViewController - mapViewDidFinishLoadingMap:");
	[mMapView selectAnnotation:mSpiritCafeAnnotation animated:YES];

}

// Tell that the specified view was unable to load the map data. 
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView
							withError:(NSError *)error {
	//NSLog(@"MapViewController - mapViewDidFailLoadingMap:withError:");

}

// Returns the view associated with the specified annotation object.
- (MKAnnotationView *)mapView:(MKMapView *)mapView
							viewForAnnotation:(Annotation *)annotation {
	//NSLog(@"MapViewController - mapView:viewForAnnotation:");

	//if its userlocation 
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}
	
	int postag = 0;
	
	MKPinAnnotationView *mPinView = [[MKPinAnnotationView alloc]
									initWithAnnotation:annotation
									reuseIdentifier:@"currentlocation"];
	[mPinView setPinColor:MKPinAnnotationColorRed];

	
	UIImageView *imageView;
	imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_croissant_pinpoint.png"]];
	[imageView autorelease];
	
	postag = [[annotation currentPoint] intValue];
	
	UIButton * button;
	button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[button setTag:postag];
	
	// Set the button as the callout view
	[mPinView setLeftCalloutAccessoryView:imageView];
	[mPinView setRightCalloutAccessoryView:button];
	[mPinView setAnimatesDrop:YES];
	[mPinView setCanShowCallout:YES];
	[mPinView setCalloutOffset:CGPointMake(-5, 5)];
	
	return [mPinView autorelease];
}

// Tell that one or more annotation views were added to the map.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
	//NSLog(@"MapViewController - mapView:didAddAnnotationViews:");

}

// Tell that the user tapped one of the annotation view’s accessory buttons.
- (void)mapView:(MKMapView *)mapView
							annotationView:(MKAnnotationView *)view
							calloutAccessoryControlTapped:(UIControl *)control {
	//NSLog(@"MapViewController - mapView:annotationView:calloutAccessoryControlTapped:");

		
	if ([((UIButton *)control) tag] == 1) {
		UIViewController *detailController = [[WhereViewController alloc] initWithNibName:@"WhereView" bundle:nil];
		[self presentModalViewController:detailController animated:YES];
		[detailController release];
	}

}

#pragma mark -
#pragma mark CLLocationManagerDelegate

// Tell that the location manager was unable to retrieve a location value.
- (void)locationManager:(CLLocationManager *)manager
							didFailWithError:(NSError *)error {
	//NSLog(@"MapViewController - locationManager:didFailWithError:");
}

// Tell that the location manager received updated heading information.
- (void)locationManager:(CLLocationManager *)manager
							didUpdateHeading:(CLHeading *)newHeading {
	//NSLog(@"MapViewController - locationManager:didUpdateHeading:");	
}

// Tell the delegate that a new location value is available.
- (void)locationManager:(CLLocationManager *)manager
							didUpdateToLocation:(CLLocation *)newLocation
							fromLocation:(CLLocation *)oldLocation {
	//NSLog(@"MapViewController - locationManager:didUpdateToLocation:fromLocation:");
}

// Asks the delegate whether the heading calibration panel should be displayed.
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
	//NSLog(@"MapViewController - locationManagerShouldDisplayHeadingCalibration:");
	return NO;
}



@end
