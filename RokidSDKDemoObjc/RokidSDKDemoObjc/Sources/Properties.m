//
//  Properties.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2018/1/5.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "Properties.h"

@interface Properties ()

@property (strong, nonatomic) NSDictionary *plist;

@end

@implementation Properties

static Properties *sharedProperties;

+ (Properties *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProperties = [[Properties alloc] init];
    });
    return sharedProperties;
}


- (id)init {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    self.plist = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return self;
}

//@property (readonly, nonatomic) NSString *appKey;
- (NSString *)appKey {
    return self.plist[@"appKey"];
}

//@property (readonly, nonatomic) NSString *appSecret;
- (NSString *)appSecret {
    return self.plist[@"appSecret"];
}

//@property (readonly, nonatomic) NSString *accessKey;
- (NSString *)accessKey {
    return self.plist[@"accessKey"];
}

@end
