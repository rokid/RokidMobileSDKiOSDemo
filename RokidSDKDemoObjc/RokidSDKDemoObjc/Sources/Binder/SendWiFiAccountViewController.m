//
//  SendWiFiAccountViewController.m
//  RokidSDKDemoObjc
//
//  Created by BeyondChao on 2018/9/3.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "SendWiFiAccountViewController.h"

@interface SendWiFiAccountViewController () <RKBindManagerObserver>

@property (weak, nonatomic) IBOutlet UITextField *wifiNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *wifiPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextView *stateTextView;

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
                                          bssid:@"rokidguys"];
    [RokidMobileSDK.binder sendWiFiWithDevice:self.currentDevice
                                         wifi:wifi
                                     password:@"rokidguys"];
}

// MARK: - RKBindManagerObserver

- (void)onBLEDeviceBindStateUpdatedWithDevice:(RKBLEDevice *)device response:(RKBLEResponse *)response {
    
    switch (response.bleConnectState) {
        case RKBLEConnectStateKWiFiConnceting:
            
            self.progressContent = [NSString stringWithFormat:@"%@\n连接中...\n", self.progressContent];
            
            break;
            
        case RKBLEConnectStateKWiFiConnceted:
            
            self.progressContent = [NSString stringWithFormat:@"%@\n连接成功...\n", self.progressContent];
            
            break;
            
        case RKBLEConnectStateKWiFiLoginFailure:
            
            self.progressContent = [NSString stringWithFormat:@"%@\n连接失败...\n", self.progressContent];
            
            break;
            
        case RKBLEConnectStateKWiFiLoging:
            
            self.progressContent = [NSString stringWithFormat:@"%@\n登录中...\n", self.progressContent];

            break;
            
        case RKBLEConnectStateKWiFiLoginSuccess:
            
            self.progressContent = [NSString stringWithFormat:@"%@\n登录成功...\n", self.progressContent];

            break;
            
        case RKBLEConnectStateKWiFiBinding:
            
            self.progressContent = [NSString stringWithFormat:@"%@\n绑定中...\n", self.progressContent];

            break;
            
        case RKBLEConnectStateKWiFiBindSuccess:
            
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
