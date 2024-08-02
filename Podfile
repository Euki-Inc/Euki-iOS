platform :ios, '12.0'
inhibit_all_warnings!
use_frameworks!

target 'Euki' do
  pod 'IQKeyboardManagerSwift'
  pod 'SwiftyJSON'
  pod 'UICollectionViewLeftAlignedLayout'
  pod 'MGSwipeTableCell'
  pod 'FAPaginationLayout'
  pod 'TTTAttributedLabel'
  pod 'RangeSeekSlider'
  pod 'MaterialShowcase'
  pod 'CryptoSwift'
  pod "UPCarouselFlowLayout"
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
            target.build_configurations.each do |config|
                config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            end
      target.build_configurations.each do |config|
       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
        end
    end
end
