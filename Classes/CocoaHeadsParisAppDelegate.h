//
//  CocoaHeadsParisAppDelegate.h
//  CocoaHeadsParis
//
//  Created by Guillaume Cerquant on 27/08/09.
//  Copyright MacMation 2009. All rights reserved.
//

@class MainViewController;

@interface CocoaHeadsParisAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

