//
//  ChangePasswordViewController.h
//  DemoOC
//
//  Created by 李峰 on 2019/7/5.
//  Copyright © 2019 Shper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordViewController : UIViewController

@property (nonatomic, assign) NSInteger clickFrom; // 1 重置密码   2 修改密码

@property (nonatomic, copy) NSString *scode; // 校验码

@property (nonatomic, copy) NSString *accoutId; // 手机号

@end

NS_ASSUME_NONNULL_END
