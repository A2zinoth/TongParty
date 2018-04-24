//
//  TJAverage.m
//  TongParty
//
//  Created by tojoin on 2018/4/12.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJAverage.h"

@implementation TJAverage

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
    
    
    _peopleNum = [[UILabel alloc] initWithFrame:CGRectMake(24, 69, 200, 26)];
    [self addSubview:_peopleNum];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"¥200/人（每人消费）"];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"#758EA6"] range:NSMakeRange(6, 6)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(6, 6)];
    _peopleNum.attributedText = attrStr;
    
    
    _slider = [[TJSlider alloc] init];
    [self addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(2);
    }];
    _slider.minimumValue = 100;// 设置最小值
    _slider.maximumValue = 2000;// 设置最大值
    _slider.value = 200;
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"slider_select"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    
    [_slider setThumbImage:[UIImage imageNamed:@"TJSliderBtn"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"TJSliderBtn"] forState:UIControlStateHighlighted];
}

- (void)sliderValueChanged:(UISlider *)slider {
    NSLog(@"%f", slider.value);
    [self setNum:[NSString stringWithFormat:@"%.0f", slider.value]];
}

- (void)setNum:(NSString *)num {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@/人（每人消费）",num]];
    if ([num intValue]<1000) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"#758EA6"] range:NSMakeRange(6, 6)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(6, 6)];
    } else {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"#758EA6"] range:NSMakeRange(6, 6)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(7, 6)];
    }
    _peopleNum.attributedText = attrStr;
    
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
    if (self.cancel) {
        self.cancel();
    }
    [self removeFromSuperview];
}


@end
