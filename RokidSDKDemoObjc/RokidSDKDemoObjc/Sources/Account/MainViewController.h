//
//  ViewController.h
//  RokidSDKDemoObjc
//
//  Created by Yock on 2017/11/29.
//  Copyright © 2017年 Rokid. All rights reserved.
//

#import <UIKit/UIKit.h>
@import RokidSDK;

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *telInput;

@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

