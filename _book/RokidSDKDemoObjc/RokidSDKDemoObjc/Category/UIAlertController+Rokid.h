//
//  UIAlertController+Rokid.h
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/10.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Rokid)
+ (void)showAlertFrom:(UIViewController *)target Title:(NSString *)aTitle Message:(NSString *)aMsg handle:(void (^ __nullable)(UIAlertAction *action))handler cancel:(void (^ __nullable)(UIAlertAction *action))canceler;
@end
