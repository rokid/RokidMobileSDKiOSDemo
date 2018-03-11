//
//  DeviceListViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2017/12/7.
//  Copyright © 2017年 Rokid. All rights reserved.
//

#import "DeviceListViewController.h"
#import "MainViewController.h"
#import "DeviceInfoViewController.h"
@import RokidSDK;

@interface DeviceListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray<RKDevice *> *deviceList;

@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.deviceListView.dataSource = self;
    self.deviceListView.delegate = self;
    
    /*
     获取设备列表
     */
    [RokidMobileSDK.device queryDeviceListWithCompletion:^(RKError * error, NSArray<RKDevice *> * device_list) {
        self.deviceList = device_list;
        NSLog(@"device_list = %@", device_list);
        [self.deviceListView reloadData];
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setCurrentDevice:(id)sender {
    //NSLog(@"sender = %@", [[sender superview] superview] );
    long row = [[sender superview] superview].tag;
    [RokidMobileSDK.device setCurrentDeviceWithDevice: self.deviceList[row]];
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
    
    UITableViewCell *cell = [self.deviceListView dequeueReusableCellWithIdentifier:@"device"];
    RKDevice *device = self.deviceList[indexPath.row];
    
    if (cell != nil && device != nil) {
        cell.textLabel.text = device.nick;
    }
    cell.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard * main =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DeviceInfoViewController * target = [main instantiateViewControllerWithIdentifier: NSStringFromClass([DeviceInfoViewController class])];
    target.device = self.deviceList[indexPath.row];
    
    [self.navigationController pushViewController:target animated:true];
    

    RKDevice *device = self.deviceList[indexPath.row];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSLog(@"%@", device.basicInfo);

    /*
     设置为 current
     */
    [RokidMobileSDK.device setCurrentDeviceWithDevice:device];
    
    /*
     获取设备的版本升级信息
     */
    [RokidMobileSDK.device getVersionWithDeviceId:device.id completion:^(NSError * error, SDKDeviceVersionInfo * versioninfo) {
        NSLog(@"current version = %@, new version = %@", versioninfo.currentVersion, versioninfo.version);
    }];

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
