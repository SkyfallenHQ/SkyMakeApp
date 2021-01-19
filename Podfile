# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

load 'remove_ios_only_frameworks.rb'

target 'SkyMake App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SkyMake App
  pod 'JitsiMeetSDK'
end

def catalyst_unsupported_pods
  ["JitsiMeetSDK"]
end

post_install do |installer|   
  installer.configure_support_catalyst
end
