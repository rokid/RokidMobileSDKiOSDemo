//
//  ViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2017/11/29.
//  Copyright © 2017年 Rokid. All rights reserved.
//

#import "MainViewController.h"
#import "Properties.h"

@interface MainViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];

    [self.loginButton addTarget:nil action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton addTarget:nil action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     * 等 SDK init 完成后才能进行 UI 操作, 简化 Demo 的逻辑
     */
    self.view.userInteractionEnabled = NO;

    // SDK init
    [RokidMobileSDK.shared initSDKWithAppKey:Properties.shared.appKey
                                   appSecret:Properties.shared.appSecret
                                   accessKey:Properties.shared.accessKey
                                  completion:^(RKError * error) {
        NSLog(@"[SDK init] result = %@", error);
        
        // SDK init 完成
        if (!error) {
            self.view.userInteractionEnabled = YES;
            
            [self addNotificationObserver];
        }

    }];

}

- (void)login
{
    // 使用若琪账号登录，暂时不确定如何开放登录的接口
    [RokidMobileSDK.account tempLoginWithName:@"13805786604"
                                     password:@"123456"
                                     complete:^(NSString * uid, NSString * token, RKError * error) {
        if (!error) {
            NSLog(@"[Login] OK" );
        } else {
            NSError *newError = [NSError errorWithDomain:@"RKError"
                                                    code:error.code
                                                userInfo:@{
                                                           @"Message": error.message? :@""
                                                           }];
            NSLog(@"[Login] Error %@", newError);
        }
    }];
}

- (void)logout
{
    [RokidMobileSDK.account logout];
}

- (IBAction)getCardList:(id)sender {
    /*
     pageSize 不能超过 100，这个会报错
     */
    if (/* DISABLES CODE */ (false)) {
        [RokidMobileSDK.home getCardListWithMaxDbId:0 pageSize:101 completion:^(RKError * error, NSArray<RKCard *> * cardArray) {
            for (RKCard *card in cardArray) {
                NSLog(@"msg = %@", card.msgText);
            }
        }];
    }
    
    /*
     指定 pageSize = 25
     */
    if (/* DISABLES CODE */ (false)) {
        [RokidMobileSDK.home getCardListWithMaxDbId:0 pageSize:25 completion:^(RKError * error, NSArray<RKCard *> * cardArray) {
            for (RKCard *card in cardArray) {
                NSLog(@"msg = %@", card.msgText);
            }
        }];
    }
    
    /*
     默认 pageSize = 20
     */
    if (true) {
        [RokidMobileSDK.home getCardListWithMaxDbId:0 completion:^(RKError * error, NSArray<RKCard *> * cardArray) {
            for (RKCard *card in cardArray) {
                NSLog(@"msg = %@", card.msgText);
            }
        }];
    }
}



- (IBAction)sendASR:(id)sender {
    RKDevice *device = [RokidMobileSDK.device getCurrentDevice];
    if (device != nil) {
        if (!device.alive) {
            NSLog(@"设备不在线");
        } else {
            [RokidMobileSDK.home sendAsrWithAsr:@"你好若琪" to:device];
        }
    }
}

// 注册事件监听，监听 SDK 的 各种事件
- (void)addNotificationObserver {
    /*
        card manager 缓存的 cardlist 改变
        userinfo: {
            appended: card array,
            removed: card array,
        }
     */
    [NSNotificationCenter.rokidsdk addObserver:self selector:@selector(handleNotification:) name:RKNotificationName.CardReceived object:nil];
    
    /*
        device manager 的 current device 改变
        userinfo: {
            previousId: 之前的id
            id: 现在的id
        }
     */
    [NSNotificationCenter.rokidsdk addObserver:self selector:@selector(handleNotification:) name:RKNotificationName.CurrentDeviceUpdated object:nil];
    
    /*
        device manager 缓存的 device list 改变
        userinfo: {
            appended: device array,
            removed: device array,
        }
     */
    [NSNotificationCenter.rokidsdk addObserver:self selector:@selector(handleNotification:) name:RKNotificationName.DeviceListUpdated object:nil];
    
    /*
        device 在线状态改变
        userinfo: {
            alive: 0 / 1,
            id: device id,
        }
     */
    [NSNotificationCenter.rokidsdk addObserver:self selector:@selector(handleNotification:) name:RKNotificationName.DeviceStatusUpdated object:nil];
    
    /*
        设备音量改变
        object: device
        可以通过 device.alarmVolume 获取当前音量
     */
    [NSNotificationCenter.rokidsdk addObserver:self selector:@selector(handleNotification:) name:RKNotificationName.AlarmVolumeChanged object:nil];
    
    /*
        账号被登出 (单点登录)
     */
    [NSNotificationCenter.rokidsdk addObserver:self selector:@selector(handleNotification:) name:RKNotificationName.ShouldLogout object:nil];
}

- (void)handleNotification: (NSNotification *)notification {
    NSLog(@"[ViewContoller handleNotification] %@", notification);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

