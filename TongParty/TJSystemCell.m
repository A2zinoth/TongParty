//
//  TJSystemCell.m
//  TongParty
//
//  Created by tojoin on 2018/5/2.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSystemCell.h"

@implementation TJSystemCell

- (void)createUI {
    _time = [[UILabel alloc] init];
    _time.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _time.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(48, 14));
    }];
    
    _backgroundImage = [[UIImageView alloc] init];
    _backgroundImage.image = kImage(@"TJSystemBoard");
    [self.contentView addSubview:_backgroundImage];
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(186);
    }];
    
    _titleImage = [[UIImageView alloc] init];
    _titleImage.image = kImage(@"TJSystemTitle");
    [self.contentView addSubview:_titleImage];
    [_titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(55);
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(100);
    }];
    
    _content = [[UILabel alloc] init];
    _content.text = @"桐聚好欢乐，大家都来一起玩耍吧～狼人杀真人PK， 好礼送不停～";
    _content.numberOfLines = 2;
    _content.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _content.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(170);
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
}

- (void)updateTime:(NSString *)time {
     _time.text = [NSString stringWithFormat:@"%@前", [self getTheCountOfTwoDaysWithBeginDate:time endDate:@""]];
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

@end
