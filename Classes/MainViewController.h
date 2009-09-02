//
//  MainViewController.h
//  CocoaHeadsParis
//
//  Created by Guillaume Cerquant on 27/08/09.
//  Copyright MacMation 2009. All rights reserved.
//

#import "FlipsideViewController.h"
#import "MapViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	
	IBOutlet UIImageView	*developersNeon;
	IBOutlet UIWebView		*youtubeVideoWebView;
	
	BOOL					showDevelopers;
}

- (IBAction)showInfo;

- (IBAction)macGuy:(id)sender;

- (IBAction)pcGuy:(id)sender;

- (IBAction)vibrateTheDevice:(id)sender;

- (IBAction)showDevelopersDevelopersDevelopersVideo:(id)sender;

@end
