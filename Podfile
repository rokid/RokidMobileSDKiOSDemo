
platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

workspace 'RokidSDKDemo.xcworkspace'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'

target 'RokidSDKDemoSwift' do
  project 'RokidSDKDemoSwift/RokidSDKDemoSwift.xcodeproj'

    pod 'Alamofire', '4.7.3'
    pod 'ProtocolBuffers-Swift', '4.0.0'
    pod 'MQTTClient','0.14.0'

    pod 'ReachabilitySwift', '4.1.0'
    pod 'SQLite.swift', '~> 0.11.4'

end

target 'RokidSDKDemoObjc' do
  project 'RokidSDKDemoObjc/RokidSDKDemoObjc.xcodeproj'

    # sqlite
    pod 'SQLite.swift', '~> 0.11.4'
    # network
    pod 'Alamofire', '4.7.3'
    # MQTT
    pod 'MQTTClient','0.14.0'
    pod 'ProtocolBuffers-Swift', '4.0.0'
    pod 'ReachabilitySwift', '4.1.0'
    pod 'MBProgressHUD', '~> 1.1.0'
    pod 'MJRefresh'

end
