platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

target 'Euki' do
  pod 'IQKeyboardManagerSwift', '~> 5.0.8'
  pod 'SwiftyJSON', '~> 4.0.0'
  pod 'UICollectionViewLeftAlignedLayout', '~> 1.0.2'
  pod 'MGSwipeTableCell', '~> 1.6.8'
  pod 'FAPaginationLayout', '~> 0.0.4'
  pod 'TTTAttributedLabel'
  pod 'RangeSeekSlider'
  pod 'MaterialShowcase'
  pod 'CryptoSwift', '~> 1.5.1'
	pod "UPCarouselFlowLayout"
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
			target.build_configurations.each do |config|
				config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
			end
		end
	end
end
