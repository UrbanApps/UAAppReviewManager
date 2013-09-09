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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self setupUAAppReviewManager];
    [UAAppReviewManager appLaunched:YES];
	return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	[UAAppReviewManager appEnteredForeground:YES];
}


- (void)setupUAAppReviewManager {
	// Normally, all the setup would be here.
	// But, because we are presenting a few different setups in the example,
	// The config will be in the view controllers
//	[UAAppReviewManager setAppID:@"364709193"]; // iBooks
//	[UAAppReviewManager setDebug:YES];
}


@end
