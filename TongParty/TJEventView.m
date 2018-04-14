//
//  TJEventView.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEventView.h"

@implementation TJEventView

- (void)createUI {
    self.alpha = 0.5;
    
    UIView *maskView = [[UIView alloc] init];
    
    [self addSubview:maskView];
    maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(155);
        } else {
            make.top.mas_equalTo(self).offset(155);
        }
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    _inputTF = [[UITextField alloc] init];
    _inputTF.placeholder = @"请输入活动描述";
    [self addSubview:_inputTF];
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(maskView).offset(-23-17);
        make.left.mas_equalTo(self).offset(120);
        make.right.mas_equalTo(self).offset(25);
        make.height.mas_equalTo(19);
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self removeFromSuperview];
}

@end
