//
//  SendWiFiAccountViewController.m
//  RokidSDKDemoObjc
//
//  Created by BeyondChao on 2018/9/3.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "SendWiFiAccountViewController.h"

@interface SendWiFiAccountViewController () <SDKBinderObserver>

@property (weak, nonatomic) IBOutlet UITextField *wifiNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *wifiPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextView *stateTextView;
@property (weak, nonatomic) IBOutlet UIButton *getWifiList;

@property (copy, nonatomic) NSString *progressContent;

@end

@implementation SendWiFiAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RokidMobileSDK.binder addObserver:self];
    
    self.navigationItem.title = self.currentDevice.name;
    self.wifiNameTextField.text = RKWiFi.current.ssid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendBtnClick:(UIButton *)sender {
    
    RKWiFi *wifi = [[RKWiFi alloc] initWithSsid:self.wifiNameTextField.text
                                          bssid:@"123456"];
    
    [RokidMobileSDK.binder sendWiFiWithDevice:self.currentDevice
                                         wifi:wifi
                                     password:@"123456"];
}

- (IBAction)getWifiListBtnClick:(UIButton *)sender {
    [RokidMobileSDK.binder getWifiListWithDevice:self.currentDevice];
}

// MARK: - SDKBinderObserver
-(void)onBLEDeviceWiFiListUpdatedWithDevice:(RKBLEDevice *)device response:(RKBLEResponse *)response {
    NSArray<RKWiFi *> *list = response.wifiList;
}

- (void)onBLEDeviceBindStateUpdatedWithDevice:(RKBLEDevice *)device response:(RKBLEResponse *)response {
    
    switch (response.sCode.intValue) {
        case 10:
            self.progressContent = [NSString stringWithFormat:@"%@\n连接中...\n", self.progressContent];
            break;
        case 11:
            self.progressContent = [NSString stringWithFormat:@"%@\n连接成功...\n", self.progressContent];
            break;
        case -11:
            self.progressContent = [NSString stringWithFormat:@"%@\n连接失败...\n", self.progressContent];
            break;
        case 100:
            self.progressContent = [NSString stringWithFormat:@"%@\n登录中...\n", self.progressContent];
            break;
        case 101:
            self.progressContent = [NSString stringWithFormat:@"%@\n登录成功...\n", self.progressContent];
            break;
        case 200:
            self.progressContent = [NSString stringWithFormat:@"%@\n绑定中...\n", self.progressContent];
            break;
        case 201:
            self.progressContent = [NSString stringWithFormat:@"%@\n绑定成功...\n", self.progressContent];
            [NSObject performSelector:@selector(bindSuccessHandle) withObject:nil afterDelay:0.8];
            break;
        default:
            break;
    }

    self.stateTextView.text = self.progressContent;
}

- (void)bindSuccessHandle {
    [self performSegueWithIdentifier:@"BinderCompleteViewController" sender:nil];
}

@end
