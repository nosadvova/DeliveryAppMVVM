# Uncomment the next line to define a global platform for your project
# platform :ios

target 'DeliveryAppMVVM' do
  
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DeliveryAppMVVM
  
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseStorage'
pod 'FirebaseDatabase'

pod 'SDWebImage'

pod 'AEOTPTextField'

pod 'SideMenu'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
