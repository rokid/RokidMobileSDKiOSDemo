//
//  BinderViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2017/12/7.
//  Copyright © 2017年 Rokid. All rights reserved.
//

#import "BinderViewController.h"
#import "MainViewController.h"
#import "SendWiFiAccountViewController.h"

@import RokidSDK;

@interface BinderViewController ()<UITableViewDataSource, UITableViewDelegate, SDKBinderObserver>

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
    [RokidMobileSDK.binder enableBLE];
    [RokidMobileSDK.binder addObserver:self];
}
    
- (void)dealloc {
    [RokidMobileSDK.binder removeObserver:self];
}

- (void)scan {
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
    self.deviceList = nil;
}

// MARK: - SDKBinderObserver

- (void)onBLEEnabled:(BOOL)isEnable {
    // 确定蓝牙已经打开
    [RokidMobileSDK.binder startScanWithBlePrefix:@""];

}

- (void)onBLEDeviceListChangedWithList:(NSArray<RKBLEDevice *> *)list {
    self.loadingView.hidden = YES;
    [self.loadingView stopAnimating];
    self.deviceList = list;
    [self.bleList reloadData];
}

/*
 扫描蓝牙设备，根据前缀过滤设备
 */
- (void)onBLEDeviceConnectedWithDevice:(RKBLEDevice *)device {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SendWiFiAccountViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SendWiFiAccountViewController"];
    vc.currentDevice = device;
    [self.navigationController pushViewController:vc animated:true];

}

// MARK: - UITableViewDataSource, UITableViewDelegate

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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (self.deviceList != nil) {
        RKBLEDevice *device = self.deviceList[indexPath.row];
        if (device != nil) {
            [RokidMobileSDK.binder connectWithDevice:device];
            [RokidMobileSDK.binder stopScan];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
