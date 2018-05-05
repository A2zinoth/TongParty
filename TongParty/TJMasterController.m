//
//  TJMasterController.m
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJMasterController.h"
#import "TJFollowCell.h"
#import "TJDeskViewController.h"

@interface TJMasterController ()

@property (nonatomic, strong) UIButton *cancelBtn;


@end

@implementation TJMasterController

- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
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
    
    

    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.mas_equalTo(32);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(12);
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
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
    [cell updateMasterNotice];
    [cell updateMasterNoticeWith:self.dataSource[indexPath.row]];
    [cell updateBtnTag:indexPath.row];
    if ([_act isEqualToString:@"member_table"]) {
        cell.actionBtn.hidden = true;
    } else {
        cell.actionBtn.hidden = false;
    }

    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    TJDeskViewController *deskVC = [[TJDeskViewController alloc] init];
//    deskVC.tid = self.dataSource[indexPath.row][@"tid"];
//    deskVC.flag = @"MyTable";
//    [self.navigationController pushViewController:deskVC animated:true];
//}


- (void)btnAction:(UIButton *)btn {
    NSInteger index = btn.tag;
    NSString *act;
    // 0申请 3回复  4加入
    if (btn.selected) {

    } else {
        act = @"agree";
        [DDResponseBaseHttp getWithAction:@"/tojoin/api/process_table_apply.php" params:@{@"token":curUser.token, @"oid":self.dataSource[index][@"from_id"], @"tid":self.dataSource[index][@"tid"], @"act":act} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                btn.selected = !btn.selected;
            }
        } failure:^{
        }];
    }

    
}

#pragma mark - UITableViewDelegate

- (void)requestData {
    NSLog(@"%@",_act);
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJMessageDetail params:@{@"token":curUser.token, @"act":_act, @"tid":_tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {

            weakSelf.dataSource = result.data;
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}


@end
