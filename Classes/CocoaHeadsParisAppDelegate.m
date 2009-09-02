//
//  CocoaHeadsParisAppDelegate.m
//  CocoaHeadsParis
//
//  Created by Guillaume Cerquant on 27/08/09.
//  Copyright MacMation 2009. All rights reserved.
//

#import "CocoaHeadsParisAppDelegate.h"
#import "MainViewController.h"

@implementation CocoaHeadsParisAppDelegate


@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	[application setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	[application setStatusBarHidden:NO animated:YES];
	
	
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
