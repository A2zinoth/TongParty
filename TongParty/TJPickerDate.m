//
//  TJPickerDate.m
//  TongParty
//
//  Created by tojoin on 2018/4/22.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPickerDate.h"

@implementation TJPickerDate
- (void)createUI {
    self.backgroundColor = kWhiteColor;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _currentDate = [formatter stringFromDate:[NSDate date]];
    
    _maskView = [[UIView alloc] init];
    [self addSubview:_maskView];
    _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-275);
        } else {
            make.bottom.mas_equalTo(self).offset(-275);
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
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
    [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [_datePicker setCalendar:[NSCalendar currentCalendar]];
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(42);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

- (void)datePickerChange:(UIDatePicker *)picker {
    NSDate *currentDate = picker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _currentDate = [formatter stringFromDate:currentDate];
    NSLog(@"%@", _currentDate);
}

- (void)okAction {
    NSLog(@"ok:%@",_currentDate);
    if (self.complete) {
        self.complete(_currentDate);
    }
    [self removeFromSuperview];
}

- (void)closeAction {
    if (self.cancel) {
        self.cancel();
    }
    [self removeFromSuperview];
}

@end
