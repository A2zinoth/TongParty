//
//  TJFollowController.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJFollowController.h"
#import "TJFollowCell.h"

@interface TJFollowController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJFollowController

- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(color) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(23);
        }
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"我的关注";
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.mas_equalTo(32);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(58, 20));
    }];

    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 78;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(45);
        } else {
            make.top.mas_equalTo(65);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJFollowCellID"];
    if (!cell) {
        cell = [[TJFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJFollowCellID"];
        [cell.actionBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    if (dic[@"head_image"]) {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"head_image"]]];
    }
    cell.titleL.text = dic[@"nickname"];
    cell.contentL.text = [NSString stringWithFormat:@"实到 %@/%@ 创建；实到 %@/%@ 参与", dic[@"create_finish"], dic[@"create_num"], dic[@"join_finish"], dic[@"join_num"]];
    [cell updateStatus:dic[@"is_follow"]];
    [cell updateBtnTag:indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)btnAction:(UIButton *)btn {
    NSInteger index = btn.tag;
//    NSString *act;
    
    if (btn.selected) {// 关注
        [DDResponseBaseHttp getWithAction:kTJFollowUser params:@{@"token":curUser.token, @"oid":self.dataSource[index][@"follow_id"]} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                btn.selected = false;
            }
        } failure:^{
        }];
    } else { // 未关注
        [DDResponseBaseHttp getWithAction:kTJCancelFollow params:@{@"token":curUser.token, @"oid":self.dataSource[index][@"follow_id"]} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                btn.selected = true;
            }
        } failure:^{
        }];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData {
    
    NSDictionary *dic;
    if (_act) {
        dic = @{@"token":curUser.token, @"act":@"others",@"uid":_act};
    } else {
        dic = @{@"token":curUser.token, @"act":@"my"};
    }
    
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJFollowList params:dic type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            weakSelf.dataSource = result.data;
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        
    }];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
