//
//  SMContainerViewController.m
//  testContainerView
//
//  Created by coco zhou on 2018/3/29.
//  Copyright © 2018年 coco zhou. All rights reserved.
//

#import "SMContainerViewController.h"
#import "HMSegmentedControl.h"


@interface SMContainerViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (strong, nonatomic)   UIView *containerView;

@end

@implementation SMContainerViewController

#define  Width     UIScreen.mainScreen.bounds.size.width
#define  Height    UIScreen.mainScreen.bounds.size.height


- (id)initWithTitles:(NSArray*)titlesArr viewControllersArr:(NSArray*)vcsArr {
    self = [super initWithNibName:nil bundle:nil];
    self.titlesArr = titlesArr;
    self.viewCtrlsArr = vcsArr;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSegmentControl];
    [self addContainerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interaction

#define  HeightSGControl    50
#define  HeightOfNaviBar    0
#define  HeightOfTabBar     44

- (void)setupSegmentControl {

//    self.viewCtrlsArr = @[target, targetX, targetY];
//    self.titlesArr = @[@"闹钟", @"技能", @"提醒"];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, HeightOfNaviBar, Width, HeightSGControl)];
    self.segmentedControl.sectionTitles = self.titlesArr;
    self.segmentedControl.selectedSegmentIndex = 1;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]};
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = self.viewCtrlsArr.count;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(Width * index, 0, Width, Height) animated:YES];
    }];

    [self.view addSubview:self.segmentedControl];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HeightOfNaviBar+HeightSGControl, Width, Height)];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(Width * self.viewCtrlsArr.count, Height);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, Width, Height) animated:NO];
    [self.view addSubview:self.scrollView];
    
}

- (void)addContainerView {
    for (int i= 0; i< self.viewCtrlsArr.count; i++) {
        UIViewController * tg = self.viewCtrlsArr[i];
        tg.view.frame = CGRectMake(i*Width, 0, Width, Height -HeightOfNaviBar-HeightSGControl-HeightOfTabBar);
        [self.scrollView addSubview:tg.view];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}



@end
