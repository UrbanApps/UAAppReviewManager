# UAAppReviewManager Changelog

### 0.2.6
 - Appended App ID to default campaign code
 
### 0.2.5
 - Fixed missing rate button when remind button is hidden

### 0.2.4
 - Fixed the cancel button action.
 - Updated to a working iOS 7 direct link

### 0.2.3
 - Fixed the incorrect method calls resulting from the 0.2.2 button order change.

### 0.2.2
 - Rearranged order of buttons such that the Rate button is highlighted and at bottom rather than the cancel button.

### 0.2.1
 - Minor changes

### 0.2.0
 - UAAppReviewManager now listens to UIApplication and NSApplication lifecycle notifications. This means you no longer have to call `appLaunched:` or `appWillEnterForeground` and thus, those methods have been deprecated.

### 0.1.6
 - Added UAAppReviewManagerShouldPromptBlock methods and logic. This allows you to have total control and the last say in whether or not a rating prompt should be displayed. More info about these methods and blocks in the README.

### 0.1.5
 - Fixed some innocuous compiler warnings
 - Fixed a bug that may have prevented the Store Kit Controller from openeing when `opensInStoreKit` was set to YES

### 0.1.4
 - Allow compilation in Xcode 4
 - Remove LANGUAGE placeholder from iOS 7 template URL, allowing AppStore.app to decide
 - Added keyPrefix option for the defaults keys

### 0.1.3
 - Added the Changelog
 - Added the `UAAppReviewManagerDefaultsObject` protocol and `userDefaultsObject`. This allows you to set the object that UAAppReviewManager uses to save the usage data. Without customization, it defaults to `[NSUserDefaults standardUserDefaults]`. One of the areas it is useful is in Apps where you have the iCloud Key/Value enabled to sync across devices, and you want to ensure the user is not prompted twice to review the same app from different devices. In this situation, you would set the `userDefaultsObject` to `[NSUbiquitousKeyValueStore defaultStore]` instead.
