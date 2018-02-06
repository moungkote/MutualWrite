# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'Mutualwrite' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'HexColors'
  pod 'Firebase/Auth'
  pod 'Bolts'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'FacebookLogin'
  pod 'WSTagsField', '~> 2.1'
  pod 'IQKeyboardManagerSwift', '~> 5.0'
  pod 'TTGTagCollectionView', '~> 1.8'
  pod 'RealmSwift', '~> 3.1'
  pod 'MXParallaxHeader', '~> 0.6'
  pod 'ESTabBarController-swift', '~> 2.5'
  pod 'RangeSeekSlider', '~> 1.7'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'WSTagsField'
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
    
    if target.name == 'RangeSeekSlider'
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end
end

end
