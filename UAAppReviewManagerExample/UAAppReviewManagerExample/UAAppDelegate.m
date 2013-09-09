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
	[UAAppReviewManager setAppID:@"364709193"]; // iBooks
	[UAAppReviewManager setDebug:YES];
}


@end
