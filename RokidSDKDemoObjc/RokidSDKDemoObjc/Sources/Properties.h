//
//  Properties.h
//  RokidSDKDemoObjc
//
//  Created by Yock on 2018/1/5.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Properties : NSObject

+ (Properties *)shared;

@property (readonly, nonatomic) NSString *appKey;

@property (readonly, nonatomic) NSString *appSecret;

@property (readonly, nonatomic) NSString *accessKey;

@property (readonly, nonatomic) NSString *username;

@property (readonly, nonatomic) NSString *password;

@end
