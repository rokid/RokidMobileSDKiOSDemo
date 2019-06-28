//
//  SMContainerViewController.h
//  testContainerView
//
//  Created by coco zhou on 2018/3/29.
//  Copyright © 2018年 coco zhou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SMContainerViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<UIViewController *>  * viewCtrlsArr;
@property (nonatomic, strong) NSArray  * titlesArr;

- (id)initWithTitles:(NSArray*)titlesArr viewControllersArr:(NSArray*)vcsArr;

@end
