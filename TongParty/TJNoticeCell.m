//
//  TJNoticeCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJNoticeCell.h"

@implementation TJNoticeCell

- (void)createUI {
    
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(54, 54));
    }];
    
    _badge = [[UILabel alloc] init];
    _badge.backgroundColor = [UIColor hx_colorWithHexString:@"#DE1426"];
    //圆角为宽度的一半
    _badge.layer.cornerRadius = 5.5;
    //确保可以有圆角
    self.badge.layer.masksToBounds = YES;
    [self.contentView addSubview:_badge];
    [_badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.left.mas_equalTo(64);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _titleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(94);
        make.top.mas_equalTo(17);
        make.width.mas_greaterThanOrEqualTo(30);
        make.height.mas_equalTo(21);
    }];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _contentL.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(94);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(177, 18));
    }];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _timeL.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_timeL];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(94);
        make.top.mas_equalTo(79);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    
    _accessoryImage = [[UIImageView alloc] initWithImage:kImage(@"TJMoreBtn")];
    [self.contentView addSubview:_accessoryImage];
    [_accessoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    
    // 桌主 or 参与
    _status = [[UILabel alloc] init];
    _status.layerCornerRadius = 8.5;
    _status.font = [UIFont systemFontOfSize:10];
    _status.textColor = kWhiteColor;
    _status.textAlignment = NSTextAlignmentCenter;
    _status.backgroundColor = [UIColor hx_colorWithHexString:@"#7ECCB5"];
    [self.contentView addSubview:_status];
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleL);
        make.left.mas_equalTo(_titleL.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(35, 17));
    }];
    
    
    _remaindL = [[UILabel alloc] init];
    _remaindL.text = @"3天后开始";
    _remaindL.textColor = [UIColor hx_colorWithHexString:@"#FFCD76"];
    _remaindL.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    [self.contentView addSubview:_remaindL];
    [_remaindL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleL);
        make.right.mas_equalTo(-24);
        make.width.mas_greaterThanOrEqualTo(30);
        make.height.mas_equalTo(14);
    }];
    
    self.separatorInset = UIEdgeInsetsMake(0, 24, 0, 0);
}


- (void)updateSystemControl {
    _badge.hidden = true;
    _status.hidden = true;
    _remaindL.hidden = true;
    _accessoryImage.hidden = false;
}

- (void)updateCustomControl {
    _badge.hidden = true;
    _status.hidden = false;
    _remaindL.hidden = false;
    _accessoryImage.hidden = true;
}

- (void)updateSystemControl:(NSDictionary *)dic index:(NSInteger)index {
    
}

- (void)updateRemainL:(NSString *)time {
    _remaindL.text = [NSString stringWithFormat:@"%@后开始", [self getTheCountOfTwoDaysWithBeginDate:@"" endDate:time]];
}

- (void)updateTime:(NSString *)time {
    _timeL.text = [NSString stringWithFormat:@"%@前", [self getTheCountOfTwoDaysWithBeginDate:time endDate:@""]];
}



- (NSString *)getTheCountOfTwoDaysWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD;
    if ([beginDate isEqualToString:@""]) {
        startD = [NSDate date];
    } else {
        startD = [inputFormatter dateFromString:beginDate];
    }
    NSDate *endD;
    if ([endDate isEqualToString:@""]) {
        endD = [NSDate date];
    } else {
        endD = [inputFormatter dateFromString:endDate];
    }
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startD toDate:endD options:0];
    if (dateCom.day == 0){
        if (dateCom.hour == 0) {
            if (dateCom.minute == 0) {
                return @"即将开始";
            } else {
                return [NSString stringWithFormat:@"%zd分钟", dateCom.minute];
            }
        } else {
            return [NSString stringWithFormat:@"%zd小时", dateCom.hour];
        }
    } else {
        return [NSString stringWithFormat:@"%zd天", dateCom.day];
    }
    return @"--";
}

- (void)updateApplyNotice {
    _badge.hidden = true;
    _status.hidden = true;
    _remaindL.hidden = true;
    _accessoryImage.hidden = false;
    
    _titleL.text = @"丽萨";
}

@end
