//
//  IotRoomViewController.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/28.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "IotRoomViewController.h"
@import WebKit;

@interface IotRoomViewController ()
@property(nonatomic, strong) WKWebView * webView;

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
