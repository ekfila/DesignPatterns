# Podfile

platform :ios, '13.0'

use_frameworks!

target 'DesignPatterns' do
    pod 'Bond'
    pod 'RealmSwift'
    pod 'SPAlert'
end

post_install do |installer|
     installer.pods_project.targets.each do |target|
           target.build_configurations.each do |config|
                 config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
           end
     end
end
