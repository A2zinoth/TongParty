//
//  TJLoginView.m
//  Tojoin
//
//  Created by tojoin on 2018/4/8.
//  Copyright © 2018年 Beijing Tojoin Network Technology Co., Ltd. All rights reserved.
//

#import "TJLoginView.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation TJLoginView

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self createView];
    }
    return self;
}

- (void)createView {
    _closeBtn = [[UIButton alloc] init];
    [self addSubview:_closeBtn];
    [_closeBtn setImage:[UIImage imageNamed:@"TJCloseBtn"] forState:UIControlStateNormal];
    _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    _signupBtn = [[UIButton alloc] init];
    [self addSubview:_signupBtn];
    [_signupBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_signupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_signupBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(31);
        make.trailing.mas_equalTo(-22);
        make.size.mas_equalTo(CGSizeMake(33, 22));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"登录";
    titleLabel.font = [UIFont systemFontOfSize:29];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(87);
        make.left.mas_equalTo(22);
        make.size.mas_equalTo(CGSizeMake(66, 35));
    }];
    
    UILabel *phoneNum = [[UILabel alloc] init];
    [self addSubview:phoneNum];
    phoneNum.text = @"手机号";
    phoneNum.font = [UIFont systemFontOfSize:16];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(172);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(49, 22));
    }];
    
    UILabel *countryCode = [[UILabel alloc] init];
    [self addSubview:countryCode];
    countryCode.text = @"CN+86";
    countryCode.font = [UIFont systemFontOfSize:11];
    [countryCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(211);
        make.left.mas_equalTo(32);
        make.size.mas_equalTo(CGSizeMake(38, 16));
    }];
    
    _phoneTF = [[UITextField alloc] init];
    [self addSubview:_phoneTF];
    _phoneTF.font = [UIFont systemFontOfSize:30];
    _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(204);
        make.left.mas_equalTo(91);
        make.right.mas_equalTo(24);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(246);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *password = [[UILabel alloc] init];
    [self addSubview:password];
    password.text = @"密码";
    password.font = [UIFont systemFontOfSize:16];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(267);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(33, 22));
    }];
    
    UIButton *showPassword = [[UIButton alloc] init];
    [self addSubview:showPassword];
    [showPassword setTitle:@"显示" forState:UIControlStateNormal];
    [showPassword setTitle:@"隐藏" forState:UIControlStateSelected];
    [showPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showPassword.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [showPassword addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [showPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(269);
        make.trailing.mas_equalTo(-23);
        make.size.mas_equalTo(CGSizeMake(27, 18));
    }];
    
    _passwordTF = [[UITextField alloc] init];
    [self addSubview:_passwordTF];
    _passwordTF.font = [UIFont systemFontOfSize:30];
    _passwordTF.secureTextEntry = true;
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(341-12-30);
        make.left.mas_equalTo(91);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(31);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    [self addSubview:line2];
    line2.backgroundColor = kSeparateLine;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(341);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(0.5);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [self addSubview:_loginBtn];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:kBtnEnable];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _loginBtn.layer.cornerRadius = 20;
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(377);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
    
    _forgetBtn = [[UIButton alloc] init];
    [self addSubview:_forgetBtn];
    [_forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    
    [_forgetBtn setTitleColor:kGreyNotice forState:UIControlStateNormal];
    [_forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(438);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(85, 17));
    }];
    
    UILabel *other = [[UILabel alloc] init];
    [self addSubview:other];
    other.text = @"其他登录方式";
    other.textAlignment = NSTextAlignmentCenter;
    other.textColor = [UIColor hx_colorWithHexString:@"#A0A0A0"];
    other.font = [UIFont systemFontOfSize:12];
    [other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k5(559));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(85, 17));
    }];
    
    UIView *line3 = [[UIView alloc] init];
    [self addSubview:line3];
    line3.backgroundColor = kSeparateLine;
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k5(567));
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(other.mas_left).offset(-13);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    [self addSubview:line4];
    line4.backgroundColor = kSeparateLine;
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k5(567));
        make.left.mas_equalTo(other.mas_right).offset(13);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(0.5);
    }];
    
    
    NSArray *thirdImageArr = @[@"personAuth_blind_weibo", @"personAuth_blind_wx", @"personAuth_blind_QQ"];
    NSArray *leftInsets = @[@(kScreenWidth*0.22), @(kScreenWidth/2), @(kScreenWidth*0.78)];
    for (int i = 0; i < 3; i++) {
        UIButton *thirdBtn = [[UIButton alloc] init];
        [self addSubview:thirdBtn];
        [thirdBtn setBackgroundImage:[UIImage imageNamed:thirdImageArr[i]] forState:UIControlStateNormal];
        thirdBtn.tag = 100+i;
        [thirdBtn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
        [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(k5(600));
            make.left.mas_equalTo([leftInsets[i] floatValue]-15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
}

- (void)thirdLogin:(UIButton *)button {
    _thirdAction(button.tag);
}

- (void)showPasswordAction:(UIButton *)button {
    _passwordTF.secureTextEntry = button.selected;
    button.selected = !button.selected;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_phoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
