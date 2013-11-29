//
//  UAAppReviewManager.h
//
//  Created by Matt Coneybeare on 9/8/13.
//  http://matt.coneybeare.me
//  Copyright (c) 2013 Urban Apps. All rights reserved.
//  http://urbanapps.com
//


#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef enum {
    UAAppReviewManagerKeyFirstUseDate = 0,
    UAAppReviewManagerKeyUseCount,
    UAAppReviewManagerKeySignificantEventCount,
	UAAppReviewManagerKeyCurrentVersion,
    UAAppReviewManagerKeyRatedCurrentVersion,
    UAAppReviewManagerKeyDeclinedToRate,
    UAAppReviewManagerKeyReminderRequestDate,
	UAAppReviewManagerKeyPreviousVersion,
	UAAppReviewManagerKeyPreviousVersionRated,
	UAAppReviewManagerKeyPreviousVersionDeclinedToRate,
	UAAppReviewManagerKeyRatedAnyVersion,
    UAAppReviewManagerKeyAppiraterMigrationCompleted
} UAAppReviewManagerKeyType;

@class UAAppReviewManager;
typedef void (^UAAppReviewManagerBlock)(void);
typedef void (^UAAppReviewManagerAnimateBlock)(BOOL);
typedef BOOL (^UAAppReviewManagerShouldPromptBlock)(NSDictionary *trackingInfo);

@protocol UAAppReviewManagerDefaultsObject <NSObject>
@required
- (id)objectForKey:(NSString *)defaultName;
- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;
- (BOOL)synchronize;
@end

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

// iOS Interface
@interface UAAppReviewManager : NSObject <UIAlertViewDelegate, SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) UIAlertView *ratingAlert;

#else

// OS X
@interface UAAppReviewManager : NSObject <NSAlertDelegate>

@property(nonatomic, strong) NSAlert *ratingAlert;

#endif

/*
 * Get/Set your Apple generated software id.
 * This is the only required setup value. No default.
 */
+ (NSString *)appID;
+ (void)setAppID:(NSString *)appID;

/*
 * Get/Set the App Name to use in the prompt
 * Default value is your localized display name from the info.plist
 */
+ (NSString *)appName;
+ (void)setAppName:(NSString *)appName;

/*
 * Get/Set the title to use on the review prompt.
 * Default value is a localized "Rate <appName>"
 */
+ (NSString *)reviewTitle;
+ (void)setReviewTitle:(NSString *)reviewTitle;

/*
 * Get/Set the message to use on the review prompt.
 * Default value is a localized 
 *  "If you enjoy using <appName>, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!"
 */
+ (NSString *)reviewMessage;
+ (void)setReviewMessage:(NSString *)reviewMessage;

/*
 * Get/Set the cancel button title to use on the review prompt.
 * Default value is a localized "No, Thanks"
 */
+ (NSString *)cancelButtonTitle;
+ (void)setCancelButtonTitle:(NSString *)cancelButtonTitle;

/*
 * Get/Set the rate button title to use on the review prompt.
 * Default value is a localized "Rate <appName>"
 */
+ (NSString *)rateButtonTitle;
+ (void)setRateButtonTitle:(NSString *)rateButtonTitle;

/*
 * Get/Set the remind me later button title to use on the review prompt.
 * Default value is a localized "Remind me later"
 */
+ (NSString *)remindButtonTitle;
+ (void)setRemindButtonTitle:(NSString *)remindButtonTitle;

/*
 * Get/Set the NSUserDefault keys that store the usage data for UAAppReviewManager
 * Default values are in the form of "UAAppReviewManagerKey<Setting>"
 */
+ (NSString *)keyForUAAppReviewManagerKeyType:(UAAppReviewManagerKeyType)keyType;
+ (void)setKey:(NSString *)key forUAAppReviewManagerKeyType:(UAAppReviewManagerKeyType)keyType;

/*
 * Get/Set the prefix to the NSUserDefault keys that store the usage data for UAAppReviewManager
 * Default value is the App ID, and it is prepended to the keys for key type, above
 * This prevents different apps using a shared Key/Value store from overwriting each other.
 */
+ (NSString *)keyPrefix;
+ (void)setKeyPrefix:(NSString *)keyPrefix;

/*
 * Get/Set the object that stores the usage data for UAAppReviewManager
 * value is weakly referenced, so ensure it's lifecycle is managed properly.
 * Default values is [NSUserDefaults standardUserDefaults]
 */
+ (NSObject<UAAppReviewManagerDefaultsObject> *)userDefaultsObject;
+ (void)setUserDefaultsObject:(NSObject<UAAppReviewManagerDefaultsObject> *)userDefaultsObject;

/*
 * Users will need to have the same version of your app installed for this many
 * days before they will be prompted to rate it.
 * Default => 30
 */
+ (NSUInteger)daysUntilPrompt;
+ (void)setDaysUntilPrompt:(NSUInteger)daysUntilPrompt;

/*
 * An example of a 'use' would be if the user launched the app. Bringing the app
 * into the foreground (on devices that support it) would also be considered
 * a 'use'. You tell UAAppReviewManager about these events using the two methods:
 * [UAAppReviewManager appLaunched:]
 * [UAAppReviewManager appEnteredForeground:]
 
 * Users need to 'use' the same version of the app this many times before
 * before they will be prompted to rate it.
 * Default => 20
 */
+ (NSUInteger)usesUntilPrompt;
+ (void)setUsesUntilPrompt:(NSUInteger)usesUntilPrompt;

/*
 * A significant event can be anything you want to be in your app. In a
 * telephone app, a significant event might be placing or receiving a call.
 * In a game, it might be beating a level or a boss. This is just another
 * layer of filtering that can be used to make sure that only the most
 * loyal of your users are being prompted to rate you on the app store.
 * If you leave this at a value of 0 (dfault), then this won't be a criterion
 * used for rating. To tell UAAppReviewManager that the user has performed
 * a significant event, call the method:
 * [UAAppReviewManager userDidSignificantEvent:];
 * Default => 0
 */
+ (NSUInteger)significantEventsUntilPrompt;
+ (void)setSignificantEventsUntilPrompt:(NSInteger)significantEventsUntilPrompt;

/*
 * Once the rating alert is presented to the user, they might select
 * 'Remind me later'. This value specifies how many days UAAppReviewManager
 * will wait before reminding them.
 * Default => 1
 */
+ (NSUInteger)daysBeforeReminding;
+ (void)setDaysBeforeReminding:(NSUInteger)daysBeforeReminding;

/*
 * By default, UAAppReviewManager tracks all new bundle versions.
 * When it detects a new version, it resets the values saved for usage,
 * significant events, popup shown, user action etc...
 * By setting this to NO, UAAppReviewManager will ONLY track the version it
 * was initialized with. If this setting is set to YES, UAAppReviewManager
 * will reset after each new version detection.
 * Default => YES
 */
+ (BOOL)tracksNewVersions;
+ (void)setTracksNewVersions:(BOOL)tracksNewVersions;

/*
 * If the user has rated the app once before, and you don't want it to show on
 * a new version, set this to NO. This is useful if you release small bugfix
 * versions and don't want to pester your users with popups for every minor
 * version. For example, you might set this to NO for every minor build, then
 * when you push a major version upgrade, leave it as YES to ask for a rating again.
 * Default => YES
 */
+ (BOOL)shouldPromptIfRated;
+ (void)setShouldPromptIfRated:(BOOL)shouldPromptIfRated;

/*
 * If set to YES, the main bundle will always be used to load localized strings.
 * Set this to YES if you have provided your own custom localizations in
 * UAAppReviewManagerLocalizable.strings in your main bundle
 * Default => NO.
 */
+ (BOOL)useMainAppBundleForLocalizations;
+ (void)setUseMainAppBundleForLocalizations:(BOOL)useMainAppBundleForLocalizations;

/*
 * If you are an Apple Affiliate (you should be), enter your code here.
 * If none is set, the author's code will be used as it is better to be set as something
 * rather than nothing. If you want to thank me for making UAAppReviewManager, feel free
 * to leave this value at it's default.
 */
+ (NSString *)affiliateCode;
+ (void)setAffiliateCode:(NSString*)affiliateCode;

/*
 * If you are an Apple Affiliate (you should be), enter your campaign code here.
 * Default => "UAAppReviewManager"
 */
+ (NSString *)affiliateCampaignCode;
+ (void)setAffiliateCampaignCode:(NSString*)affiliateCampaignCode;

/*
 * 'YES' will show the UAAppReviewManager alert everytime. Useful for testing
 * how your message looks and making sure the link to your app's review page works.
 * Calling this method in a production build (DEBUG preprocessor macro is not defined)
 * has no effect. In app store builds, you don't have to worry about accidentally
 * leaving setDebug to YES
 * Default => NO
 */
+ (BOOL)debug;
+ (void)setDebug:(BOOL)debug;


#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
/*
 * Set whether or not UAAppReviewManager uses animation when pushing modal StoreKit
 * view controllers for the app.
 * Default => YES
 */
+ (BOOL)usesAnimation;
+ (void)setUsesAnimation:(BOOL)usesAnimation;

/*
 * If set to YES, UAAppReviewManager will open App Store link inside the app using
 * SKStoreProductViewController. By default, this is NO. The reason why is that
 * itunes affiliate codes do not work (as of iOS 7 RC1) inside StoreKit
 * Default => NO
 */
+ (BOOL)opensInStoreKit;
+ (void)setOpensInStoreKit:(BOOL)opensInStoreKit;

#endif


/*
 * Tells UAAppReviewManager that the app has launched and that the 'uses'
 * count should be incremented. You should call this method at the end of your
 * application delegate's application:didFinishLaunchingWithOptions: method.
 *
 * If the app has been used enough to be rated (and enough significant events),
 * you can suppress the rating alert by passing NO for canPromptForRating.
 * The rating alert will simply be postponed until it is called again with YES
 * for canPromptForRating. The rating alert can also be triggered by
 * appEnteredForeground: and userDidSignificantEvent:
 * (as long as you pass YES for canPromptForRating in those methods).
 */
+ (void)appLaunched:(BOOL)canPromptForRating __attribute__((deprecated("UAAppReviewManager uses (UI/NS)ApplicationDidFinishLaunchingNotification. Use showPromptIfNecessary instead if you want to prompt now")));


/*
 * Tells UAAppReviewManager that the app has launched and that the 'uses'
 * count should be incremented. You can call this method at the end of your
 * application delegate's application:didFinishLaunchingWithOptions: method.
 *
 * This is similar to the appLaunched method, but allows the passing of a
 * UAAppReviewManagerShouldPromptBlock that will be executed before prompting.
 * The block passes all the keys and values that UAAppReviewManager uses to 
 * determine if it the prompt conditions have been met, and it is up to you
 * to use this info and return a BOOL on whether or not the prompt should be shown.
 * The block is run synchronous and on the main queue, so be sure to handle it appropriately.
 * Return YES to proceed and show the prompt, return NO to kill the pending presentation.
 */
+ (void)appLaunchedWithShouldPromptBlock:(UAAppReviewManagerShouldPromptBlock)shouldPromptBlock  __attribute__((deprecated("UAAppReviewManager uses (UI/NS)ApplicationDidFinishLaunchingNotification. Use showPromptWithShouldPromptBlock instead if you want to prompt now")));


/*
 * Tells UAAppReviewManager that the app was brought to the foreground.
 * You should call this method from the application delegate's
 * applicationWillEnterForeground: method.
 *
 * If the app has been used enough to be rated (and enough significant events),
 * you can suppress the rating alert by passing NO for canPromptForRating.
 * The rating alert will simply be postponed until it is called again with YES
 * for canPromptForRating. The rating alert can also be triggered by
 * appLaunched: and userDidSignificantEvent:
 * (as long as you pass YES for canPromptForRating in those methods).
 */
+ (void)appEnteredForeground:(BOOL)canPromptForRating  __attribute__((deprecated("UAAppReviewManager uses UIApplicationWillEnterForeground/NSApplicationWillBecomeActiveNotification. Use showPromptIfNecessary instead if you want to prompt now")));


/*
 * Tells UAAppReviewManager that the app was brought to the foreground.
 * You should call this method from the application delegate's
 * applicationWillEnterForeground: method.
 *
 * This is similar to the appEnteredForeground method, but allows the passing of a
 * UAAppReviewManagerShouldPromptBlock that will be executed before prompting.
 * The block passes all the keys and values that UAAppReviewManager uses to
 * determine if it the prompt conditions have been met, and it is up to you
 * to use this info and return a BOOL on whether or not the prompt should be shown.
 * The block is run synchronous and on the main queue, so be sure to handle it appropriately.
 * Return YES to proceed and show the prompt, return NO to kill the pending presentation.
 */
+ (void)appEnteredForegroundWithShouldPromptBlock:(UAAppReviewManagerShouldPromptBlock)shouldPromptBlock  __attribute__((deprecated("UAAppReviewManager uses UIApplicationWillEnterForeground/NSApplicationWillBecomeActiveNotification. Use showPromptWithShouldPromptBlock instead if you want to prompt now")));


/*
 * Tells UAAppReviewManager that the user performed a significant event.
 * A significant event is whatever you want it to be. If you're app is used
 * to make VoIP calls, then you might want to call this method whenever the
 * user places a call. If it's a game, you might want to call this whenever
 * the user beats a level boss.
 *
 * If the user has performed enough significant events and used the app enough,
 * you can suppress the rating alert by passing NO for canPromptForRating. The
 * rating alert will simply be postponed until it is called again with YES for
 * canPromptForRating. The rating alert can also be triggered by appLaunched:
 * and appEnteredForeground: (as long as you pass YES for canPromptForRating
 * in those methods).
 */
+ (void)userDidSignificantEvent:(BOOL)canPromptForRating;


/*
 * Tells UAAppReviewManager that the user performed a significant event.
 * A significant event is whatever you want it to be. If you're app is used
 * to make VoIP calls, then you might want to call this method whenever the
 * user places a call. If it's a game, you might want to call this whenever
 * the user beats a level boss.
 *
 * This is similar to the userDidSignificantEvent method, but allows the passing of a
 * UAAppReviewManagerShouldPromptBlock that will be executed before prompting.
 * The block passes all the keys and values that UAAppReviewManager uses to
 * determine if it the prompt conditions have been met, and it is up to you
 * to use this info and return a BOOL on whether or not the prompt should be shown.
 * The block is run synchronous and on the main queue, so be sure to handle it appropriately.
 * Return YES to proceed and show the prompt, return NO to kill the pending presentation.
 */
+ (void)userDidSignificantEventWithShouldPromptBlock:(UAAppReviewManagerShouldPromptBlock)shouldPromptBlock;


/*
 * Tells UAAppReviewManager to show the prompt (a rating alert). The prompt
 * will be showed if there is an internet connection available, the user hasn't
 * declined to rate, hasn't rated current version and you are tracking new versions.
 *
 * You could call to show the prompt regardless of UAAppReviewManager settings,
 * for instance, in the case of some special event in your app.
 */
+ (void)showPrompt;

/*
 * Tells UAAppReviewManager to show the review prompt alert if all restrictions have been met.
 * The prompt will be shown if all restrictions are met, there is an internet connection available,
 * the user hasn't declined to rate, hasn't rated current version, and you are tracking new versions.
 *
 * You could call to show the prompt, for instance, in the case of some special event in your app,
 * like a user login.
 */
+ (void)showPromptIfNecessary;
	
/*
 * Tells UAAppReviewManager to show the review prompt alert.
 *
 * This is similar to the showPromptIfNecessary method, but allows the passing of a
 * UAAppReviewManagerShouldPromptBlock that will be executed before prompting.
 * The block passes all the keys and values that UAAppReviewManager uses to
 * determine if it the prompt conditions have been met, and it is up to you
 * to use this info and return a BOOL on whether or not the prompt should be shown.
 * The block is run synchronous and on the main queue, so be sure to handle it appropriately.
 * Return YES to proceed and show the prompt, return NO to kill the pending presentation.
 */
+ (void)showPromptWithShouldPromptBlock:(UAAppReviewManagerShouldPromptBlock)shouldPromptBlock;

/*
 * This is the review URL string, generated by substituting the appID, affiliate code
 * and affilitate campaign code into the template URL.
*/
+ (NSString *)reviewURLString;

/*
 * Tells UAAppReviewManager to open the App Store page where the user can specify a
 * rating for the app. Also records the fact that this has happened, so the
 * user won't be prompted again to rate the app.
 *
 * The only case where you should call this directly is if your app has an
 * explicit "Rate this app" command somewhere.  In all other cases, don't worry
 * about calling this -- instead, just call the other functions listed above,
 * and let UAAppReviewManager handle the bookkeeping of deciding when to ask the user
 * whether to rate the app.
 */
+ (void)rateApp;

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
/*
 * Tells UAAppReviewManager to immediately close any open rating modals
 * for instance, a StoreKit rating View Controller.
*/
+ (void)closeModalPanel;
#endif

/*
 * UAAppReviewManager uses blocks instead of delegate methods for callbacks.
 * Default is nil for all of them.
 */
+ (void)setOnDidDisplayAlert:(UAAppReviewManagerBlock)didDisplayAlertBlock;
+ (void)setOnDeclineToRate:(UAAppReviewManagerBlock)didDeclineToRateBlock;
+ (void)setOnDidOptToRate:(UAAppReviewManagerBlock)didOptToRateBlock;
+ (void)setOnDidOptToRemindLater:(UAAppReviewManagerBlock)didOptToRemindLaterBlock;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
+ (void)setOnWillPresentModalView:(UAAppReviewManagerAnimateBlock)willPresentModalViewBlock;
+ (void)setOnDidDismissModalView:(UAAppReviewManagerAnimateBlock)didDismissModalViewBlock;
#endif

/*
 * The setShouldPromptBlock is called just after all the rating coditions
 * have been met and UAAppReviewManager has decided it should display a prompt,
 * and just before the prompt actually displays.
 *
 * The block passes all the keys and values that UAAppReviewManager used to
 * determine that the prompt conditions had been met, but it is up to you
 * to use this info and return a BOOL on whether or not the prompt should be shown.
 * Return YES to proceed and show the prompt, return NO to kill the pending presentation.
 */
+ (void)setShouldPromptBlock:(UAAppReviewManagerShouldPromptBlock)shouldPromptBlock;

/*
 * These methods are for backwards compatibility with Appirater. They simply call the
 * appropriate UAAppReviewManager methods. This allows installation to be a simple find/replace
 * of 'Appirater' with 'UAAppReviewManager'
 */
+ (void)setAppId:(NSString*)appId __attribute__((deprecated("Use setAppID:")));
+ (void)setTimeBeforeReminding:(double)value __attribute__((deprecated("Use setDaysBeforeReminding:")));
+ (void)setAlwaysUseMainBundle:(BOOL)useMainBundle __attribute__((deprecated("Use setUseMainAppBundleForLocalizations:")));
+ (void)appLaunched __attribute__((deprecated("Use appLaunched: instead")));
+ (void)setDelegate:(id)delegate __attribute__((deprecated("Use the block-based callbacks instead")));
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
+ (void)setOpenInAppStore:(BOOL)openInAppStore __attribute__((deprecated("Use setOpensInStoreKit:")));
#endif
@end
