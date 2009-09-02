//
//  Annotation.m
//  CocoaHeadsParis
//
//  Created by Michel Ho Fong Fat on 8/27/09.
//  Copyright 2009 Michel Ho Fong Fat. All rights reserved.
//

#import "Annotation.h"


@implementation Annotation

@synthesize coordinate, title, subtitle, currentPoint;

-(void)dealloc {
    [title release];
    [subtitle release];
	[currentPoint release];
    [super dealloc];
}

@end
