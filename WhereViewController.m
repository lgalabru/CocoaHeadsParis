//
//  WhereViewController.m
//  CocoaHeadsParis
//
//  Created by Michel Ho Fong Fat on 8/27/09.
//  Copyright 2009 Michel Ho Fong Fat. All rights reserved.
//

#import "WhereViewController.h"

#define URL_ADDRESS_FOR_DETAILS		@"http://www.macmation.com/%@/%@_Session_5.m.html"

@interface WhereViewController (PrivateMethods)

- (NSURL *)someSecretInformation;

@end


@implementation WhereViewController

@synthesize mWebView;
@synthesize mWebViewActivityIndicator;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

// Nothing really fancy here. Just don't want to have the URL defined at the top of this file giving you the url just by looking at it :-p
// Security by obvious-fuscation!!!
- (NSURL *)someSecretInformation {
	return [NSURL URLWithString:[NSString stringWithFormat:URL_ADDRESS_FOR_DETAILS, [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"], [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"]]]; 
}

- (void)viewDidAppear:(BOOL)animated {
	NSURLRequest	*requestObj;
	
	if (nil == logoWaitImage) {
		 NSLog(@"%s ERROR - Nil IBOutlet logoWaitImage ; probably unconnected");
	}
	if (nil == mWebViewActivityIndicator) {
		 NSLog(@"%s ERROR - Nil IBOutlet mWebViewActivityIndicator ; probably unconnected");
	}
	if (nil == mWebViewActivityIndicator2) {
		 NSLog(@"%s ERROR - Nil IBOutlet mWebViewActivityIndicator2 ; probably unconnected");
	}
	
	
	

	// URL Request Object
	requestObj = [NSURLRequest requestWithURL:[self someSecretInformation]];
	
	// Load the request in the UIWebView.
	[mWebView loadRequest:requestObj];
	
}

- (void)viewDidDisappear:(BOOL)animated {
	//NSLog(@"WhereViewController - viewDidDisappear:");
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
	[mWebView release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIWebView Delegate Methods
- (void)webViewDidStartLoad: (UIWebView *)webView {
	[mWebViewActivityIndicator startAnimating];
	[mWebViewActivityIndicator2 startAnimating];
	[logoWaitImage setHidden:NO];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad: (UIWebView *)webView {
	[mWebViewActivityIndicator stopAnimating];
	[mWebViewActivityIndicator2 stopAnimating];
	[logoWaitImage setHidden:YES];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	//NSLog(@"webView - didFailLoadWithError");
}


#pragma mark -
#pragma mark Actions

- (IBAction)goBack:(UISegmentedControl *)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}



- (IBAction)sendByEmail:(id)sender {
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"CocoaHeads Paris - Information confidentielle"];
	
	UIImage *mPic = [UIImage imageNamed:@"logo_croissant_128.png"];
	NSData *imageData = UIImagePNGRepresentation(mPic);
	[picker addAttachmentData:imageData mimeType:@"image/png" fileName:@"logo_croissant_128.png"];
	
	NSString *emailBody = @"Trouve la date et le lieu du prochain meeting CocoaHeads<br/>en suivant le lien <a href=\"http://www.macmation.com/CocoaHeads/\">http://www.macmation.com/CocoaHeads/</a><br/><br/>Une source anonyme!";
	[picker setMessageBody:emailBody isHTML:YES];
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}


#pragma mark -
#pragma mark MessageUI Delegate Methods

-(void)mailComposeController:(MFMailComposeViewController*)controller
		 didFinishWithResult:(MFMailComposeResult)result
					   error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}



@end
