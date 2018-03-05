//
//  IotViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/28.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "IotViewController.h"
#import "IotRoomViewController.h"
#import "IOTWKWebView.h"

@import WebKit;

@interface IotViewController ()
@property(nonatomic, strong) RKWebBridge * rkWebBridge ;
@property(nonatomic, strong) IOTWKWebView * webView;
@end

#define  dev_url    @"https://s.rokidcdn.com/homebase/himalaya/dev/index.html#/homes/index"
#define  pre_url    @"https://s.rokidcdn.com/homebase/himalaya/pre/index.html#/homes/index"

@implementation IotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView =  [[IOTWKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.webView];

    NSString * strUrl = RokidMobileSDK.shared.debug ? dev_url : pre_url;
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

    self.rkWebBridge = [RKWebBridge injectWebBridgeTo:self.webView];
    [self.rkWebBridge setAppDelegateWithDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)close{
    
}

- (void)openWithTitle:(NSString * _Nonnull)title urlStr:(NSString * _Nonnull)urlStr{
    
}

- (void)openNewWebViewWithTitle:(NSString * _Nonnull)title urlStr:(NSString * _Nonnull)urlStr{
    IotRoomViewController * target = [[IotRoomViewController alloc] init];
    [target setTitle:title];
    [target setUrlStr:urlStr];
    [self.navigationController pushViewController:target animated:true];
}

- (void)openExternalWithUrlStr:(NSString * _Nonnull)urlStr{
    
}


@end
