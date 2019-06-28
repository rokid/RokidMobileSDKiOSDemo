
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

workspace 'RokidSDKDemo.xcworkspace'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'

def dependence_lib
    
    pod 'AliyunOSSiOS', '2.10.7'
    pod 'MBProgressHUD', '1.1.0'
    pod 'MJRefresh'
    
    pod 'ReachabilitySwift', '4.3.1'
    pod 'Alamofire', '4.8.2'
    pod 'RokidSDK', '~> 1.9.3'

end

target 'RokidSDKDemoSwift' do
  project 'RokidSDKDemoSwift/RokidSDKDemoSwift.xcodeproj'

  dependence_lib
  
end

target 'RokidSDKDemoObjc' do
  project 'RokidSDKDemoObjc/RokidSDKDemoObjc.xcodeproj'

  dependence_lib

end
