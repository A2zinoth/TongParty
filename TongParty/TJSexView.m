//
//  TJSexView.m
//  TongParty
//
//  Created by tojoin on 2018/4/22.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSexView.h"

@implementation TJSexView
- (void)createUI{
    _sex = @"2";

    self.backgroundColor = kWhiteColor;

    _maskView = [[UIView alloc] init];
    [self addSubview:_maskView];
    _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-167);
        } else {
            make.bottom.mas_equalTo(self).offset(-167);
        }
        make.top.mas_equalTo(self).offset(-800);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];

    // closeBtn
    UIButton *closeBtn = [UIButton new];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"TJCloseBtn"] forState:UIControlStateNormal];
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(8);
        make.left.mas_equalTo(self).offset(14);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    // ok
    UIButton *okButton = [UIButton new];
    [okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [okButton setImage:[UIImage imageNamed:@"TJOKBtn"] forState:UIControlStateNormal];
    okButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(8);
        make.trailing.mas_equalTo(self).offset(-14);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];

    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(47);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [boyBtn setTitle:@"男生" forState:UIControlStateNormal];
    [boyBtn setTitleColor:[UIColor hx_colorWithHexString:@"#758EA6"] forState:UIControlStateNormal];
    [boyBtn setTitleColor:kBtnEnable forState:UIControlStateSelected];
    boyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [boyBtn setBackgroundImage:kImage(@"TJBtnBGDisable") forState:UIControlStateNormal];
    [boyBtn setBackgroundImage:kImage(@"TJBtnBGEnable") forState:UIControlStateSelected];
    [boyBtn setAdjustsImageWhenHighlighted:NO];
    boyBtn.tag = 1803;
    [boyBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:boyBtn];
    [boyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(94);
        make.centerX.mas_equalTo(-12-29);
        make.size.mas_equalTo(CGSizeMake(58, 34));
    }];
    
    UIButton *girlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [girlBtn setTitle:@"女生" forState:UIControlStateNormal];
    [girlBtn setTitleColor:[UIColor hx_colorWithHexString:@"#758EA6"] forState:UIControlStateNormal];
    [girlBtn setTitleColor:kBtnEnable forState:UIControlStateSelected];
    girlBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [girlBtn setBackgroundImage:kImage(@"TJBtnBGDisable") forState:UIControlStateNormal];
    [girlBtn setBackgroundImage:kImage(@"TJBtnBGEnable") forState:UIControlStateSelected];
    [girlBtn setAdjustsImageWhenHighlighted:NO];
    girlBtn.tag = 1804;
    [girlBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:girlBtn];
    [girlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(94);
        make.centerX.mas_equalTo(12+29);
        make.size.mas_equalTo(CGSizeMake(58, 34));
    }];
    girlBtn.selected = true;
}

- (void)buttonAction:(UIButton *)btn {
    if (btn.tag == 1803) {
        btn.selected = true;
        _sex = @"1";
        
        UIButton *btn = [self viewWithTag:1804];
        btn.selected = false;
    } else if (btn.tag == 1804) {
        btn.selected = true;
        _sex = @"2";
        
        
        UIButton *btn = [self viewWithTag:1803];
        btn.selected = false;
    }
}


- (void)okAction {
    self.complete(_sex);
    [self removeFromSuperview];
}

- (void)closeAction {
    if (self.cancel) {
        self.cancel();
    }
    [self removeFromSuperview];
}

@end
