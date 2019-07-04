//
//  RegisterViewController.m
//  DemoOC
//
//  Created by BeyondChao on 2019/7/4.
//  Copyright © 2019 Shper. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD+Extensions.h"

@import RokidSDK;

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (copy, nonatomic) NSString *phoneNum;
@property (copy, nonatomic) NSString *scode;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"注册";
}

+ (RegisterViewController *)newRegisterVcWith:(NSString *)phoneNum scode:(NSString *)scode {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController *registerVC = [sb instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    registerVC.phoneNum = phoneNum;
    registerVC.scode = scode;
    return registerVC;
}

#pragma - Target Action

- (IBAction)pwdFieldVlaueChanged:(UITextField *)sender {
    [self updateUI];
}

- (IBAction)comfirmPwdValueChanged:(UITextField *)sender {
    [self updateUI];
}

- (IBAction)registerAccount:(UIButton *)sender {
    
    if (![self.passwordField.text isEqualToString:self.confirmPwdField.text]) {
        NSLog(@"error: 两次输入内容不一样！");
        [MBProgressHUD showMessage:@"两次输入内容不一样！" to:self.view afterDelay:1.5];
        return;
    }
    
    [RokidMobileSDK.account registerWithPhoneNum:self.phoneNum
                                        password:self.passwordField.text
                                           scode:self.scode
                                        areaCode:@"+86"
                                      completion:^(RKError * error) {
                                          
                                          if (error == nil) {
                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                              NSLog(@"succeed: 注册成功，请登录");
                                              [MBProgressHUD showMessage:@"注册成功，请登录!" to:self.view afterDelay:1.8];

                                          } else {
                                              // toast error message
                                              NSLog(@"error = %@", error.message);
                                              [MBProgressHUD showMessage:error.message to:self.view afterDelay:1.8];
                                          }
                                      }];
}

- (void)updateUI {
    self.registerButton.enabled = self.passwordField.text.length > 0 && self.confirmPwdField.text.length > 0;
}

@end
