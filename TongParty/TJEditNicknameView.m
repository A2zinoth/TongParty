//
//  TJEditNicknameView.m
//  TongParty
//
//  Created by tojoin on 2018/4/22.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEditNicknameView.h"
#import <IQKeyboardManager/IQUIView+IQKeyboardToolbar.h>

@implementation TJEditNicknameView

- (void)createUI {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.f];
    
    UIView *maskView = [[UIView alloc] init];
    [self addSubview:maskView];
    maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(225);
        } else {
            make.top.mas_equalTo(self).offset(225);
        }
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    _inputTF = [[UITextField alloc] init];
    _inputTF.placeholder = @"请输入昵称";
    _inputTF.backgroundColor = kWhiteColor;
    _inputTF.font = [UIFont systemFontOfSize:15];
    [self addSubview:_inputTF];
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(maskView).offset(-24-18);
        make.left.mas_equalTo(self).offset(77);
        make.right.mas_equalTo(self).offset(-35);
        make.height.mas_equalTo(21);
    }];
    [_inputTF addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
}

- (void)doneAction:(UITextField *)textfield {
    self.complete(_inputTF.text);
    [self removeFromSuperview];
}

@end
