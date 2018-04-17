
//
//  TJDeskNoticeView.m
//  TongParty
//
//  Created by tojoin on 2018/4/17.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskNoticeView.h"

@implementation TJDeskNoticeView

- (void)createUI {
    UIImageView *backBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 57)];
    [self addSubview:backBackground];
    
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceBtn setImage:kImage(@"TJNoticeVoice") forState:UIControlStateNormal];
//    voiceBtn.frame = CGRectMake(24, 17, 14, 20);
    [self addSubview:voiceBtn];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(14, 20));
    }];
    
    
    _keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _keyboardBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_keyboardBtn setImage:kImage(@"TJKeyboard") forState:UIControlStateNormal];
    [_keyboardBtn setImage:kImage(@"TJkeyboard_selected") forState:UIControlStateSelected];
    _keyboardBtn.frame = CGRectMake(kScreenWidth-24-20+5, 19, 30, 30);
    [self addSubview:_keyboardBtn];
    [_keyboardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _input = [[UITextField alloc] init];
    _input.font = [UIFont systemFontOfSize:13];
    _input.placeholder = @"请输入内容";
    [_input setValue:[UIColor hx_colorWithHexString:@"#92A7B9"] forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:_input];
    [_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(47);
        make.right.mas_equalTo(_keyboardBtn.mas_left);
        make.height.mas_equalTo(18);
    }];

}

@end
