//
//  TJHeartbeatView.m
//  TongParty
//
//  Created by tojoin on 2018/4/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHeartbeatView.h"
#import "TJAnimation.h"

@implementation TJHeartbeatView


- (void)createUI {
    UIImageView *background = [[UIImageView alloc] initWithImage:kImage(@"TJHeartbetaBackground")];
    [self addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(k5(502+kStatusBarHeight));
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"心跳桌";
    title.font = [UIFont systemFontOfSize:13];
    title.textColor = kWhiteColor;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(13);
        } else {
            make.top.mas_equalTo(self).offset(33);
        }
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(41, 19));
    }];
    
    UILabel *availableNum = [[UILabel alloc] init];
    availableNum.text = @"当前空缺桌位5686";
    availableNum.font = [UIFont systemFontOfSize:24];
    availableNum.textColor = kWhiteColor;
    availableNum.textAlignment = NSTextAlignmentCenter;
    [self addSubview:availableNum];
    [availableNum mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(k5(67));
        } else {
            make.top.mas_equalTo(self).offset(k5(87));
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 34));
    }];

    [self.layer addSublayer:[TJAnimation replicatorLayer_Circle]];
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.backgroundColor = kWhiteColor;
    [_startBtn setTitle:@"匹配中" forState:UIControlStateSelected];
    [_startBtn setTitleColor:[UIColor hx_colorWithHexString:@"#70A8FC"] forState:UIControlStateSelected];
    _startBtn.layerCornerRadius = 58;
    [self addSubview:_startBtn];
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(k5(171));
        } else {
            make.top.mas_equalTo(self).offset(k5(191));
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(119, 119));
    }];

    
    UIImageView *startIV = [[UIImageView alloc] initWithImage:kImage(@"TJMatch")];
    startIV.tag = 1916;
    [self addSubview:startIV];
    [startIV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(k5(200));
        } else {
            make.top.mas_equalTo(self).offset(k5(220));
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 38));
    }];
    
    UILabel *startL = [[UILabel alloc] init];
    startL.text = @"极速匹配";
    startL.tag = 1917;
    startL.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    startL.textColor = [UIColor hx_colorWithHexString:@"#70A8FC"];
    startL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:startL];
    [startL mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(k5(245));
        } else {
            make.top.mas_equalTo(self).offset(k5(265));
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(58, 18));
    }];
    
    UILabel *notice = [[UILabel alloc] init];
    notice.numberOfLines = 0;
    notice.tag = 2211;
    notice.text = @"心跳桌会直接帮您匹配空闲桌位，\n一旦匹配成功，将无法退出桌位。";
    notice.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
    notice.textAlignment = NSTextAlignmentCenter;
    notice.textColor = kWhiteColor;
    [self addSubview:notice];
    [notice mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(k5(354));
        } else {
            make.top.mas_equalTo(self).offset(k5(374));
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 37));
    }];
    
    UIImageView *filterBackground = [[UIImageView alloc] initWithImage:kImage(@"TJFilterBackground")];
    filterBackground.userInteractionEnabled = true;
    filterBackground.tag  =  1912;
    [self addSubview:filterBackground];
    [filterBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(k5(414));
        } else {
            make.top.mas_equalTo(self).offset(k5(434));
        }
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(k5(327));
        make.height.mas_equalTo(k5(160.0));
    }];
    
    NSString *str = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]/3600];
    NSString *beginTime = [NSDate timestampSwitchTime:[str integerValue]*3600 andFormatter:@"YYYY/MM/dd HH:mm"];
    
   NSArray *arr = @[@{@"title":@"狼人杀",@"pic":@"TJCreteDesk_1"},
                    @{@"title":@"15KM",@"pic":@"TJCreteDesk_3"},
                    @{@"title":beginTime,@"pic":@"TJCreteDesk_2"},
                    @{@"title":@"￥200/人",@"pic":@"TJCreteDesk_5"},
                    ];
    for (NSInteger i = 0; i < arr.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 1156+i;
        [button setTitle:arr[i][@"title"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hx_colorWithHexString:@"#2E3041"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:k5(15)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setImage:kImage(arr[i][@"pic"]) forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -k5(10), 0, 0);
        [button addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
        [filterBackground addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(35+i/2*48);
            make.left.mas_equalTo(k5(42)+i%2*163);
            make.size.mas_equalTo(CGSizeMake(k5(170), k5(22)));
        }];
    }
    
    UILabel *filterNotice = [[UILabel alloc] init];
    filterNotice.text = @"请点击选项进行筛选";
    filterNotice.textColor = [UIColor hx_colorWithHexString:@"#758EA6"];
    filterNotice.font = [UIFont systemFontOfSize:11];
    filterNotice.textAlignment = NSTextAlignmentCenter;
    [filterBackground addSubview:filterNotice];
    [filterNotice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k5(126));
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(17);
    }];
    

}

- (void)filterAction:(UIButton *)btn {
    if (_buttonBlick) {
        _buttonBlick(btn.tag);
    }
}

@end
