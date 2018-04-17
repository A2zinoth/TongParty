//
//  DDInterestedVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInterestedVc.h"
#import "DDCustomCommonEmptyView.h"
#import "DDDeskShowViewController.h"  //桌子页面
#import "DDInterestTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
@interface DDInterestedVc ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray  *dataArray;
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end
static NSString *cellid = @"celllid";
@implementation DDInterestedVc

- (void)userLoadData {
    [self refresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self loadData];
}
// 设置子视图
- (void)setUpViews {
    [self.view addSubview:self.tableView];
}

#pragma mark  -  请求数据
- (void)loadData {
    [super loadData];
    [self showLoadingView];
    [DDTJHttpRequest getInterestedDeskWithToken:TOKEN lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude block:^(NSDictionary *dict) {
        [self hideLoadingView];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
        }
        [self.tableView reloadData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (void)refresh {
    [DDTJHttpRequest getInterestedDeskWithToken:TOKEN lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude block:^(NSDictionary *dict) {
        [self.tableView.mj_header endRefreshing];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
        }
        [self.tableView reloadData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (UITableView *)tableView {
    WeakSelf(weakSelf);
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refresh];
        }];
        [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        header.stateLabel.font = [UIFont systemFontOfSize:13];
        header.stateLabel.textColor = kCommonBlackColor;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        [_tableView registerClass:[DDInterestTableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}

- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"您尚无感兴趣的桌子！" iconname:@"noData"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDInterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DDInterestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(145.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDTableModel *model = _dataArray[indexPath.row];
    DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
    deskShowVC.tmpModel   = model;
    [self.navigationController pushViewController:deskShowVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end






