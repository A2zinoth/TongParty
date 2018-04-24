//
//  TJProfileView.m
//  TongParty
//
//  Created by tojoin on 2018/4/20.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJProfileView.h"

@implementation TJProfileView

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
        make.size.mas_equalTo(CGSizeMake(24, 26));
    }];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.backgroundColor = kBtnEnable;
    headImage.layerCornerRadius = 32;
    headImage.layerBorderColor = kBoyNameColor;
    headImage.layerBorderWidth = 1;
    [self addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(48);
        } else {
            make.top.mas_equalTo(68);
        }
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    UILabel *nickName = [[UILabel alloc] init];
    nickName.text = @"Amy";
    nickName.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    nickName.textColor = [UIColor hx_colorWithHexString:@"#2E3041"];
    [self addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(48);
        } else {
            make.top.mas_equalTo(68);
        }
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(headImage.mas_left).offset(10);
        make.height.mas_equalTo(34);
    }];
    
    _editBtn = [[UIButton alloc] init];
    [_editBtn setTitle:@"查看并编辑个人资料" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor hx_colorWithHexString:@"#2E3041"] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(91);
        } else {
            make.top.mas_equalTo(111);
        }
        make.left.mas_equalTo(24);
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
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(152);
        } else {
            make.top.mas_equalTo(172);
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
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(152);
        } else {
            make.top.mas_equalTo(172);
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
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(152);
        } else {
            make.top.mas_equalTo(172);
        }
        make.right.mas_equalTo(-29);
        make.size.mas_equalTo(CGSizeMake(25, 17));
    }];
    
    
    UIButton *followBtn = [[UIButton alloc] init];
    [followBtn setTitle:@"341" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    followBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:followBtn];
    [followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(170);
        } else {
            make.top.mas_equalTo(190);
        }
        make.left.mas_equalTo(-31);
        make.size.mas_equalTo(CGSizeMake(148, 25));
    }];
    
    UIButton *followerBtn = [[UIButton alloc] init];
    [followerBtn setTitle:@"435" forState:UIControlStateNormal];
    [followerBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    followerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:followerBtn];
    [followerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(170);
        } else {
            make.top.mas_equalTo(190);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(148, 25));
    }];
    
    UIButton *friendBtn = [[UIButton alloc] init];
    [friendBtn setTitle:@"32" forState:UIControlStateNormal];
    [friendBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    friendBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:friendBtn];
    [friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(170);
        } else {
            make.top.mas_equalTo(190);
        }
        make.right.mas_equalTo(33);
        make.size.mas_equalTo(CGSizeMake(148, 25));
    }];
    
    UILabel *partake = [[UILabel alloc] init];
    partake.font = [UIFont systemFontOfSize:15];
    partake.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    partake.text = @"实到 2/5 创建；实到 3/6 参与";
    [self addSubview:partake];
    [partake mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(227);
        } else {
            make.top.mas_equalTo(247);
        }
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.height.mas_equalTo(29);
    }];
}

@end
