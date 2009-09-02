//
//  MapViewController.h
//  CocoaHeadsParis
//
//  Created by Michel Ho Fong Fat on 8/27/09.
//  Copyright 2009 Michel Ho Fong Fat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "WhereViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {

	IBOutlet MKMapView				*mMapView;
	IBOutlet UISegmentedControl		*mMapType;
	IBOutlet UISegmentedControl		*mMapLocation;
	CLLocationManager				*mLocationManager;
	Annotation						*mSpiritCafeAnnotation;
	WhereViewController				*mWhereView;
								
}

@property (nonatomic, retain) IBOutlet MKMapView			*mMapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl	*mMapType;
@property (nonatomic, retain) WhereViewController			*mWhereView;

- (IBAction)changeMapType:(UISegmentedControl *)segmentPick;
- (IBAction)changeMapLocation:(UISegmentedControl *)segmentPick;

@end
