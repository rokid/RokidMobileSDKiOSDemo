//
//  MBProgressHUD+Extensions.h
//  RokidMobileSDKDemoObjc
//
//  Created by BeyondChao on 2019/4/28.
//  Copyright © 2019 BeyondChao. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Extensions)

+ (MBProgressHUD *)showMessage:(NSString *)text to:(UIView *)toVIew afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
