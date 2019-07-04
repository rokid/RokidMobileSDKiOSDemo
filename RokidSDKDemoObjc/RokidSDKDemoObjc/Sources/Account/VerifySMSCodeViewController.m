//
//  VerifySMSCodeViewController.m
//  DemoOC
//
//  Created by BeyondChao on 2019/7/4.
//  Copyright © 2019 Shper. All rights reserved.
//

#import "VerifySMSCodeViewController.h"
#import "RegisterViewController.h"
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
    
    
}

- (IBAction)fetchScodeBtnClick:(UIButton *)sender {
    
    [RokidMobileSDK.account getScodeWithAreaCode:@"+86"
                                        phoneNum:self.phoneNumField.text
                                      completion:^(RKError * error) {
                                          if (error == nil) {
                                              //
                                          }
                                      }];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    
    [RokidMobileSDK.account checkScodeWithPhoneNum:self.phoneNumField.text
                                             scode:self.scodeField.text
                                        completion:^(RKError * error) {
                                            if (error == nil) {
                                                [self jumpRegisterVC];
                                            }
                                        }];
}

- (void)jumpRegisterVC {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController *registerVC = [sb instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerVC animated:YES];
}

// MARK: - Target Action

@end
