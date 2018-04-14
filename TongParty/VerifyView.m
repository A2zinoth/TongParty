//
//  VerifyView.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "VerifyView.h"


@implementation VerifyView


- (instancetype)init {
    self = [super init];
    if (self) {
        //        self.backgroundColor = [UIColor redColor];
        [self createView];
    }
    return self;
}

- (void)createView {
    _closeBtn = [[UIButton alloc] init];
    [self addSubview:_closeBtn];
    [_closeBtn setImage:[UIImage imageNamed:@"love_close"] forState:UIControlStateNormal];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];

    _signupBtn = [[UIButton alloc] init];
    [self addSubview:_signupBtn];
    [_signupBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_signupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_signupBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(31);
        make.trailing.mas_equalTo(-22);
        make.size.mas_equalTo(CGSizeMake(33, 22));
    }];

    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"验证码";
    titleLabel.font = [UIFont systemFontOfSize:29];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(87);
        make.left.mas_equalTo(22);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];

    _phoneNum = [[UILabel alloc] init];
    [self addSubview:_phoneNum];
    _phoneNum.text = @"我们已发送验证码到 +86";
    _phoneNum.font = [UIFont systemFontOfSize:18];
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(143);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(27);
    }];
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    [self addSubview:noticeLabel];
    noticeLabel.text = @"4位验证码";
    noticeLabel.font = [UIFont systemFontOfSize:13];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(240);
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    
    _codeTF = [[UITextField alloc] init];
    [self addSubview:_codeTF];
    _codeTF.font = [UIFont systemFontOfSize:30];
    _codeTF.keyboardType = UIKeyboardTypePhonePad;
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(272);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(24);
        make.height.mas_equalTo(30);
    }];
    
    _resetBtn = [[YYLabel alloc] init];
    [self addSubview:_resetBtn];
    _resetBtn.text = @"重新发送 43";
    _resetBtn.textColor = [UIColor hx_colorWithHexString:@"#D8D8D8"];
    _resetBtn.font = [UIFont systemFontOfSize:13];
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(278);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(74, 19));
    }];
    
    _i = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCount) userInfo:nil repeats:YES];
    WeakSelf(weakSelf);
    _resetBtn.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        if (_i == -1) {
            weakSelf.resetBtn.textColor = kBtnDisable;
            _i = 60;
            [weakSelf startCount];
            [weakSelf submit];
        }
    };
    
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = [UIColor hx_colorWithHexString:@"#D8D8D8"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(314);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(1);
    }];
    
    
    UIButton *noreceiveBtn = [[UIButton alloc] init];
    [self addSubview:noreceiveBtn];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"验证码没收到？"];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:86/255.f green:126/255.f blue:247/255.f alpha:1] range:NSMakeRange(0, 7)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 7)];
    [noreceiveBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    [noreceiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(354);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(18);
    }];
    
    [self startCount];
}



- (void)submit {
    _resend();
}

- (void)startCount
{
    NSString *text = [@[@"重新发送", [NSString stringWithFormat:@"%zd",_i]] componentsJoinedByString:@""];
    
    if (!_i--)
    {
        _resetBtn.text = @"重新发送";
        _resetBtn.textColor = kBtnEnable;
        [_timer invalidate];
    } else {
        
        _resetBtn.text = text;
    }
}

- (void)setPhone:(NSString *)phone {
    _phone = phone;
    _phoneNum.text = [NSString stringWithFormat:@"我们已发送验证码到 +86 %@", _phone];
}

@end
