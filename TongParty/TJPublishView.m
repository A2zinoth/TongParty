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
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(33);
        make.left.mas_equalTo(self).offset(24);
        make.size.mas_equalTo(CGSizeMake(28, 18));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"创建桌子";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(32);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(58, 20));
    }];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(33);
        make. trailing.mas_equalTo(self).offset(-24);
        make.size.mas_equalTo(CGSizeMake(28, 18));
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = [UIColor hx_colorWithHexString:@"#D8D8D8"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

@end
