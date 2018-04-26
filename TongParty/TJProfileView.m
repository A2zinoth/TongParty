//
//  TJProfileView.m
//  TongParty
//
//  Created by tojoin on 2018/4/20.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJProfileView.h"

@implementation TJProfileView

- (instancetype)initWithAct:(NSString *)act {
    self = [super init];
    if (self) {
        _act = act;
        [self updateUI];
    }
    return self;
}

- (void)updateUI {
    [_cancelBtn setImage:kImage(@"TJCloseBtn") forState:UIControlStateNormal];
    _okBtn.hidden = true;
    
    [self addSubview:self.addFollowBtn];
    [_addFollowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nickName);
        make.left.mas_equalTo(_nickName.mas_right).offset(22);
        make.size.mas_equalTo(CGSizeMake(76, 30));
    }];
    
    
    [_editBtn setTitle:@"查看更多资料" forState:UIControlStateNormal];
}

- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_cancelBtn setImage:kImage(@"TJMessage") forState:UIControlStateNormal];
    
    _cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(9);
        } else {
            make.top.mas_equalTo(29);
        }
        make.left.mas_equalTo(19);
        make.size.mas_equalTo(CGSizeMake(24, 26));
    }];
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBtn setImage:kImage(@"TJSetting") forState:UIControlStateNormal];
    _okBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:_okBtn];
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(9);
        } else {
            make.top.mas_equalTo(29);
        }
        make.trailing.mas_equalTo(-19);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    _headImage = [[UIImageView alloc] init];
    _headImage.layerCornerRadius = 32;
    [self addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(68);
        } else {
            make.top.mas_equalTo(88);
        }
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    _nickName = [[UILabel alloc] init];
    _nickName.text = @"Amy";
    _nickName.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    _nickName.textColor = [UIColor hx_colorWithHexString:@"#2E3041"];
    [self addSubview:_nickName];
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(68);
        } else {
            make.top.mas_equalTo(88);
        }
        make.left.mas_equalTo(24);
        make.width.mas_greaterThanOrEqualTo(34);
        make.height.mas_equalTo(34);
    }];
    
    
    _editBtn = [[UIButton alloc] init];
    _editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_editBtn setTitle:@"查看并编辑个人资料" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor hx_colorWithHexString:@"#2E3041"] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(111);
        } else {
            make.top.mas_equalTo(131);
        }
        make.left.mas_equalTo(23);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *followL = [[UILabel alloc] init];
    followL.text = @"关注";
    followL.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    followL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self addSubview:followL];
    [followL mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(172);
        } else {
            make.top.mas_equalTo(192);
        }
        make.left.mas_equalTo(33);
        make.size.mas_equalTo(CGSizeMake(25, 17));
    }];
    
    UILabel *followerL = [[UILabel alloc] init];
    followerL.text = @"粉丝";
    followerL.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    followerL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self addSubview:followerL];
    [followerL mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(172);
        } else {
            make.top.mas_equalTo(192);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(25, 17));
    }];
    
    UILabel *friendL = [[UILabel alloc] init];
    friendL.text = @"好友";
    friendL.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    friendL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self addSubview:friendL];
    [friendL mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(172);
        } else {
            make.top.mas_equalTo(192);
        }
        make.right.mas_equalTo(-29);
        make.size.mas_equalTo(CGSizeMake(25, 17));
    }];
    
    
    _followBtn = [[UIButton alloc] init];
    [_followBtn setTitle:@"0" forState:UIControlStateNormal];
    [_followBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];// 18 regular
    [self addSubview:_followBtn];
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(190);
        } else {
            make.top.mas_equalTo(210);
        }
        make.left.mas_equalTo(-31);
        make.size.mas_equalTo(CGSizeMake(148, 25));
    }];
    
    _followerBtn = [[UIButton alloc] init];
    [_followerBtn setTitle:@"0" forState:UIControlStateNormal];
    [_followerBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    _followerBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];// 18 regular
    [self addSubview:_followerBtn];
    [_followerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(190);
        } else {
            make.top.mas_equalTo(210);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(148, 25));
    }];
    
    _friendBtn = [[UIButton alloc] init];
    [_friendBtn setTitle:@"0" forState:UIControlStateNormal];
    [_friendBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    _friendBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];// 18 regular
    [self addSubview:_friendBtn];
    [_friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(190);
        } else {
            make.top.mas_equalTo(210);
        }
        make.right.mas_equalTo(33);
        make.size.mas_equalTo(CGSizeMake(148, 25));
    }];
    
    UILabel *partake = [[UILabel alloc] init];
    partake.tag = 1642;
    partake.font = [UIFont systemFontOfSize:15];
    partake.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    partake.text = @"实到 0/0 创建；实到 0/0 参与";
    [self addSubview:partake];
    [partake mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(247);
        } else {
            make.top.mas_equalTo(267);
        }
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.height.mas_equalTo(29);
    }];
}


- (void)updateWithDic:(NSDictionary *)dic {
    [_followerBtn setTitle:dic[@"follow_num"] forState:UIControlStateNormal];
    [_followerBtn setTitle:dic[@"fans_num"] forState:UIControlStateNormal];
    [_friendBtn setTitle:dic[@"friend_num"] forState:UIControlStateNormal];
    
    UILabel *partake = [self viewWithTag:1642];
    partake.text = [NSString stringWithFormat:@"实到 %@/%@ 创建；实到 %@/%@ 参与", dic[@"create_finish"], dic[@"create_num"], dic[@"join_finish"], dic[@"join_num"]];
}


- (UIButton *)addFollowBtn {
    if (!_addFollowBtn) {
        _addFollowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addFollowBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [_addFollowBtn setTitle:@"已关注" forState:UIControlStateSelected];
        _addFollowBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_addFollowBtn setBackgroundImage:kImage(@"TJButtonSelect") forState:UIControlStateNormal];
//        [_addFollowBtn setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
        _addFollowBtn.backgroundColor = kBtnEnable;
        [_addFollowBtn setAdjustsImageWhenHighlighted:false];
        _addFollowBtn.layerCornerRadius = 15;
    }
    return _addFollowBtn;
}

@end
