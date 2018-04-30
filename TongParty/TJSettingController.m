//
//  TJSettingController.m
//  TongParty
//
//  Created by tojoin on 2018/4/28.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSettingController.h"
#import "TJRegisterController.h"
#import "TJBindPhoneController.h"

@interface TJSettingController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJSettingController

- (void)createUI {
    

    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage imageNamed:@"TJBackBtn"] forState:UIControlStateNormal];
    _cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
//    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(9);
        } else {
            make.top.mas_equalTo(29);
        }
//        make.top.mas_equalTo(24);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(26, 26));
//        make.left.mas_equalTo(14);
//        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"设置";
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
    
    UIButton *bindPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindPhoneBtn setTitle:@"手机认证" forState:UIControlStateNormal];
    [bindPhoneBtn setTitleColor:[UIColor hx_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [bindPhoneBtn addTarget:self action:@selector(bindPhoneBtn) forControlEvents:UIControlEventTouchUpInside];
    bindPhoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:bindPhoneBtn];
    [bindPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(line).offset(8);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor hx_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(bindPhoneBtn.mas_bottom).offset(8);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)exitBtn {
    kWeakSelf
    [self alertWithTitle:@"提示" message:@"确定要退出吗？" style:UIAlertControllerStyleAlert cancel:^{
        
    } ok:^{
        [userManager logout:^(BOOL success, NSString *des) {
            if (success) {
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TJRegisterController new]];
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

- (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(void (^)())cancel ok:(void (^)())ok {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancel();
    }];
    [ac addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ok();
    }];
    [ac addAction:okAction];
    [self presentViewController:ac animated:true completion:nil];
}

@end
