//
//  ChangePasswordViewController.m
//  DemoOC
//
//  Created by 李峰 on 2019/7/5.
//  Copyright © 2019 Shper. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "MBProgressHUD+Extensions.h"
@import RokidSDK;

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *oldPswTitle;
@property (weak, nonatomic) IBOutlet UITextField *oldPswTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@property (weak, nonatomic) IBOutlet UITextField *confirmTextfield;


@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubview];
}

- (void)setupSubview {
    self.title = self.pwdOperate == Reset ? @"重置密码" : @"修改密码";
    self.oldPswTitle.hidden = self.pwdOperate == Reset;
    self.oldPswTextfiled.hidden = self.pwdOperate == Reset;
    self.oldPswTextfiled.delegate = self;
    self.passwordTextfield.delegate = self;
    self.confirmTextfield.delegate = self;
}

- (IBAction)confirmBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    if (![self.passwordTextfield.text isEqualToString:self.confirmTextfield.text]) {
        NSLog(@"new password can not confirm to pass");
        return;
    }
    
    if (Reset == self.pwdOperate) {
        // 重置密码
        [RokidMobileSDK.account resetPasswdWithPhoneNum:self.accoutId
                                                password:self.confirmTextfield.text
                                                  scode:self.scode
                                              completion:^(RKError * _Nullable error) {
                                                  if (error) {
                                                      // toast error message
                                                      NSLog(@"error = %@", error.message);
                                                      [MBProgressHUD showMessage:error.message to:self.view afterDelay:1.8];
                                                  }else {
                                                      [MBProgressHUD showMessage:@"密码重置成功" to:self.view afterDelay:1.8];
                                                  }
                                              }];
    } else if (Change == self.pwdOperate) {
        // 修改密码
        [RokidMobileSDK.account changePasswdWithOldPassword:self.oldPswTextfiled.text
                                                newPassword:self.passwordTextfield.text
                                               completion:^(RKError * _Nullable error) {
                                                   if (error) {
                                                       // toast error message
                                                       NSLog(@"error = %@", error.message);
                                                       [MBProgressHUD showMessage:error.message to:self.view afterDelay:1.8];
                                                   }else {
                                                       [MBProgressHUD showMessage:@"密码修改成功" to:self.view afterDelay:1.8];
                                                   }
                                               }];
    }
}

@end
