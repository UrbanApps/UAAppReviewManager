# UAAppReviewManager Changelog

### 0.1.4
 - Allow compilation in Xcode 4
 - Remove LANGUAGE placeholder from iOS 7 template URL, allowing AppStore.app to decide

### 0.1.3
 - Added the Changelog
 - Added the `UAAppReviewManagerDefaultsObject` protocol and `userDefaultsObject`. This allows you to set the object that UAAppReviewManager uses to save the usage data. Without customization, it defaults to `[NSUserDefaults standardUserDefaults]`. One of the areas it is useful is in Apps where you have the iCloud Key/Value enabled to sync across devices, and you want to ensure the user is not prompted twice to review the same app from different devices. In this situation, you would set the `userDefaultsObject` to `[NSUbiquitousKeyValueStore defaultStore]` instead.
