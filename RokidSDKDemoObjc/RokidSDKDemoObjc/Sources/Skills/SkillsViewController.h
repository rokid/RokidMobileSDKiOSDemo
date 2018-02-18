//
//  SkillsViewController.h
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/2/7.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UITextView *textview;

@end
