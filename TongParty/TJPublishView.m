//
//  TJPublishView.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishView.h"

@implementation TJPublishView

- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self).offset(3);
        } else {
            make.top.mas_equalTo(self).offset(23);
        }
        make.left.mas_equalTo(self).offset(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"创建桌子";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self).offset(12);
        } else {
            make.top.mas_equalTo(self).offset(32).key(@"titleLabel");
        }
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(58, 20));
    }];
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBtn setTitle:@"发布" forState:UIControlStateNormal];
    [_okBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _okBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:_okBtn];
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self).offset(3);
        } else {
            make.top.mas_equalTo(self).offset(23);
        }
        make. trailing.mas_equalTo(self).offset(-14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

@end
