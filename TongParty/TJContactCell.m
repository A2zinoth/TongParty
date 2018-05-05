//
//  TJContactCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/29.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJContactCell.h"

@implementation TJContactCell

- (void)createUI {
    _titleL = [[UILabel alloc] init];
    _titleL.text = @"丽萨";
    _titleL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _titleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(21);
    }];
    
    _contentL = [[UILabel alloc] init];
    _contentL.text = @"16554532564";
    _contentL.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _contentL.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(18);
    }];
    
    _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"已邀请" forState:UIControlStateSelected];
    _actionBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonSelect") forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
    _actionBtn.layer.cornerRadius = 15;
    [self.contentView addSubview:_actionBtn];
    [_actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_contentL);
        make.right.mas_equalTo(-41);
        make.size.mas_equalTo(CGSizeMake(62, 30));
    }];
}

@end
