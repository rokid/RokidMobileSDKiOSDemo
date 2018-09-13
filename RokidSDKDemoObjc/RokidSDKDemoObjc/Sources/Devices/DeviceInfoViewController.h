//
//  DeviceInfoViewController.h
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/9.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import <UIKit/UIKit.h>
@import RokidSDK;

@interface DeviceInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  RKDevice * device ;
@end
