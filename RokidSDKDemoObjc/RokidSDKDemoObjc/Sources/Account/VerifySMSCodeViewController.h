//
//  VerifySMSCodeViewController.h
//  DemoOC
//
//  Created by BeyondChao on 2019/7/4.
//  Copyright © 2019 Shper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 两个地方需要请求验证码，注册，重置密码
typedef NS_ENUM(NSInteger, RequestSCodeForType) {
    RegisterFlow,     // 注册
    ResetPassword,    // 重置密码
};

@interface VerifySMSCodeViewController : UIViewController

@property (nonatomic, assign) RequestSCodeForType requestSCodeFor;

@end

NS_ASSUME_NONNULL_END
