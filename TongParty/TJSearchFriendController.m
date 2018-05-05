//
//  TJSearchFriendController.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSearchFriendController.h"
#import "TJFollowCell.h"

@interface TJSearchFriendController ()<UISearchBarDelegate>


@end

@implementation TJSearchFriendController
- (void)createUI {
    UIButton *_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
        make.right.mas_equalTo(-14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:kImage(@"TJSearchBackground")];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImage];
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(8);
        } else {
            make.top.mas_equalTo(28);
        }
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(_cancelBtn.mas_left).offset(-12);
    }];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索对方手机号码";
    searchBar.delegate = self;
    searchBar.barStyle = UISearchBarStyleMinimal;
    searchBar.backgroundImage = [UIImage new];
    searchBar.tintColor = kBtnEnable;
    for (UIView* subview in [[[searchBar.subviews lastObject].subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UIView class]]) {
            [subview removeFromSuperview];
        }
    }
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(21);
        }
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(_cancelBtn.mas_left).offset(-4);
    }];
   
    
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
        } else {
            make.top.mas_equalTo(64);
        }
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
    TJFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJSearchCellID"];
    if (!cell) {
        cell = [[TJFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJSearchCellID"];
        [cell.actionBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    if (dic[@"head_image"]) {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"head_image"]]];
    }
    cell.titleL.text = dic[@"nickname"];
    cell.contentL.text = dic[@"mobile"];
    [cell updateAddFriend:dic[@"is_friend"]];
    [cell updateBtnTag:indexPath.row];
    return cell;
}

- (void)btnAction:(UIButton *)btn {
    NSInteger index = btn.tag;
    //    NSString *act;
    
    if (!btn.selected) {// 加好友
        [DDResponseBaseHttp getWithAction:kTJApplyFriend params:@{@"token":curUser.token, @"oid":self.dataSource[index][@"user_id"]} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                btn.selected = true;
            }
        } failure:^{
        }];
    }
//    else { // 未关注
//        [DDResponseBaseHttp getWithAction:kTJCancelFollow params:@{@"token":curUser.token, @"oid":self.dataSource[index][@"follow_id"]} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
//            [MBProgressHUD showMessage:result.msg_cn];
//            if ([result.status isEqualToString:@"success"]) {
//                btn.selected = true;
//            }
//        } failure:^{
//        }];
//    }
}


#pragma mark -UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length == 11) {
        [self requestData:searchBar.text];
    } else {
        [MBProgressHUD showMessage:@"手机号码有误"];
    }
}

- (void)requestData:(NSString *)search {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJSearchUser params:@{@"token":curUser.token, @"mobile":search} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            weakSelf.dataSource = @[result.data];
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        
    }];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
