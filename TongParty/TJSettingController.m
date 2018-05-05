//
//  TJSettingController.m
//  TongParty
//
//  Created by tojoin on 2018/4/28.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSettingController.h"
#import "TJSettingCell.h"
//#import "TJRegisterController.h"
#import "TJBindPhoneController.h"
#import "TJLoginController.h"


@interface TJSettingController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJSettingController

- (void)createUI {
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.adjustsImageWhenHighlighted  = false;
    [_cancelBtn setImage:[UIImage imageNamed:@"TJBackBtn"] forState:UIControlStateNormal];
    _cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(9);
        } else {
            make.top.mas_equalTo(29);
        }
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    self.dataSource = @[@"手机认证", @"密码设置", @"提醒设置", @"清除缓存", @"帮助", @"关于桐聚", @"退出"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 72;
    if (!IS_IPHONE_5_OR_LESS){
        self.tableView.scrollEnabled = false;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
        } else {
            make.top.mas_equalTo(self.view).offset(64);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    // 首页
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 19, 50, 34)];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont systemFontOfSize:24];
    
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 74)];
    [tableHeadView addSubview:titleLabel];
    self.tableView.tableHeaderView = tableHeadView;

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJSettingCellID"];
    if (!cell) {
        cell = [[TJSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJSettingCellID"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == 3) {
        [cell hiddenAccessory];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self bindPhoneBtn];
    } else if (indexPath.row == 6) {
        [self exitBtn];
    }
}




- (void)exitBtn {
    kWeakSelf
    [self alertWithTitle:@"提示" message:@"确定要退出吗？" style:UIAlertControllerStyleAlert cancel:^{
        
    } ok:^{
        [DDUserDefault removeObjectForKey:@"replay"];
        [DDUserDefault removeObjectForKey:@"invite"];
        
        [userManager logout:^(BOOL success, NSString *des) {
            if (success) {
                TJLoginController *vc = [TJLoginController new];
                vc.phone = @"直接";
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TJLoginController new]];
                [weakSelf presentViewController:nav animated:true completion:nil];
            }
        }];
    }];
}

- (void)bindPhoneBtn {
    TJBindPhoneController *bindPhone = [[TJBindPhoneController alloc] init];
    [self push:bindPhone];
}

- (void)push:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:true];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}


@end
