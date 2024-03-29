//
//  VerifySMSCodeViewController.m
//  DemoOC
//
//  Created by BeyondChao on 2019/7/4.
//  Copyright © 2019 Shper. All rights reserved.
//

#import "VerifySMSCodeViewController.h"
#import "RegisterViewController.h"
#import "MBProgressHUD+Extensions.h"
#import "ChangePasswordViewController.h"
@import RokidSDK;

@interface VerifySMSCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *scodeField;

@property (weak, nonatomic) IBOutlet UIButton *fetchScodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation VerifySMSCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"验证码";
}

#pragma - Target Action

- (IBAction)fetchScodeBtnClick:(UIButton *)sender {
    
    [RokidMobileSDK.account getScodeWithAreaCode:@"+86"
                                        phoneNum:self.phoneNumField.text
                                      completion:^(RKError * error) {
                                          if (error == nil) {
                                              //
                                          } else {
                                              // toast error message
                                              NSLog(@"error = %@", error.message);
                                              [MBProgressHUD showMessage:error.message to:self.view afterDelay:1.8];
                                          }
                                      }];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    
    [RokidMobileSDK.account checkScodeWithPhoneNum:self.phoneNumField.text
                                             scode:self.scodeField.text
                                        completion:^(RKError * error) {
                                            if (error == nil) {
                                                if (ResetPassword == self.requestSCodeFor) {
                                                    // 重置密码
                                                    [self jumpToChangePswVC];
                                                    
                                                } else if (RegisterFlow == self.requestSCodeFor) {
                                                    // 注册
                                                    [self jumpRegisterVC];
                                                }
                                            } else {
                                                // toast error message
                                                NSLog(@"error = %@", error.message);
                                                [MBProgressHUD showMessage:error.message to:self.view afterDelay:1.8];
                                            }
                                        }];
    
    
}

- (void)jumpToChangePswVC {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangePasswordViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    vc.scode = self.scodeField.text;
    vc.accoutId = self.phoneNumField.text;
    vc.pwdOperate = Change;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)phoneFieldValueChanged:(UITextField *)sender {
    [self updateFetchScodeButton];
}

- (IBAction)scodeFieldValueChanged:(UITextField *)sender {
    [self updateNextButton];
}

- (void)updateFetchScodeButton {
    self.fetchScodeButton.enabled = self.phoneNumField.text.length > 10;
}

- (void)updateNextButton {
    self.nextButton.enabled = self.phoneNumField.text.length > 10 && self.scodeField.text.length > 0;
}


- (void)jumpRegisterVC {
    RegisterViewController *registerVC = [RegisterViewController newRegisterVcWith:self.phoneNumField.text
                                                                             scode:self.scodeField.text];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
