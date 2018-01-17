//
//  WebviewViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2018/1/17.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "WebviewViewController.h"
#import <WebKit/WebKit.h>
@import RokidSDK;

@interface WebviewViewController ()

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) RKWebViewBridge *webbridge;

@end

@implementation WebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc] init];
    self.webbridge = [[RKWebViewBridge alloc] init:self.webView];
    
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

@end
