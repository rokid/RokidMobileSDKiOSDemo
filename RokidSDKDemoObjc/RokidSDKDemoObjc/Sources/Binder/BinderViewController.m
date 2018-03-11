//
//  BinderViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2017/12/7.
//  Copyright © 2017年 Rokid. All rights reserved.
//

#import "BinderViewController.h"
#import "MainViewController.h"
@import RokidSDK;

@interface BinderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray<RKBLEDevice *> *deviceList;

@end

@implementation BinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.deviceList = [NSArray<RKBLEDevice *> array];
    
    self.loadingView.hidden = YES;
    [self.loadingView stopAnimating];
    
    self.bleList.dataSource = self;
    self.bleList.delegate = self;
    
    [self.scanButton addTarget:nil action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    [RokidMobileSDK.binder onBLEStatusChangeWithStatusChange:^(CBCentralManagerState state) {
        if (state == CBManagerStatePoweredOn) {
            [self scan];
        }
    }];
}

- (void)onClick {
    CBCentralManagerState state = [RokidMobileSDK.binder getBLEStatus];
    if (state != CBManagerStatePoweredOn) {
        NSLog(@"ble not poweron: %d", state);
    } else {
        [self scan];
    }
}

- (void)scan {
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
    self.deviceList = nil;
    
    /*
     扫描蓝牙设备，根据前缀过滤设备
     */
    [RokidMobileSDK.binder startBLEScanWithType:@"Rokid-Pebble-" onDeviceChange:^(NSArray<RKBLEDevice *> * devices) {
        self.loadingView.hidden = YES;
        [self.loadingView stopAnimating];
        self.deviceList = devices;
        [self.bleList reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.deviceList == nil) {
        return 0;
    }
    return self.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.deviceList == nil) {
        return nil;
    }
    
    UITableViewCell *cell = [self.bleList dequeueReusableCellWithIdentifier:@"device"];
    RKBLEDevice *device = self.deviceList[indexPath.row];
    
    if (cell != nil && device != nil) {
        cell.textLabel.text = device.name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.deviceList != nil) {
        RKBLEDevice *device = self.deviceList[indexPath.row];
        if (device != nil) {
            [RokidMobileSDK.binder connectBLEDevice:device complete:^(BOOL result, NSError * error) {
                
                // 需登录后才可以使用，因为配网和绑定是捆绑操作
                [RokidMobileSDK.binder sendBLEBindWifiWithDevice:device ssid:@"xxx" password:@"xxx" bssid:@"xxx" completion:^(RKError * error) {
                    if (error) {
                        NSLog(@"RokidMobileSDK.binder sendBLEBinderData error = %@", error);
                    } else {
                        NSLog(@"RokidMobileSDK.binder sendBLEBinderData OK");
                    }
                }];
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
