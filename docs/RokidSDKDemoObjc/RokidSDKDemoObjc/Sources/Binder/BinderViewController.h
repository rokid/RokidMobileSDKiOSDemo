//
//  BinderViewController.h
//  RokidSDKDemoObjc
//
//  Created by Yock on 2017/12/7.
//  Copyright © 2017年 Rokid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BinderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (weak, nonatomic) IBOutlet UITableView *bleList;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end
