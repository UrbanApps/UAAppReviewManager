//
//  UAAppDelegate.m
//  UAAppReviewManagerExampleMac
//
//  Created by Matt Coneybeare on 9/8/13.
//  Copyright (c) 2013 Urban Apps. All rights reserved.
//

#import "UAAppDelegate.h"
#import <UAAppReviewManager.h>

@interface UAAppDelegate ()
- (IBAction)presentStandardPrompt:(id)sender;
- (IBAction)presentCustomizedPrompt:(id)sender;
@end

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

	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[UAAppReviewManager showPromptIfNecessary];
}

- (void)applicationWillBecomeActive:(NSNotification *)notification {
	[UAAppReviewManager showPromptWithShouldPromptBlock:^(NSDictionary *trackingInfo) {
		// This is the block syntx for showing prompts.
		// It lets you decide if it should be shown now or not based on
		// the UAAppReviewManager trackingInfo or any other factor.
		NSLog(@"UAAppReviewManager trackingInfo: %@", trackingInfo);
		// Don't show the prompt now, but do it from the buttons in the example app.
		return NO;
	}];
}

- (void)presentStandardPrompt:(id)sender {
	[self resetAppReviewManager];
	
	// The AppID is the only required setup
	[UAAppReviewManager setAppID:@"409201541"]; // Pages
	
	// Debug means that it will popup on the next available change
	[UAAppReviewManager setDebug:YES];
	
	// YES here means it is ok to show, it is the only override to Debug == YES.
	[UAAppReviewManager userDidSignificantEvent:YES];
}

- (void)presentCustomizedPrompt:(id)sender {
	[self resetAppReviewManager];
	
	// The AppID is the only required setup
	[UAAppReviewManager setAppID:@"409201541"]; // Pages
	
	// Debug means that it will popup on the next available change
	[UAAppReviewManager setDebug:YES];
	
	// This overrides the default value, read from your localized bundle plist
	[UAAppReviewManager setAppName:@"Pong"];
	
	// This overrides the default value, read from the UAAppReviewManager bundle plist
	[UAAppReviewManager setReviewTitle:@"Rate This Shiz"];
	
	// This overrides the default value, read from the UAAppReviewManager bundle plist
	[UAAppReviewManager setReviewMessage:@"Yo! I werked rly hard on this shiz yo, hit me up wit some good ratings yo!"];
	
	// This overrides the default value, read from the UAAppReviewManager bundle plist
	[UAAppReviewManager setCancelButtonTitle:@"Nah, fool"];
	
	// This overrides the default value, read from the UAAppReviewManager bundle plist
	[UAAppReviewManager setRateButtonTitle:@"Hell yeah!"];
	
	// This overrides the default value, read from the UAAppReviewManager bundle plist
	[UAAppReviewManager setRemindButtonTitle:@"Hit me up later..."];
	
	// This overrides the default value of 30, but it doesn't matter here because of Debug mode enabled
	[UAAppReviewManager setDaysUntilPrompt:28];
	
	// This overrides the default value of 1, but it doesn't matter here because of Debug mode enabled
	[UAAppReviewManager setDaysBeforeReminding:13];
	
	// This means that the popup won't show if you have already rated any version of the app, but it doesn't matter here because of Debug mode enabled
	[UAAppReviewManager setShouldPromptIfRated:NO];
	
	// This overrides the default value of 20, but it doesn't matter here because of Debug mode enabled
	[UAAppReviewManager setSignificantEventsUntilPrompt:99];
	
	// This means that UAAppReviewManager won't track this version if it hasn't already, but it doesn't matter here because of Debug mode enabled
	[UAAppReviewManager setTracksNewVersions:NO];
	
	// UAAppReviewManager comes with standard translations for 27 Languages. If you want o provide your own translations instead,
	//  or you change the default title, message or button titles, set this to YES.
	[UAAppReviewManager setUseMainAppBundleForLocalizations:YES];
		
	// This sets the Affiliate code you want to use, but is not required.
	// If you don't set it, it will use my affiliate code as a reward for creating UAAppReviewManager
	[UAAppReviewManager setAffiliateCode:@"11l7j9"];
	
	// This sets the Affiliate campaign code for tracking, but is not required.
	// If you leave it blank, it will use my affiliate code as a reward for creating UAAppReviewManager
	[UAAppReviewManager setAffiliateCampaignCode:@"UAAppReviewManager-ExampleApp"];
	
	
	// UAAppReviewManager is block based, so setup some blocks on events
	[UAAppReviewManager setOnDeclineToRate:^() {
		NSLog(@"The user just declined to rate");
	}];
	[UAAppReviewManager setOnDidDisplayAlert:^() {
		NSLog(@"We just displayed the rating prompt");
	}];
	[UAAppReviewManager setOnDidOptToRate:^() {
		NSLog(@"The user just opted to rate");
	}];
	[UAAppReviewManager setOnDidOptToRemindLater:^() {
		NSLog(@"The user just opted to remind later");
	}];
	
	// UAAppReviewManager has sensible defaults for the NSUserDefault keys it uses, but you can customize that here
	[UAAppReviewManager setKey:@"kSettingsSignificantEventTally" forUAAppReviewManagerKeyType:UAAppReviewManagerKeySignificantEventCount];
	
	// YES here means it is ok to show, but it doesn't matter because we have debug on.
	[UAAppReviewManager userDidSignificantEvent:YES];
}


- (void)resetAppReviewManager {
	// This is just to clean up after the customized one above before showing the standard one.
	[UAAppReviewManager setAppID:@"12345678"];
	[UAAppReviewManager setDebug:NO];
	[UAAppReviewManager setAppName:nil];
	[UAAppReviewManager setReviewTitle:nil];
	[UAAppReviewManager setReviewMessage:nil];
	[UAAppReviewManager setCancelButtonTitle:nil];
	[UAAppReviewManager setRateButtonTitle:nil];
	[UAAppReviewManager setRemindButtonTitle:nil];
	[UAAppReviewManager setDaysUntilPrompt:30];
	[UAAppReviewManager setDaysBeforeReminding:1];
	[UAAppReviewManager setShouldPromptIfRated:YES];
	[UAAppReviewManager setSignificantEventsUntilPrompt:20];
	[UAAppReviewManager setTracksNewVersions:YES];
	[UAAppReviewManager setUseMainAppBundleForLocalizations:NO];
	[UAAppReviewManager setAffiliateCode:@"11l7j9"];
	[UAAppReviewManager setAffiliateCampaignCode:@"UAAppReviewManager"];
	[UAAppReviewManager setOnDeclineToRate:nil];
	[UAAppReviewManager setOnDidDisplayAlert:nil];
	[UAAppReviewManager setOnDidOptToRate:nil];
	[UAAppReviewManager setOnDidOptToRemindLater:nil];
	[UAAppReviewManager setKey:@"UAAppReviewManagerKeySignificantEventCount" forUAAppReviewManagerKeyType:UAAppReviewManagerKeySignificantEventCount];
}



@end
