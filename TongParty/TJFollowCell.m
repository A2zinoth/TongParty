//
//  TJFollowCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJFollowCell.h"

@implementation TJFollowCell

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
    _titleL.text = @"丽萨";
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
    _contentL.text = @"实到 2/5 创建；实到 3/6 参与";
    _contentL.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _contentL.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(88);
        make.top.mas_equalTo(47);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(19);
    }];
    
    _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"" forState:UIControlStateSelected];
    _actionBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonSelect") forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
    _actionBtn.layerCornerRadius = 15;
    [self.contentView addSubview:_actionBtn];
    [_actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(62, 30));
    }];
}

- (void)updateMasterNotice {
    [_actionBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"已同意" forState:UIControlStateSelected];
}


- (void)updateMasterNoticeWith:(NSDictionary *)dic {
    [_headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"head_image"]]];
    _titleL.text = dic[@"nickname"];
    _contentL.text = dic[@"msg_text"];
    if ([dic[@"is_read"] isEqualToString:@"1"]) {
        _actionBtn.selected = true;
    } else {
        _actionBtn.selected = false;
    }
    if ([dic[@"type"] isEqualToString:@"1"]) {
        _actionBtn.hidden = true;
    } else {
        _actionBtn.hidden = false;
    }
}

- (void)updateBtnTag:(NSInteger)index {
    _actionBtn.tag = index;
}

// 我的粉丝
- (void)updateFollowerStatus:(NSString *)isFollow {
    [_actionBtn setTitle:@"" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonFollow") forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
    if ([isFollow isEqualToString:@"1"]) {
        _actionBtn.selected = true;
    } else {
        _actionBtn.selected = false;
    }
}

// 我的关注
- (void)updateStatus:(NSString *)isFollow {
    [_actionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"" forState:UIControlStateSelected];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonFollow") forState:UIControlStateSelected];
}

// 消息-我的关注
- (void)updateAttentionNotice {
    _titleL.text = @"丽萨 关注了你";
    _contentL.text = @"03-04";
    [_actionBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"已关注" forState:UIControlStateSelected];
}

// 消息-新的好友
- (void)updateFriendReq {
    _contentL.text = @"申请添加您为好友";
    [_actionBtn setTitle:@"+ 添加" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"已添加" forState:UIControlStateSelected];
}
// 添加好友
- (void)updateAddFriend:(NSString *)isAdd {
    [_actionBtn setTitle:@"" forState:UIControlStateNormal];
    [_actionBtn setTitle:@"已添加" forState:UIControlStateSelected];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonFollow") forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
    if ([isAdd isEqualToString:@"1"]) {
        _actionBtn.selected = true;
    } else {
        _actionBtn.selected = false;
    }
}

@end
