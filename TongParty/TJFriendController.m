//
//  TJFriendController.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJFriendController.h"
#import "TJFriendCell.h"
#import "TJAddFriendController.h"

@interface TJFriendController ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *okBtn;

@end

@implementation TJFriendController

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
            make.top.mas_equalTo(23);
        }
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"我的好友";
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
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBtn setImage:kImage(@"TJAddFriend") forState:UIControlStateNormal];
    _okBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_okBtn];
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(23);
        }
        make.trailing.mas_equalTo(-14);
        make.size.mas_equalTo(CGSizeMake(24, 26));
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJFriendCellID"];
    if (!cell) {
        cell = [[TJFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJFriendCellID"];
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    if (dic[@"head_image"]) {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"head_image"]]];
    }
    cell.titleL.text = dic[@"nickname"];
    cell.contentL.text = [NSString stringWithFormat:@"实到 %@/%@ 创建；实到 %@/%@ 参与", dic[@"create_finish"], dic[@"create_num"], dic[@"join_finish"], dic[@"join_num"]];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)okAction {
    [self.navigationController pushViewController:[TJAddFriendController new] animated:true];
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
    [DDResponseBaseHttp getWithAction:kTJFriendList params:dic type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
