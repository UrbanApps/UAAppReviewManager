Pod::Spec.new do |s|
  s.name                  = "UAAppReviewManager"
  s.version               = "0.1.1"
  s.summary               = "UAAppReviewManager is AppIRater all grown up. For iOS and OS X."
  s.description           = <<-DESC
                          UAAppReviewManager is AppIRater all grown up. It allows you to use it on iOS and Mac targets, allows affiliate links and it rewritten from the ground up for the modern app.
                          DESC
  s.homepage              = "https://github.com/UrbanApps/UAAppReviewManager"
  s.author                = { "Matt Coneybeare" => "coneybeare@urbanapps.com" }
  s.license               = 'MIT'
  s.ios.deployment_target = '5.1'
  s.osx.deployment_target = '10.7'
  s.requires_arc          = true
  s.frameworks            = 'CFNetwork', 'SystemConfiguration'
  s.weak_frameworks       = 'StoreKit'
  s.source                = { :git => "https://github.com/UrbanApps/UAAppReviewManager.git", :tag => s.version.to_s }
  s.source_files          = "UAAppReviewManager.{h,m}"
  s.ios.resource_bundles  = { 'UAAppReviewManager-iOS' => ['Localization/*.lproj'] }
  s.osx.resource_bundles  = { 'UAAppReviewManager-OSX' => ['Localization/*.lproj'] }
end
