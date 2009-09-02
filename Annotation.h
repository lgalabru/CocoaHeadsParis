//
//  Annotation.h
//  CocoaHeadsParis
//
//  Created by Michel Ho Fong Fat on 8/27/09.
//  Copyright 2009 Michel Ho Fong Fat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Annotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D		coordinate;
    NSString					*title;
    NSString					*subtitle;
	NSNumber					*currentPoint;
}

@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, retain)	NSString				*title;
@property (nonatomic, retain)	NSString				*subtitle;
@property (nonatomic, retain)	NSNumber				*currentPoint;

@end
