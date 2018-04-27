//
//  TJAddFriendController.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJAddFriendController.h"
#import "TJSearchFriendController.h"

@interface TJAddFriendController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJAddFriendController

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
    titleLabel.text = @"添加好友";
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
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setAdjustsImageWhenHighlighted:false];
    [searchBtn setBackgroundImage:kImage(@"TJSearchBackground") forState:UIControlStateNormal];
    [searchBtn setImage:kImage(@"TJSearchMark") forState:UIControlStateNormal];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [searchBtn setTitle:@"搜索对方手机号码" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor hx_colorWithHexString:@"#859CB0"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(62);
        } else {
            make.top.mas_equalTo(82);
        }
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(29);
    }];
    
    
    UIButton *addContact = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContact setTitle:@"添加通讯录好友" forState:UIControlStateNormal];
    [addContact setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    addContact.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addContact.titleLabel.font = [UIFont systemFontOfSize:15];
    [addContact addTarget:self action:@selector(addContactAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addContact];
    [addContact mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(122);
        } else {
            make.top.mas_equalTo(142);
        }
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(22);
    }];
    
    UIImageView *indicate = [[UIImageView alloc] initWithImage:kImage(@"TJMoreBtn")];
    [self.view addSubview:indicate];
    [indicate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addContact);
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    [self.view addSubview:line2];
    line2.backgroundColor = kSeparateLine;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(121);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.view addSubview:self.tableView];
    self.dataSource = @[];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 78;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(245);
        } else {
            make.top.mas_equalTo(265);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJAddFriendCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJAddFriendCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)searchBtnAction {
    [self.navigationController pushViewController:[TJSearchFriendController new] animated:true];
}

- (void)addContactAction {
    
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
