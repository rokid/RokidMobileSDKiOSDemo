//
//  IotViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/28.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "IotViewController.h"
@import WebKit;

@interface IotViewController ()
@property(nonatomic, strong) RKWebBridge * rkWebBridge ;
@property(nonatomic, strong) WKWebView * webView;
@end

@implementation IotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    //self.rkWebBridge
    self.webView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.webView];

    NSURL *url = [NSURL URLWithString:@"https://s.rokidcdn.com/homebase/himalaya/dev/index.html#/homes/index"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webView loadRequest:request];
    //self.webView.UIDelegate = self;

    self.rkWebBridge = [RKWebBridge injectWebBridgeTo:self.webView];
    RKBridgeModuleApp * bridgeApp = (RKBridgeModuleApp *)[self.rkWebBridge getModuleBy:[RKWebBridge ModuleNameApp]];
    bridgeApp.delegate = self;
    
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
    
}

- (void)openExternalWithUrlStr:(NSString * _Nonnull)urlStr{
    
}


@end
