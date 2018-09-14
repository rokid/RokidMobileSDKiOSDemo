//
//  RKTabViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/19.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "RKTabViewController.h"
#import "UIAlertController+Rokid.h"

@interface RKTabViewController ()
@property(nonatomic,assign) BOOL isLogin;
@end

@implementation RKTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.isLogin = false;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginNotificationAction:)  name:@"loginNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)LoginNotificationAction:(NSNotification *)notification{
    
    NSLog(@"%@",notification.userInfo);
    if (notification.object){
        NSString * ret = notification.object;
        if ([ret isEqualToString:@"loginOK"]){
           self.isLogin = true;
        }
    }
}

#pragma mark - UITabBarControllerDelegate


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (self.isLogin){
        return  true;
    }else {
        [UIAlertController showAlertFrom:self Title: @"tip"  Message:@"请先登录，😝" handle:^(UIAlertAction *action) {
            
        } cancel:^(UIAlertAction *action) {
            
        }];
        return  false;
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
