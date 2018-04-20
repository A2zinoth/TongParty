//
//  TJDistanceView.m
//  TongParty
//
//  Created by tojoin on 2018/4/19.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDistanceView.h"

@implementation TJDistanceView

- (void)createUI {
    
    
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
    
    
    _peopleNum = [[UILabel alloc] init];
    _peopleNum.font = [UIFont systemFontOfSize:18];
    _peopleNum.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _peopleNum.text = @"15KM";
    [self addSubview:_peopleNum];
    [_peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(69);
        make.left.mas_equalTo(24);
        make.height.mas_equalTo(26);
        make.width.mas_greaterThanOrEqualTo(50);
    }];
    
    UILabel *unit = [[UILabel alloc] init];
    unit.text = @"(范围距离)";
    unit.font = [UIFont systemFontOfSize:12];
    unit.textColor = [UIColor hx_colorWithHexString:@"#92A7B9"];
    [self addSubview:unit];
    [unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_peopleNum).offset(-3);
        make.left.mas_equalTo(84);
        make.size.mas_equalTo(CGSizeMake(60, 18));
    }];
    
    
    _slider = [[TJSlider alloc] init];
    [self addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(2);
    }];
    _slider.minimumValue = 1;// 设置最小值
    _slider.maximumValue = 150;// 设置最大值
    _slider.value = 15;
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"slider_select"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    
    [_slider setThumbImage:[UIImage imageNamed:@"TJSliderBtn"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"TJSliderBtn"] forState:UIControlStateHighlighted];
}

- (void)sliderValueChanged:(UISlider *)slider {
    [self setNum:[NSString stringWithFormat:@"%.0f", slider.value]];
}

- (void)setNum:(NSString *)num {
    _peopleNum.text = [NSString stringWithFormat:@"%@KM", num];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == nil) {
        return _maskView;
    }
    return hitView;
}

- (void)okAction {
    self.complete([NSString stringWithFormat:@"%.0f",_slider.value]);
    [self removeFromSuperview];
}

- (void)closeAction {
    [self removeFromSuperview];
}

@end
