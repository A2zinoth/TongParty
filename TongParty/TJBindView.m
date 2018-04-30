//
//  TJBindView.m
//  TongParty
//
//  Created by tojoin on 2018/4/28.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBindView.h"

@implementation TJBindView

- (void)createUI {
    _closeBtn = [[UIButton alloc] init];
    [self addSubview:_closeBtn];
    [_closeBtn setImage:[UIImage imageNamed:@"TJBackBtn"] forState:UIControlStateNormal];
    _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.left.mas_equalTo(19);
        make.size.mas_equalTo(CGSizeMake(19, 26));
    }];
    
    
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    _titleLabel.text = @"绑定手机号码";
    _titleLabel.font = [UIFont systemFontOfSize:29];
    _titleLabel.textColor = [UIColor hx_colorWithHexString:@"#333333"];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(67);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    _phoneNum = [[UILabel alloc] init];
    [self addSubview:_phoneNum];
    _phoneNum.text = @"请输入正确的手机号码";
    _phoneNum.font = [UIFont systemFontOfSize:19];
    _phoneNum.textColor = [UIColor hx_colorWithHexString:@"#333333"];
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(123);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(26);
    }];
    
    UILabel *phoneNum = [[UILabel alloc] init];
    [self addSubview:phoneNum];
    phoneNum.text = @"手机号";
    phoneNum.font = [UIFont systemFontOfSize:16];
    phoneNum.textColor = [UIColor hx_colorWithHexString:@"#333333"];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(220);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(49, 22));
    }];
    
    UILabel *countryCode = [[UILabel alloc] init];
    [self addSubview:countryCode];
    countryCode.text = @"CN+86";
    countryCode.font = [UIFont systemFontOfSize:11];
    countryCode.textColor = [UIColor hx_colorWithHexString:@"#333333"];
    [countryCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(259);
        make.left.mas_equalTo(32);
        make.size.mas_equalTo(CGSizeMake(38, 16));
    }];
    
    _phoneTF = [[UITextField alloc] init];
    [self addSubview:_phoneTF];
    _phoneTF.font = [UIFont systemFontOfSize:30];
    _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(252);
        make.left.mas_equalTo(91);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(294);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(0.5);
    }];
    
    
    _nextButton = [[UIButton alloc] init];
    [self addSubview:_nextButton];
    _nextButton.enabled = false;
    if (kiPhoen) {
        _nextButton.enabled = true;
    }
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:kBtnDisable];
    [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _nextButton.layer.cornerRadius = 20;
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(357);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
}

@end
