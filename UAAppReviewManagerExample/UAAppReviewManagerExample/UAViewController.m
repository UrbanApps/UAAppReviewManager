//
//  UAViewController.m
//  UAAppReviewManagerExample
//
//  Created by Matt Coneybeare on 9/8/13.
//  Copyright (c) 2013 Urban Apps. All rights reserved.
//

#import "UAViewController.h"
#import <UAAppReviewManager.h>

@interface UAViewController ()
- (IBAction)presentStandardPrompt:(id)sender;
- (IBAction)presentCustomizedPrompt:(id)sender;
@end

@implementation UAViewController

- (void)presentStandardPrompt:(id)sender {
	[self resetAppReviewManager];
	
	// The AppID is the only required setup
	[UAAppReviewManager setAppID:@"364709193"]; // iBooks

	// Debug means that it will popup on the next available change
	[UAAppReviewManager setDebug:YES];
	
	// YES here means it is ok to show, it is the only override to Debug == YES.
	[UAAppReviewManager userDidSignificantEvent:YES];
}

- (void)presentCustomizedPrompt:(id)sender {
	[self resetAppReviewManager];
	
	// The AppID is the only required setup
	[UAAppReviewManager setAppID:@"364709193"]; // iBooks
	
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
	
	// This overrides the default of NO and is iOS 6+. Instead of going to the review page in the App Store App,
	//  the user goes to the main page of the app, in side of this app. Downsides are that it doesn't go directly to
	//  reviews and doesn't take affiliate codes
	[UAAppReviewManager setOpensInStoreKit:YES];
	
	// If you are opening in StoreKit, you can change whether or not to animated the push of the View Controller
	[UAAppReviewManager setUsesAnimation:YES];
	
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
	[UAAppReviewManager setOnWillPresentModalView:^(BOOL animated) {
		NSLog(@"About to present the modal view: %@animated", (animated?@"":@"not "));
	}];
	[UAAppReviewManager setOnDidDismissModalView:^(BOOL animated) {
		NSLog(@"Just dismissed the modal view: %@animated", (animated?@"":@"not "));
	}];
	
	// UAAppReviewManager has sensible defaults for the NSUserDefault keys it uses, but you can customize that here
	[UAAppReviewManager setKey:@"kSettingsSignificantEventTally" forUAAppReviewManagerKeyType:UAAppReviewManagerKeySignificantEventCount];
	
	// YES here means it is ok to show, but it doesn't matter because we have debug on.
	[UAAppReviewManager userDidSignificantEvent:YES];
	
	// You can also call it with a block to circumvent any of UAAppReviewManager's should rate logic.
	[UAAppReviewManager userDidSignificantEventWithShouldPromptBlock:^BOOL(NSDictionary *trackingInfo) {
		//the tracking info dictionary has all the keys/value UAAppReviewManager uses to determine whether or not to show a prompt
		return NO;
	}];
	
	// Or you can set a global one to get one last chance to stop the prompt, or do your own logic
	[UAAppReviewManager setShouldPromptBlock:^BOOL(NSDictionary *trackingInfo) {
		// This will be called once all other rating conditions have been met, but before the prompt.
		// if a local UAAppReviewManagerShouldPromptBlock is called using the local methods, this will not be called.
		return NO;
	}];
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
	[UAAppReviewManager setOpensInStoreKit:NO];
	[UAAppReviewManager setUsesAnimation:YES];
	[UAAppReviewManager setAffiliateCode:@"11l7j9"];
	[UAAppReviewManager setAffiliateCampaignCode:@"UAAppReviewManager"];
	[UAAppReviewManager setOnDeclineToRate:nil];
	[UAAppReviewManager setOnDidDisplayAlert:nil];
	[UAAppReviewManager setOnDidOptToRate:nil];
	[UAAppReviewManager setOnDidOptToRemindLater:nil];
	[UAAppReviewManager setOnWillPresentModalView:nil];
	[UAAppReviewManager setOnDidDismissModalView:nil];
	[UAAppReviewManager setKey:@"UAAppReviewManagerKeySignificantEventCount" forUAAppReviewManagerKeyType:UAAppReviewManagerKeySignificantEventCount];
}

@end
