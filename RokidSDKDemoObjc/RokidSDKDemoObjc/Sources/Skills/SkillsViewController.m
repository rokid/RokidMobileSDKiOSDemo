//
//  SkillsViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/7.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "SkillsViewController.h"
#import "UIAlertController+Rokid.h"
#import "IotViewController.h"
#import "IotRoomViewController.h"
#import "WebviewViewController.h"

@import RokidSDK;

@interface SkillsViewController ()
@property(nonatomic, strong) NSArray * category;
@property(nonatomic, strong) NSDictionary * itemsAll;
@property (strong, nonatomic)  RKDevice * device;
@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
    
    NSArray * alarmItems = @[@"获取闹钟列表", @"新建闹钟", @"删除闹钟", @"更新闹钟"];
    NSArray * remindItems = @[@"获取提醒列表", @"删除提醒"];
    NSArray * iotItems = @[@"智能家居web", @"Test.html", @"有滚动区域的web页"];
    
    self.itemsAll = @{@"1闹钟" : alarmItems, @"2提醒": remindItems,@"3智能家居": iotItems};
    
    self.category = self.itemsAll.allKeys;
    
  
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SkillTableViewCell"];
    self.device = [RokidMobileSDK.device getCurrentDevice];
    if (!self.device){
        [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"当前没有设备，请前往'设备'中 设置" handle:^(UIAlertAction *action) {
            
        } cancel:^(UIAlertAction *action) {
            
        }];
        return;
    }
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.device = [RokidMobileSDK.device getCurrentDevice];
//    if (!self.device){
//        [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"当前没有设备，请前往'设备'中 设置" handle:^(UIAlertAction *action) {
//
//        } cancel:^(UIAlertAction *action) {
//
//        }];
//        return;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.category.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return   [((NSArray *)[self.itemsAll valueForKey:@"1闹钟"]) count];
            break;
        case 1:
            return   [((NSArray *)[self.itemsAll valueForKey:@"2提醒"]) count];
            break;
        case 2:
            return   [((NSArray *)[self.itemsAll valueForKey:@"3智能家居"]) count];
            break;
        default:
            return 1;
            break;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return   (NSString *)[self.itemsAll.allKeys objectAtIndex:section];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString  * title = @"";
    
    switch (indexPath.section) {
        case 0:{
            title = [((NSArray *)[self.itemsAll valueForKey:@"1闹钟"]) objectAtIndex:indexPath.row];
            break;
        }
        case 1:{
           title = [((NSArray *)[self.itemsAll valueForKey:@"2提醒"]) objectAtIndex:indexPath.row];
            break;
        }
        case 2:{
            title = [((NSArray *)[self.itemsAll valueForKey:@"3智能家居"]) objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SkillTableViewCell"];
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor blueColor];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [RokidMobileSDK.skill.alarm getListWithDeviceId:self.device.id  completion:^(RKError * error   , NSArray<RKAlarm *> * alarmArr) {
                        __block NSString * ret = @"";
                        if (error){
                            NSLog(@"%ld，%@",(long)error.code, error.message);//Get alarms timeout
                        }else {
                            if ([alarmArr count] == 0){
                                [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"alarm not created" handle:^(UIAlertAction *action) {
                                    
                                } cancel:^(UIAlertAction *action) {
                                    
                                }];
                                return;
                            }
                            [alarmArr enumerateObjectsUsingBlock:^(RKAlarm * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                RKAlarm * alarm = (RKAlarm *)obj;
                                NSString * info = [NSString stringWithFormat:
                                                   @"year:%ld; month:%ld; day:%ld; hour:%ld; minute:%ld; date:%@; ext:%@",
                                                   alarm.year,
                                                   alarm.month,
                                                   alarm.day,
                                                   alarm.hour,
                                                   alarm.minute,
                                                   alarm.date,
                                                   alarm.ext];
                                ret = [NSString stringWithFormat: @"%@ \n %@",ret ,info];
                            }];
                        }
                        
                        self.textview.text =  ret;
                    }];
                }
                break;
                case 1:{
                    
                    NSLog(@"RKAlarm 需要 先get ");
                    return;
                    
                    RKAlarm * alarm = [RKAlarm init];
                    BOOL bRet = [RokidMobileSDK.skill.alarm createWithDeviceId:self.device.id alarm: alarm];
                    if (bRet){
                        //create success
                    }else {
                        //create failed
                    }
                }
                break;
                case 2:{
                    //创建一个闹钟，选择一个闹钟，再删除
                    RKAlarm * alarm;
                    [RokidMobileSDK.skill.alarm deleteWithDeviceId:self.device.id alarm:alarm];
                }
                break;
                case 3:{
                     //创建一个闹钟，选择一个闹钟，再更新
                    RKAlarm * alarm;
                    RKAlarm * alarmNew;
                    [RokidMobileSDK.skill.alarm updateWithDeviceId:self.device.id alarm:alarm to:alarmNew];
                }
                break;
                default:
                break;
            }
        }
        break;
            
        case 1:{
            
            switch (indexPath.row) {
                case 0:{
                    [RokidMobileSDK.skill.remind getListWithDeviceId:self.device.id completion:^(RKError * error, NSArray<RKRemind *> * remindArr){
                        __block NSString * ret = @"";
                        if (error){
                        }else {
                            if ([remindArr count] == 0){
                                [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"alarm not created" handle:^(UIAlertAction *action) {
                                    
                                } cancel:^(UIAlertAction *action) {
                                    
                                }];
                                return;
                            }
                            [remindArr enumerateObjectsUsingBlock:^(RKRemind * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                RKRemind * remind = (RKRemind *)obj;
                                NSString * info = [NSString stringWithFormat:
                                                   @"year:%ld; month:%ld; day:%ld; hour:%ld; minute:%ld; date:%@; content:%@",
                                                   remind.year,
                                                   remind.month,
                                                   remind.day,
                                                   remind.hour,
                                                   remind.minute,
                                                   remind.date,
                                                   remind.content];
                                
                                ret = [NSString stringWithFormat: @"%@ \n %@",ret ,info];
                            }];
                        }
                        
                        self.textview.text =  ret;
                    }];
                    break;
                }
                case  1:{
                    //创建一个提醒，选择一个提醒，再删除
                    RKRemind * reminder;
                    [RokidMobileSDK.skill.remind deleteWithDeviceId:self.device.id remind:reminder];
                    break;
                }
                default:
                    break;
            }
        }
        break;
        case 2:{
            NSLog(@"---> ");
            switch (indexPath.row) {
                case 0:{
                    UIStoryboard * main =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    IotViewController * target = [main instantiateViewControllerWithIdentifier: NSStringFromClass([IotViewController class])];
                    [self.navigationController pushViewController:target animated:true];
                    break;
                }
                case 1:{
                    NSURL *URL = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"html"];
                    WebviewViewController *vc = [[WebviewViewController alloc] init];
                    vc.webURL = URL;
                    [self.navigationController pushViewController:vc animated:true];
                    break;
                }
                case 2:{
                    NSURL *URL = [NSURL URLWithString:@"https://m.ximalaya.com"];
                    WebviewViewController *vc = [[WebviewViewController alloc] init];
                    vc.webURL = URL;
                    [self.navigationController pushViewController:vc animated:true];
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
          }
        default:
            break;
    }
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
