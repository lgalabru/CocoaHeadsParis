//
//  WhereViewController.h
//  CocoaHeadsParis
//
//  Created by Michel Ho Fong Fat on 8/27/09.
//  Copyright 2009 Michel Ho Fong Fat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface WhereViewController : UIViewController <MFMailComposeViewControllerDelegate> {

	IBOutlet UIWebView					*mWebView;
	IBOutlet UIActivityIndicatorView	*mWebViewActivityIndicator;
	IBOutlet UIActivityIndicatorView	*mWebViewActivityIndicator2;
	IBOutlet UIImageView				*logoWaitImage;

}

@property (nonatomic, retain) IBOutlet UIWebView					*mWebView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView		*mWebViewActivityIndicator;

- (IBAction)goBack:(UISegmentedControl *)sender;

- (IBAction)sendByEmail:(id)sender;

@end
