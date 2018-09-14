//
//  UIAlertController+Rokid.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/10.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "UIAlertController+Rokid.h"

@implementation UIAlertController (Rokid)
+ (void)showAlertFrom:(UIViewController *)target Title:(NSString *)aTitle Message:(NSString *)aMsg handle:(void (^ __nullable)(UIAlertAction *action))handler cancel:(void (^ __nullable)(UIAlertAction *action))canceler {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:aTitle message:aMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler: handler]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler: canceler]];
    [target presentViewController:alert animated:true completion:nil];
}
@end
