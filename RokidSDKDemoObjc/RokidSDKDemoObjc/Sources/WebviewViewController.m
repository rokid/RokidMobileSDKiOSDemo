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

@interface WebviewViewController () <RKBridgeModuleViewDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) RKWebBridge *webbridge;

@property (weak, nonatomic) MBProgressHUD *hud;

@end

@implementation WebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc] init];
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    // 注入RKWebBridge
//    self.webbridge = [RKWebBridge injectWebBridgeTo:self.webView];
    
    // 设置 RKBridgeModuleViewDelegate，用于实现 Native UI 的功能
//    [self.webbridge setViewDelegateWithDelegate:self];
    
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if (self.webURL) {
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.webURL]];
    }
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

- (void)showToastWithMessage:(NSString * _Nonnull)message {
    
}

- (void)toast:(NSString * _Nonnull)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:1.5f];
}

- (void)showLoading:(NSString * _Nonnull)message {
    if (self.hud != nil) {
        [self.hud hideAnimated:false];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = message;
    self.hud = hud;
}

- (void)hideLoading {
    [self.hud hideAnimated: true];
}

- (void)setNavigationBarTitle:(NSString * _Nonnull)title {
    NSLog(@"setNavigationBarTitle %@", title);
}

- (void)setNavigationRightButton:(NSDictionary<NSString *,id> * _Nonnull)button {
    NSLog(@"setNavigationRightButton %@", button);
}

- (void)setNavigationViewStyle:(NSString * _Nonnull)style {
    NSLog(@"setNavigationViewStyle %@", style);
}

- (void)setRightViewDotStatus:(BOOL)status {
    NSLog(@"setRightViewDotStatus %@", status ? @"YES" : @"NO");
}



@end
