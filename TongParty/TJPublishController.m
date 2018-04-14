//
//  TJPublishController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishController.h"
#import "TJPublishView.h"
#import "TJPublishModel.h"
#import "TJPublishTableViewCell.h"
#import "TJEventView.h"

@interface TJPublishController ()

@property (nonatomic, strong) TJPublishView *publishView;
@property (nonatomic, strong) TJPublishModel *publishModel;

@property (nonatomic, strong) TJEventView *eventView;



@end

@implementation TJPublishController
- (void)createData {
    self.dataSource = @[@{@"title":@"活动描述",@"":@""},
                        @{@"title":@"选择主题",@"":@""},
                        @{@"title":@"选择时间",@"":@""},
                        @{@"title":@"活动地点",@"":@""},
                        @{@"title":@"活动人数",@"":@""},
                        @{@"title":@"预估人均",@"":@""},
                        @{@"title":@"是否加入心跳桌", @"":@""}];
    
    _publishModel = [[TJPublishModel alloc] init];
}
- (void)createUI {
    _publishView = [[TJPublishView alloc] init];
    [self.view addSubview:_publishView];
    [_publishView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    [_publishView.cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(92);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.mas_equalTo(self.view).offset(92);
            make.bottom.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJPublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJPublishTableViewCellID"];
    if (!cell) {
        cell = [[TJPublishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJPublishTableViewCellID"];
    }
    [cell updateDataWithDic:self.dataSource[indexPath.row]];
    [cell updateDataWithRow:indexPath.row model:_publishModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.view addSubview:self.eventView];
        [_eventView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
        }];
        [_eventView.inputTF becomeFirstResponder];
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    } else if (indexPath.row == 5) {
        
    }
   
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (TJEventView *)eventView {
    if (!_eventView) {
        _eventView = [[TJEventView alloc] init];
    }
    return _eventView;
}

@end
