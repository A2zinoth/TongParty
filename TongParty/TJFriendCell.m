//
//  TJFriendCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJFriendCell.h"

@implementation TJFriendCell

- (void)createUI {
    _headImage = [[UIImageView alloc] init];
    _headImage.layerCornerRadius = 24;
    [self.contentView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _titleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(88);
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(22);
    }];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _contentL.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(88);
        make.top.mas_equalTo(47);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(19);
    }];
}

@end
