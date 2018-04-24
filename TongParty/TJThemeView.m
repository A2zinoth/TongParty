//
//  TJThemeView.m
//  TongParty
//
//  Created by tojoin on 2018/4/11.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJThemeView.h"
#import "UIColor+Image.h"


@interface TJThemeView()

@property (nonatomic, strong) UIView    *maskView;
@property (nonatomic, copy)   NSString  *themeName;

@end

@implementation TJThemeView

- (void)createUI {
    self.backgroundColor = kWhiteColor;
    
    _maskView = [[UIView alloc] init];
    [self addSubview:_maskView];
    _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-449);
        } else {
            make.bottom.mas_equalTo(self).offset(-449);
        }
        make.top.mas_equalTo(self).offset(-330);
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
    
    UILabel *line = [[UILabel alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(47);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];

    UIView *line2 = [[UIView alloc] init];
    [self addSubview:line2];
    line2.backgroundColor = kSeparateLine;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(47);
        make.left.mas_equalTo(99);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(0.5);
    }];
    

    for (NSInteger i = 0; i < 6; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 1318+i;
        button.hidden = true;
        
        [button setTitleColor:kBtnEnable forState:UIControlStateNormal];
        [button setTitleColor:kBtnEnable forState:UIControlStateSelected];
        
        [button setBackgroundImage:[UIImage imageNamed:@"TJButtonBackgroundImage"] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(47+i*63);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 63));
        }];
        if (i == 2) {
            button.selected = true;
        }
    }
    
    CGFloat space = 126;
    if (IS_IPHONE_5) {
        space =  86;
    }
    
    for (NSInteger i = 0; i < 16; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 2343+i;
        button.hidden = true;
        
        [button setAdjustsImageWhenHighlighted:NO];
        
        [button setBackgroundImage:[UIImage imageNamed:@"TJButtonNormal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"TJButtonSelect"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"TJButtonSelect"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"TJButtonNormal"] forState:UIControlStateDisabled];
        
        [button setTitleColor:[UIColor hx_colorWithHexString:@"#859CB0"] forState:UIControlStateNormal];
        [button setTitleColor:kWhiteColor forState:UIControlStateSelected];
        [button setTitleColor:kWhiteColor forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor hx_colorWithHexString:@"#859CB0"] forState:UIControlStateDisabled];
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [button addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(69 + i/2 * 48);
            make.left.mas_offset(146 + i%2 * space);
            make.size.mas_equalTo(CGSizeMake(72, 24));
        }];
        if (i == 0) {
            button.selected = true;
        }
    }
}

- (NSInteger)getKind {
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [self viewWithTag:1318+i];
        if (btn.selected) {
            return i;
        }
    }
    return 0;
}

- (NSString *)getSelectTheme {
    for (int i = 0; i < 5; i++) {
        UIButton *otherBtn = [self viewWithTag:2343+i];
        if(otherBtn.selected == true) {
            //aid string
            TJThemeModel *model = _themeModelArr[[self getKind]];
            TJThemeModel *submodel = model.child[i];
            _themeName = submodel.activity_name;
            return submodel.activity_id;
        }
    }
    return @"1";
}


- (void)rightButtonAction:(UIButton *)btn {
    NSInteger index = btn.tag - 2343;
    for (int i = 0; i < 5; i++) {
        if (i == index) {
            btn.selected = true;
        } else {
            UIButton *otherBtn = [self viewWithTag:2343+i];
            otherBtn.selected = false;
        }
    }
}

- (void)buttonAction:(UIButton *)btn {
    NSInteger index = btn.tag-1318;
    for (int i = 0; i < 6; i++) {
        if (i == index) {
            btn.selected = true;
            // 更新右面
            [self updateRightBtn:i];
        } else {
            UIButton *otherBtn = [self viewWithTag:1318+i];
            otherBtn.selected = false;
        }
    }
}

- (void)updateRightBtn:(NSInteger )index {
    TJThemeModel *model = self.themeModelArr[index];
    NSArray *submode = model.child;
    for (int j = 0; j < 16; j++) {
        UIButton *rightBtn = [self viewWithTag:2343+j];
        rightBtn.hidden = false;
        if (j == 0) {
            rightBtn.selected = true;
        } else {
            rightBtn.selected = false;
        }
        if (j < submode.count) {
            TJThemeModel *model = submode[j];
            [rightBtn setTitle:model.activity_name forState:UIControlStateNormal];
            [rightBtn setTitle:model.activity_name forState:UIControlStateSelected];
            [rightBtn setTitle:model.activity_name forState:UIControlStateHighlighted];
            [rightBtn setTitle:model.activity_name forState:UIControlStateDisabled];
        } else {
            rightBtn.hidden = true;
        }
    }
}

- (void)updateData:(NSArray *)arr {
    self.themeModelArr = arr;
    
    for (int i = 0; i < 6; i++) {
        UIButton *otherBtn = [self viewWithTag:1318+i];
        if (i == 2) {
            otherBtn.selected = true;
        } else {
            otherBtn.selected = false;
        }
        if (i<arr.count) {
            otherBtn.hidden = false;
            TJThemeModel *model = arr[i];
            [otherBtn setTitle:model.activity_name forState:UIControlStateNormal];
            [self updateRightBtn:2];
        } else {
            otherBtn.hidden = true;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == nil) {
        return _maskView;
    }
    return hitView;
}



- (void)okAction {
    
    self.complete([self getSelectTheme]);
    self.themeNameBlock(self.themeName);
    [self removeFromSuperview];
}

- (void)closeAction {
    [self removeFromSuperview];
}


@end
