//
//  MBProgressHUD+Extensions.m
//  RokidMobileSDKDemoObjc
//
//  Created by BeyondChao on 2019/4/28.
//  Copyright © 2019 BeyondChao. All rights reserved.
//

#import "MBProgressHUD+Extensions.h"

@implementation MBProgressHUD (Extensions)

+ (MBProgressHUD *)showMessage:(NSString *)text to:(UIView *)toVIew afterDelay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toVIew animated:YES];
    hud.label.text = text;
    
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    
    if (delay >=0 ) {
        [hud hideAnimated:YES afterDelay:delay];
    }
    
    return hud;
}

@end
