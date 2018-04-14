//
//  TJCreatePwdView.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJCreatePwdView.h"

@implementation TJCreatePwdView

- (void)createUI {
    _closeBtn = [[UIButton alloc] init];
    [self addSubview:_closeBtn];
    [_closeBtn setImage:[UIImage imageNamed:@"love_close"] forState:UIControlStateNormal];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    _signupBtn = [[UIButton alloc] init];
    [self addSubview:_signupBtn];
    [_signupBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_signupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_signupBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(31);
        make.trailing.mas_equalTo(-22);
        make.size.mas_equalTo(CGSizeMake(33, 22));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"创建密码";
    titleLabel.font = [UIFont systemFontOfSize:29];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(87);
        make.left.mas_equalTo(22);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    _phoneNum = [[UILabel alloc] init];
    [self addSubview:_phoneNum];
    _phoneNum.text = @"密码必须的长度至少为8个字符";
    _phoneNum.font = [UIFont systemFontOfSize:19];
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(143);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(27);
    }];
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    [self addSubview:noticeLabel];
    noticeLabel.text = @"密码";
    noticeLabel.font = [UIFont systemFontOfSize:13];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(240);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    
    _passwordTF = [[UITextField alloc] init];
    [self addSubview:_passwordTF];
    _passwordTF.font = [UIFont systemFontOfSize:30];
    _passwordTF.secureTextEntry = true;
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(272);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(24);
        make.height.mas_equalTo(30);
    }];
    
    _resetBtn = [[YYLabel alloc] init];
    [self addSubview:_resetBtn];
    _resetBtn.text = @"显示";
    _resetBtn.font = [UIFont systemFontOfSize:13];
    WeakSelf(weakSelf);
    _resetBtn.textTapAction = ^ (UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        weakSelf.passwordTF.secureTextEntry = !weakSelf.passwordTF.secureTextEntry;
    };
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(240);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(28, 19));
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = [UIColor hx_colorWithHexString:@"#D8D8D8"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(314);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(1);
    }];
    
    _loginBtn = [[YYLabel alloc] init];
    [self addSubview:_loginBtn];
    _loginBtn.text = @"登录";
    _loginBtn.textColor = [UIColor whiteColor];
    _loginBtn.textAlignment = NSTextAlignmentCenter;
    _loginBtn.backgroundColor = [UIColor colorWithRed:86/255.f green:126/255.f blue:247/255.f alpha:1];
    _loginBtn.font = [UIFont systemFontOfSize:15];
    _loginBtn.layer.cornerRadius = 20;
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(377);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
    
}


@end
