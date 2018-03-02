//
//  IotRoomViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/28.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "IotRoomViewController.h"
@import WebKit;
@import RokidSDK;

@interface IotRoomViewController () <RKBridgeModuleAppDelegate>
@property(nonatomic, strong) WKWebView * webView;
@property(nonatomic, strong) RKWebBridge * rkWebBridge ;

@end

@implementation IotRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.navigationItem.title = self.title;
    
    self.rkWebBridge = [RKWebBridge injectWebBridgeTo:self.webView];
    [self.rkWebBridge setAppDelegateWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
