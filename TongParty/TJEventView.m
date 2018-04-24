//
//  TJEventView.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEventView.h"
#import <IQKeyboardManager/IQUIView+IQKeyboardToolbar.h>

@implementation TJEventView

- (void)createUI {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.f];
    
    UIView *maskView = [[UIView alloc] init];
    [self addSubview:maskView];
    maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(154-20);
        } else {
            make.top.mas_equalTo(self).offset(154);
        }
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    _inputTF = [[UITextField alloc] init];
    _inputTF.placeholder = @"请输入活动描述";
    _inputTF.backgroundColor = kWhiteColor;
    [self addSubview:_inputTF];
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(maskView).offset(-23-17);
        make.left.mas_equalTo(self).offset(120);
        make.right.mas_equalTo(self).offset(25);
        make.height.mas_equalTo(19);
    }];
    [_inputTF addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
}

- (void)doneAction:(UITextField *)textfield {
    self.complete(_inputTF.text);
    [self removeFromSuperview];
}

@end
