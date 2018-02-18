//
//  HomeViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/18.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "HomeViewController.h"
#import "UIAlertController+Rokid.h"
@import RokidSDK;

@interface HomeViewController ()
@property (strong, nonatomic)  RKDevice * device;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.device = [RokidMobileSDK.device getCurrentDevice];
    if (!self.device){
        [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"当前没有设备，请设置" handle:^(UIAlertAction *action) {
            
        } cancel:^(UIAlertAction *action) {
            
        }];
        return;
    }
}


- (IBAction)clickASR:(id)sender {
    [RokidMobileSDK.home  sendAsrWithAsr: @"播放白龙马" to: self.device];
}
- (IBAction)clickTTS:(id)sender {
    //[RokidMobileSDK.home  sendTtsWithTts:@"我是若琪，有什么需要帮忙的?" to: self.device];
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
