//
//  DevicesViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/7.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "DevicesViewController.h"
#import "DeviceListViewController.h"
@import RokidSDK;

@interface DevicesViewController ()
@property(nonatomic, strong) NSMutableArray * itemsArray;
@property (strong, nonatomic) NSArray<RKDevice *> *deviceList;
@end

@implementation DevicesViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemsArray = [[NSMutableArray alloc] initWithObjects:
                       @"4.1 获取设备列表",
                       nil];

    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DeviceTableViewCell"];
    
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceTableViewCell"];
    cell.textLabel.text = [self.itemsArray objectAtIndex:indexPath.row];
    return  cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.itemsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UIStoryboard * main =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DeviceListViewController * target = [main instantiateViewControllerWithIdentifier: NSStringFromClass([DeviceListViewController class])];
            [self.navigationController pushViewController:target animated:true];
            break;
        }
        default:
            break;
    }
}



@end
