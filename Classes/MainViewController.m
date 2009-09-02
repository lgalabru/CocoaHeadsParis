//
//  MainViewController.m
//  CocoaHeadsParis
//
//  Created by Guillaume Cerquant on 27/08/09.
//  Copyright MacMation 2009. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>

#import "MainViewController.h"
#import "MainView.h"

#define IMAGE_DEVELOPERS_OFF	@"Developers_OFF.png"
#define IMAGE_DEVELOPERS_ON		@"Developers_ON.png"

@interface MainViewController (PrivateMethods)
- (void)showMapView;
- (void)startDevelopersLightBlinking;
@end


@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	 
	showDevelopers = NO;
	 
	if (nil == developersNeon) {
		NSLog(@"%s ERROR - Nil IBOutlet developersNeon ; probably unconnected");
	}
	if (nil == developersNeon) {
		 NSLog(@"%s ERROR - Nil IBOutlet developersNeon ; probably unconnected");
	}
	 
	[self performSelector:@selector(startDevelopersLightBlinking) withObject:nil afterDelay:3.0];
	 
}

- (void)startDevelopersLightBlinking {
	
	developersNeon.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:IMAGE_DEVELOPERS_OFF], [UIImage imageNamed:IMAGE_DEVELOPERS_ON], nil];
	[developersNeon setAnimationDuration:2.0];
	[developersNeon startAnimating];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (void)showMapView {    
	MapViewController *controller = [[MapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)macGuy:(id)sender {
	[self showMapView];
}

- (IBAction)pcGuy:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://msdn.microsoft.com/en-us/library/8hb2a397(VS.80).aspx"]];
	// In case the vibration is not performed because not enough time
	// [[UIApplication sharedApplication] performSelector:@selector(openURL:) withObject:[NSURL URLWithString:@"http://msdn.microsoft.com/en-us/library/8hb2a397(VS.80).aspx"] afterDelay:1];	
}

- (IBAction)vibrateTheDevice:(id)sender {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (IBAction)showDevelopersDevelopersDevelopersVideo:(id)sender {
	//NSLog(@"showDevelopersDevelopersDevelopersVideo:");
	
	
	if (showDevelopers == YES) {
		return;
	}
	
	//NSLog(@"Add WebView");
	showDevelopers = YES;
	
	NSString* embedHTML = @"<html><head><style type=\"text/css\">body {	background-color: transparent; color: white; }</style></head><body style=\"margin:0\"><embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"%0.0f\" height=\"%0.0f\"></embed></body></html>";
	// Developers, developers, developers
	NSString *url = @"http://www.youtube.com/watch?v=KMU0tzLwhbE";
	NSString *html = [NSString stringWithFormat:embedHTML,url, 100.0f, 80.0f];
	// I'm glad you like it
	NSString *url2 = @"http://www.youtube.com/watch?v=3Q42D_qVLUA";
	NSString *html2 = [NSString stringWithFormat:embedHTML,url2, 100.0f, 80.0f];
	
	//NSLog(@"%@",html);
	//NSLog(@"%@",html2);

	CGRect frame;
	frame.size.width = 100; 
	frame.size.height = 80;
	frame.origin.x = 30; 
	frame.origin.y = 10;
	
	UIWebView *videoView = [[UIWebView alloc] initWithFrame:frame];
	[videoView loadHTMLString:html baseURL:nil];
	[self.view addSubview:videoView];
	[videoView release];
	
	
	frame.origin.x = 180;
	
	UIWebView *videoView2 = [[UIWebView alloc] initWithFrame:frame];
	[videoView2 loadHTMLString:html2 baseURL:nil];
	[self.view addSubview:videoView2];
	[videoView2 release];
	
}


@end











