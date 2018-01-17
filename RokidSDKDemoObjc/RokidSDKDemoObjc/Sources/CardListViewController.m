//
//  CardListViewController.m
//  RokidSDKDemoObjc
//
//  Created by Yock on 2018/1/17.
//  Copyright © 2018年 Rokid. All rights reserved.
//

#import "CardListViewController.h"
#import "MJRefresh.h"
@import RokidSDK;

@interface CardListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *cardList;

@end

@implementation CardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cardList = [[NSMutableArray alloc] init];
    
    self.cardListView.dataSource = self;
    self.cardListView.delegate = self;
    self.cardListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchCardList)];
    [self.cardListView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchCardList {
    NSInteger dbId = [self dbId];
    [RokidMobileSDK.home getCardListWithMaxDbId:dbId pageSize:20 completion:^(RKError * error, NSArray<RKCard *> * cardArray) {
        if (dbId == 0) {
            
        }
        if (cardArray != nil && cardArray.count > 0) {
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, [cardArray count])];
            [self.cardList insertObjects:cardArray atIndexes:indexes];
        }
        [self.cardListView.mj_header endRefreshing];
        [self.cardListView reloadData];
    }];
}

- (NSInteger) dbId {
    if (self.cardList == nil) {
        return 0;
    }
    if (self.cardList.count == 0) {
        return 0;
    }
    RKCard *card = [self.cardList objectAtIndex:0];
    if (card == nil) {
        return 0;
    }
    return card.dbId;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cardList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"card"];
    RKCard *card = [self.cardList objectAtIndex:indexPath.row];
//    cell.textLabel.text = card.msgText;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[card.msgText dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
//    cell.textLabel.text = dict[""]
    
    return cell;
}

@end
