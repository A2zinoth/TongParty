//
//  TJApplyNoticeController.m
//  TongParty
//
//  Created by tojoin on 2018/5/2.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJApplyNoticeController.h"
#import "TJNoticeCell.h"

@interface TJApplyNoticeController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJApplyNoticeController

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
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    if (_type) {
        titleLabel.text = @"邀请";
    } else {
        titleLabel.text = @"申请";
    }
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    titleLabel.font = [UIFont systemFontOfSize:14];
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
    self.tableView.rowHeight = 109;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJNoticeCellID"];
    if (!cell) {
        cell = [[TJNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJNoticeCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row][@"head_image"]]];
    cell.titleL.text = self.dataSource[indexPath.row][@"nickname"];
    [cell updateApplyNotice];
    cell.contentL.text = self.dataSource[indexPath.row][@"uptime"];
    [cell updateTime:self.dataSource[indexPath.row][@"uptime"]];
    
    return cell;
}

- (void)requestData {
    NSString *act = @"replay";
    if ([_type isEqualToString:@"邀请"]) {
        act = @"invite";
    }
    
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJMessageDetail params:@{@"token":curUser.token, @"act":act} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
