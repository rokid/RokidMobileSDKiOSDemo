//
//  SkillsViewControllerNew.m
//  RokidSDKDemoObjc
//
//  Created by coco zhou on 2018/3/29.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "SkillsViewControllerNew.h"


@interface SkillsViewControllerNew ()

@end

@implementation SkillsViewControllerNew

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titlesArr = @[@"1闹钟", @"2提醒",@"3智能家居"];
    NSMutableArray * tmpArr = [NSMutableArray new];
    for (int i=0; i<self.titlesArr.count; i++) {
        UIViewController * target = [[UIViewController alloc] init];
        [tmpArr insertObject:target atIndex:0];
    }
    self.viewCtrlsArr = tmpArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
