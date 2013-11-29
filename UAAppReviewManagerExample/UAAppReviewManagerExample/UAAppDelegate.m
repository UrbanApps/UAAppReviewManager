//
//  UAAppDelegate.m
//  UAAppReviewManagerExample
//
//  Created by Matt Coneybeare on 9/8/13.
//  Copyright (c) 2013 Urban Apps. All rights reserved.
//

#import "UAAppDelegate.h"
#import <UAAppReviewManager.h>

@implementation UAAppDelegate

+ (void)initialize {
	[UAAppDelegate setupUAAppReviewManager];
}
	
+ (void)setupUAAppReviewManager {
	// Normally, all the setup would be here.
	// But, because we are presenting a few different setups in the example,
	// The config will be in the view controllers
	//	 [UAAppReviewManager setAppID:@"364709193"]; // iBooks
	//
	// It is always best to load UAAppReviewManager as early as possible
	// because it needs to receive application life-cycle notifications,
	// so we will call a simple method on it here to load it up now.
	[UAAppReviewManager setDebug:NO];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UAAppReviewManager showPromptIfNecessary];
	return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	[UAAppReviewManager showPromptWithShouldPromptBlock:^(NSDictionary *trackingInfo) {
		// This is the block syntx for showing prompts.
		// It lets you decide if it should be shown now or not based on
		// the UAAppReviewManager trackingInfo or any other factor.
		NSLog(@"UAAppReviewManager trackingInfo: %@", trackingInfo);
		// Don't show the prompt now, but do it from the buttons in the example app view controller
		return NO;
	}];
}





@end
