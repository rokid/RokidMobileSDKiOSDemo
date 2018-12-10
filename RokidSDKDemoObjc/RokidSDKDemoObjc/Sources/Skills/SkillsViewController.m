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
#import "SMContainerViewController.h"
#import "WebviewViewController.h"

@import RokidSDK;

@interface SkillsViewController ()
@property(nonatomic, strong) NSDictionary * itemsAll;
@property (strong, nonatomic)  RKDevice * device;
@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
    
    NSArray * alarmItems = @[@"获取闹钟列表", @"新建闹钟", @"删除闹钟", @"更新闹钟"];
    NSArray * remindItems = @[@"获取提醒列表", @"删除提醒"];
    NSArray * mediaItems = @[@"获取内容技能列表", @"获取技能Home信息", @"获取技能List信息", @"获取技能Detail信息", @"播放媒体", @"获取播放信息", @"上一首", @"下一首"];
    NSArray * iotItems = @[@"智能家居 H5"];
    NSArray * storeItems = @[@"技能商店 H5"];
    
    self.itemsAll = @{@"1闹钟" : alarmItems, @"2提醒" : remindItems, @"3媒体内容" : mediaItems, @"4智能家居" : iotItems, @"5技能商店" : storeItems};
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SkillTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.device = [RokidMobileSDK.device getCurrentDevice];
    if (!self.device){
        [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"当前没有设备，请前往'设备'中 设置" handle:^(UIAlertAction *action) {
            
        } cancel:^(UIAlertAction *action) {
            
        }];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.itemsAll.count;
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
            return   [((NSArray *)[self.itemsAll valueForKey:@"3媒体内容"]) count];
            break;
        case 3:
            return   [((NSArray *)[self.itemsAll valueForKey:@"4智能家居"]) count];
            break;
        case 4:
            return   [((NSArray *)[self.itemsAll valueForKey:@"5技能商店"]) count];
            break;
        default:
            return 1;
            break;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"1闹钟";
            break;
        case 1:
            return @"2提醒";
            break;
        case 2:
            return @"3媒体内容";
            break;
        case 3:
            return @"4智能家居";
            break;
        case 4:
            return @"5技能商店";
            break;
        default:
            return @"";
            break;
    }
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
            title = [((NSArray *)[self.itemsAll valueForKey:@"3媒体内容"]) objectAtIndex:indexPath.row];
            break;
        }
        case 3:{
            title = [((NSArray *)[self.itemsAll valueForKey:@"4智能家居"]) objectAtIndex:indexPath.row];
            break;
        }
        case 4:{
            title = [((NSArray *)[self.itemsAll valueForKey:@"5技能商店"]) objectAtIndex:indexPath.row];
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
                    [RokidMobileSDK.skill.alarm getListWithDeviceId:self.device.id  completion:^(RKError * error   , NSArray<SDKAlarm *> * alarmArr) {
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
                            [alarmArr enumerateObjectsUsingBlock:^(SDKAlarm * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                SDKAlarm * alarm = (SDKAlarm *)obj;
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
                    
                    SDKAlarm * alarm = [SDKAlarm init];
                    alarm.year = 2018;
                    [RokidMobileSDK.skill.alarm createWithDeviceId:self.device.id alarm:alarm completion:^(BOOL succeed) {
                        if (succeed){
                            //create success
                        }else {
                            //create failed
                        }
                    }];
                }
                    break;
                case 2:{
                    //创建一个闹钟，选择一个闹钟，再删除
                    SDKAlarm * alarm;
                    
                    [RokidMobileSDK.skill.alarm deleteWithDeviceId:self.device.id alarm:alarm completion:^(BOOL succeed) {
                        if (succeed){
                            //create success
                        }else {
                            //create failed
                        }
                    }];
                }
                    break;
                case 3:{
                    //创建一个闹钟，选择一个闹钟，再更新
                    SDKAlarm * alarm;
                    SDKAlarm * alarmNew;
                    [RokidMobileSDK.skill.alarm updateWithDeviceId:self.device.id alarm:alarm to:alarmNew completion:^(BOOL succeed) {
                        if (succeed){
                            //create success
                        }else {
                            //create failed
                        }
                    }];
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
                    [RokidMobileSDK.skill.remind getListWithDeviceId:self.device.id completion:^(RKError * error, NSArray<SDKRemind *> * remindArr){
                        __block NSString * ret = @"";
                        if (error){
                        }else {
                            if ([remindArr count] == 0){
                                [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"alarm not created" handle:^(UIAlertAction *action) {
                                    
                                } cancel:^(UIAlertAction *action) {
                                    
                                }];
                                return;
                            }
                            [remindArr enumerateObjectsUsingBlock:^(SDKRemind * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                SDKRemind * remind = (SDKRemind *)obj;
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
                    SDKRemind * reminder;
                    
                    [RokidMobileSDK.skill.remind deleteWithDeviceId:self.device.id remind:reminder completion:^(BOOL succeed) {
                        if (succeed){
                            //create success
                        }else {
                            //create failed
                        }
                    }];
                    break;
                }
                default:
                    break;
            }
        }
            break;
        case 2:{
            [self mediaAction:indexPath.row];
        }
            break;
        case 3:{
            NSLog(@"---> ");
            UIStoryboard * main =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            IotViewController * target = [main instantiateViewControllerWithIdentifier: NSStringFromClass([IotViewController class])];
            [self.navigationController pushViewController:target animated:true];
        }
            break;
        case 4: {
            NSLog(@"---> storev2");
            
            WebviewViewController * target = [[WebviewViewController alloc] init];
            [target setUrlStr: @"https://skill.rokid.com/storev2/#/?header=0&newview=1"];
            [self.navigationController pushViewController:target animated:true];
        }
            break;
        default:
            break;
    }
}

- (void)mediaAction:(long) index {
    switch (index) {
        case 0: {
            [RokidMobileSDK.media requestSkillListIntentWithCompletion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestSkillListIntent: %@", responseJson);
            }];
        }
            break;
        case 1: {
            [RokidMobileSDK.media requestHomeIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestHomeIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
        case 2: {
            [RokidMobileSDK.media requestListIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" groupId:@"16" startIndex:0 endIndex:5 extend:@"" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestListIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
        case 3: {
            [RokidMobileSDK.media requestDetailIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" groupId:@"269179" startIndex:0 endIndex:5 order:@"" extend:@"" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestDetailIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
        case 4: {
            [RokidMobileSDK.media requestPlayIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" id:@"326970" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestPlayIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
        case 5: {
            [RokidMobileSDK.media requestPlayInfoIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestPlayInfoIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
        case 6: {
            [RokidMobileSDK.media requestNextIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestNextIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
        case 7: {
            [RokidMobileSDK.media requestPreviousIntentWithSkillId:@"RC528E2DD8E745E195173D9F8BE48436" completion:^(RKError * error, NSString * responseJson) {
                NSLog(@"Rokid Mobile SDK Media - requestHomeIntentWithSkillId: %@", responseJson);
            }];
        }
            break;
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
