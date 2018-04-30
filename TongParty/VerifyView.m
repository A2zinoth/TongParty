//
//  VerifyView.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "VerifyView.h"

#define resendSec 60

@implementation VerifyView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    _closeBtn = [[UIButton alloc] init];
    [self addSubview:_closeBtn];
    [_closeBtn setImage:[UIImage imageNamed:@"TJBackBtn"] forState:UIControlStateNormal];
    _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];

//    _signupBtn = [[UIButton alloc] init];
//    [self addSubview:_signupBtn];
//    [_signupBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [_signupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_signupBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [_signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(31);
//        make.trailing.mas_equalTo(-22);
//        make.size.mas_equalTo(CGSizeMake(33, 22));
//    }];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"验证码";
    [self addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:29];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    noticeLabel.text = @"6位验证码";
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
    _resetBtn.text = [NSString stringWithFormat:@"重新发送 %d", resendSec];
    _resetBtn.textColor = kSeparateLine;
    _resetBtn.font = [UIFont systemFontOfSize:13];
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(278);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(74, 19));
    }];
    
    _i = resendSec;
    [self.timer fire];
    WeakSelf(weakSelf);
    _resetBtn.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        if (_i == -1) {
            weakSelf.i = resendSec;
            [weakSelf submit];
            [weakSelf.timer fire];
            weakSelf.resetBtn.textColor = kBtnDisable;
        }
    };
    
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(314);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(0.5);
    }];
    
    
//    UIButton *noreceiveBtn = [[UIButton alloc] init];
//    [self addSubview:noreceiveBtn];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"验证码没收到？"];
//    [attrStr addAttribute:NSForegroundColorAttributeName value:kBtnEnable range:NSMakeRange(0, 7)];
//    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 7)];
//    [noreceiveBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
//    [noreceiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(354);
//        make.left.mas_equalTo(24);
//        make.right.mas_equalTo(-24);
//        make.height.mas_equalTo(18);
//    }];
    
    _nextButton = [[UIButton alloc] init];
    [self addSubview:_nextButton];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:kBtnDisable];
    [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _nextButton.layer.cornerRadius = 20;
    _nextButton.enabled = false;
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(377);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
}

- (void)submit {
    _resend();
}

- (void)startCount {
    NSString *text = [@[@"重新发送 ", [NSString stringWithFormat:@"%zd",_i]] componentsJoinedByString:@""];
    
    if (!_i--)
    {
        _resetBtn.text = @"重新发送";
        _resetBtn.textColor = kBtnEnable;
        [_timer invalidate];
        _timer = nil;
    } else {
        _resetBtn.text = text;
    }
}

- (void)setPhone:(NSString *)phone {
    _phone = phone;
    _phoneNum.text = [NSString stringWithFormat:@"我们已发送验证码到 +86 %@", _phone];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCount) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
