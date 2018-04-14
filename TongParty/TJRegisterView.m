//
//  TJRegisterView.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJRegisterView.h"

@implementation TJRegisterView

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
    titleLabel.text = @"注册";
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
    line.backgroundColor = [UIColor hx_colorWithHexString:@"#D8D8D8"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(246);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(1);
    }];
    
    
    UIButton *agreeButton = [[UIButton alloc] init];
    [self addSubview:agreeButton];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"注册代表同意《桐聚用户协议》"];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"#717171"] range:NSMakeRange(0, 6)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:86/255.f green:126/255.f blue:247/255.f alpha:1] range:NSMakeRange(6, 8)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 14)];
    [agreeButton setAttributedTitle:attrStr forState:UIControlStateNormal];
    [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(286);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(18);
    }];
    
    _nextButton = [[UIButton alloc] init];
    [self addSubview:_nextButton];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:kBtnDisable];
    [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _nextButton.layer.cornerRadius = 20;
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(377);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
    
}

@end
