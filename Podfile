
platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

workspace 'RokidSDKDemo.xcworkspace'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'

def dependence_lib
    
    pod 'Alamofire', '4.7.3'
    pod 'AFNetworking', '2.6.3'
    pod 'AliyunOSSiOS', '2.10.7'
    pod 'MQTTClient','0.14.0'
    pod 'ReachabilitySwift'
    pod 'MBProgressHUD', '1.1.0'
    pod 'CocoaAsyncSocket', '7.6.0'
    pod 'MJRefresh'
    
end

target 'RokidSDKDemoSwift' do
  project 'RokidSDKDemoSwift/RokidSDKDemoSwift.xcodeproj'

  dependence_lib
  
end

target 'RokidSDKDemoObjc' do
  project 'RokidSDKDemoObjc/RokidSDKDemoObjc.xcodeproj'

  dependence_lib

end
