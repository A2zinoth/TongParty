//
//  TJDeskHistoryCell.m
//  TongParty
//
//  Created by tojoin on 2018/5/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskHistoryCell.h"

@implementation TJDeskHistoryCell

- (void)createUI {
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor hx_colorWithHexString:@"#EFF2F4"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(29);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    _circle = [[UILabel alloc] init];
    _circle.backgroundColor = [UIColor hx_colorWithHexString:@"#EFF2F4"];
    _circle.layerCornerRadius = 6;
    [self.contentView addSubview:_circle];
    [_circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(line);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    
    _time = [[UILabel alloc] init];
    _time.numberOfLines = 2;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"2018-03-10 14:00" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"#1D1D26"], NSKernAttributeName:@(2)}];
    _time.attributedText = attr;
    [self.contentView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(109, 50));
    }];
    
    _title = [[UILabel alloc] init];
    _title.text = @"大吉大利，今晚吃鸡";
    _title.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(188);
        make.right.mas_equalTo(-29);
        make.height.mas_equalTo(25);
    }];
    
    _past = [[UILabel alloc] init];
    _past.text = @"活动已结束10天";
    _past.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _past.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_past];
    [_past mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_title.mas_bottom);
        make.left.mas_equalTo(_title);
        make.right.mas_equalTo(-29);
        make.height.mas_equalTo(25);
    }];
}

- (void)updateCircleColor:(NSString *)hexColor {
    _circle.backgroundColor = [UIColor hx_colorWithHexString:hexColor];
}

- (void)updatePastTime:(NSString *)time serviceTime:(NSString *)serviceTime {
    _past.text = [NSString stringWithFormat:@"%@前", [self getTheCountOfTwoDaysWithBeginDate:time endDate:serviceTime]];
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
