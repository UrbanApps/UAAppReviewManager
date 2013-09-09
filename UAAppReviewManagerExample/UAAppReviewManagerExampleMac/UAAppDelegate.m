//
//  UAAppDelegate.m
//  UAAppReviewManagerExampleMac
//
//  Created by Matt Coneybeare on 9/8/13.
//  Copyright (c) 2013 Urban Apps. All rights reserved.
//

#import "UAAppDelegate.h"
#import <UAAppReviewManager.h>

@implementation UAAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self setupUAAppReviewManager];
}


- (void)setupUAAppReviewManager {
	[UAAppReviewManager setAppID:@"12345678"];
}

@end
