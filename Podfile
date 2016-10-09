#s line to define a global platform for your project
platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'PulseMD' do
pod 'Parse'
pod 'FloatRatingView', '~> 2.0.0'
pod 'SwiftSpinner'
pod 'ReachabilitySwift', '~> 3'
pod 'IQKeyboardManagerSwift'
pod 'MokiManageSDK', :git => 'https://github.com/MokiMobility/MokiManageSDK.git', :tag => '1.2.11'
pod 'FXBlurView', '~> 1.5.3'
pod 'CocoaLumberjack','~> 2.0'


end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['ENABLE_BITCODE'] = "NO"
        end
    end
end
target 'PulseMDTests' do

end

target 'PulseMDUITests' do

end


