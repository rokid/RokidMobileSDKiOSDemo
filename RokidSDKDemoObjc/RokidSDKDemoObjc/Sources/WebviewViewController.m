//
//  WebviewViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2018/1/17.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "WebviewViewController.h"
#import <WebKit/WebKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
@import RokidSDK;

@interface WebviewViewController () <RKBridgeModuleViewDelegate, RKBridgeModuleAppDelegate, RKBridgeModulePhoneDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) RKWebBridge *webbridge;

@property (weak, nonatomic) MBProgressHUD *hud;

@end

@implementation WebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc] init];
    
    // 注入RKWebBridge
    self.webbridge = [RKWebBridge injectWebBridgeTo:self.webView];
    
    // 设置 RKBridgeModuleViewDelegate，用于实现 Native UI 的功能
    [self.webbridge setViewDelegateWithDelegate:self];
    
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    NSURL *url =[NSBundle.mainBundle URLForResource:@"test" withExtension:@"html"];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
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

// 显示 加载中UI组件
- (void)showLoadingWithMessage:(NSString * _Nonnull)message {
    if (self.hud != nil) {
        [self.hud hideAnimated:false];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = message;
    self.hud = hud;
}

// 用户手指按下
- (void)touchDown {
}

// 用户手指移动
- (void)touchMove {
}

// 用户手指抬起
- (void)touchUp {
}
    
// 关闭当前页面
- (void)close {
}

// 在当前的 webview ，打开Url
- (void)openWithTitle:(NSString * _Nonnull)title urlStr:(NSString * _Nonnull)urlStr {
}

// 在一个新的 ViewController 中打开Url
- (void)openNewWebViewWithTitle:(NSString * _Nonnull)title urlStr:(NSString * _Nonnull)urlStr {
}

// 使用外部浏览器 打开Url
- (void)openExternalWithUrlStr:(NSString * _Nonnull)urlStr {
}
    
// 隐藏 加载中UI组件
- (void)hideLoading {
    [self.hud hideAnimated: true];
}
    
// 设置 标题栏标题
- (void)setNavigationBarTitleWithTitle:(NSString * _Nonnull)title {
}
    
// 设置 标题栏风格
- (void)setNavigationBarStyleWithStyle:(NSString * _Nonnull)style {
}
    
// 设置 标题栏 右侧按钮
- (void)setNavigationBarRightWithButton:(NSDictionary<NSString *, id> * _Nonnull)button {
}
    
// 设置 标题栏 右侧按钮小红点状态
- (void)setNavigationBarRightDotStateWithState:(BOOL)state {
}
    
// 显示 异常UI组件
- (void)errorViewWithState:(BOOL)state retryUrl:(NSString * _Nonnull)retryUrl {
}

@end
