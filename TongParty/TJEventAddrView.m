//
//  TJEventAddrView.m
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEventAddrView.h"

@implementation TJEventAddrView
- (void)createUI {
    
    self.backgroundColor = kWhiteColor;
    
    float topSpace = 20;
    if (iPhoneX) {
        topSpace = 44;
    }
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(3+topSpace);
        make.left.mas_equalTo(self).offset(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"活动地址";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(12+topSpace);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(58, 20));
    }];
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_okBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _okBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:_okBtn];
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(3+topSpace);
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
    
    
    UIImageView *attachedIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJEventAddrAttached"]];
    [self addSubview:attachedIV];
    [attachedIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(61+topSpace);
        make.left.mas_offset(24);
        make.size.mas_offset(CGSizeMake(10, 10));
    }];
    

//    _searchBtn = [[UIButton alloc] init];
//    [_searchBtn setImage:[UIImage imageNamed:@"TJSearchMark"] forState:UIControlStateNormal];
//    [_searchBtn setTitle:@"搜索地点" forState:UIControlStateNormal];
//    [_searchBtn setTitleColor:[UIColor hx_colorWithHexString:@"#859CB0"] forState:UIControlStateNormal];
//    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"TJSearchBackground"] forState:UIControlStateNormal];
//    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"TJSearchBackground"] forState:UIControlStateHighlighted];
//    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self addSubview:_searchBtn];
//    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(72);
//        make.left.mas_offset(46);
//        make.right.mas_offset(-24);
//        make.height.mas_equalTo(29);
//    }];
    
}

@end
