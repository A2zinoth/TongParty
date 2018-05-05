//
//  TJDeskHistoryController.m
//  TongParty
//
//  Created by tojoin on 2018/5/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskHistoryController.h"
#import "TJDeskHistoryCell.h"

@interface TJDeskHistoryController ()

@property (nonatomic, copy) __block NSString *serviceTime;

@end

@implementation TJDeskHistoryController

- (void)createUI {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    titleLabel.text = @"桌子历史";
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
    self.tableView.rowHeight = 94;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
        } else {
            make.top.mas_equalTo(64);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 149)];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-52)/2, 30, 52, 52)];
    headImage.layerCornerRadius = 26;
    [headImage sd_setImageWithURL:[NSURL URLWithString:curUser.image]];
    [background addSubview:headImage];
    
    UILabel *partake = [[UILabel alloc] initWithFrame:CGRectMake(0, 92, kScreenWidth, 28)];
    if (_attributedString) {
        partake.attributedText = _attributedString;
    }
    partake.textAlignment = NSTextAlignmentCenter;
    [background addSubview:partake];
    
    self.tableView.tableHeaderView = background;
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
    TJDeskHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJDeskHistoryCellID"];
    if (!cell) {
        cell = [[TJDeskHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJDeskHistoryCellID"];
    }
    NSArray *colors = @[@"#9AD14B", @"#FF664E", @"#68BDFF", @"#FFCD76", @"#A46DFF"];
    [cell updateCircleColor:colors[indexPath.row%5]];
    cell.time.text = self.dataSource[indexPath.row][@"begin_time"];
    cell.title.text = self.dataSource[indexPath.row][@"title"];
    [cell updatePastTime:self.dataSource[indexPath.row][@"begin_time"] serviceTime:_serviceTime];

    return cell;
}

- (void)requestData {
    NSDictionary *dic;
    if (_act) {
        dic = @{@"token":curUser.token, @"act":@"others",@"uid":_act};
    } else {
        dic = @{@"token":curUser.token, @"act":@"my"};
    }
    
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJTableHistory params:dic type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            weakSelf.dataSource = result.data[@"tables"];
            weakSelf.serviceTime = result.data[@"serviceTime"];
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        
    }];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
