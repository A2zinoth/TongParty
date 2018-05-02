//
//  TJSystemController.m
//  TongParty
//
//  Created by tojoin on 2018/5/2.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSystemController.h"
#import "TJSystemCell.h"

@interface TJSystemController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJSystemController
- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(self.view).offset(23);
        }
        make.left.mas_equalTo(self.view).offset(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"系统通知";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.mas_equalTo(self.view).offset(32).key(@"titleLabel");
        }
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 20));
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
    self.tableView.rowHeight = 248;
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJSystemCellID"];
    if (!cell) {
        cell = [[TJSystemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJSystemCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.content.text = self.dataSource[indexPath.row][@"content"];
    [cell updateTime:self.dataSource[indexPath.row][@"uptime"]];
    [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row][@"image"]]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)requestData {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJMessageDetail params:@{@"token":curUser.token, @"act":@"system"} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
