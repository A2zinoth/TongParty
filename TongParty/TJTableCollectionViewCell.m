
//
//  TJTableCollectionViewCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJTableCollectionViewCell.h"


@implementation TJTableCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
    }
    return self;
}


- (void)createUI {
    
    UIImageView *boardIV = [[UIImageView alloc] init];
    boardIV.image = kImage(@"TJTableBoard");
    [self.contentView addSubview:boardIV];
    [boardIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    _headImage = [[UIImageView alloc] init];
    _headImage.backgroundColor = kWhiteColor;
    _headImage.layerCornerRadius = 32.5;
    [self.contentView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    _beginImage = [[UIImageView alloc] init];
    _beginImage.image = kImage(@"TJTableBegin");
    [self.contentView addSubview:_beginImage];
    [_beginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(95);
        make.top.mas_equalTo(1);
    }];
     
     
    _status = [[UILabel alloc] init];
    _status.text = @"我是桌主";
    _status.layerCornerRadius = 8.5;
    _status.font = [UIFont systemFontOfSize:10];
    _status.textColor = kWhiteColor;
    _status.textAlignment = NSTextAlignmentCenter;
    _status.backgroundColor = [UIColor hx_colorWithHexString:@"#7ECCB5"];
    [self.contentView addSubview:_status];
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(73);
        make.left.mas_equalTo(79);
        make.size.mas_equalTo(CGSizeMake(54, 17));
    }];
    
    _titleL = [[UILabel alloc] init];
    _titleL.text = @"狼人杀";
    _titleL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _titleL.font = [UIFont systemFontOfSize:16];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(94);
        make.centerX.mas_equalTo(0);
        make.width.mas_greaterThanOrEqualTo(30);
        make.height.mas_equalTo(22);
    }];
    
    _timeL = [[UILabel alloc] init];
    _timeL.text = @"20 分钟后开始";
    _timeL.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _timeL.font = [UIFont systemFontOfSize:10];
    _timeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeL];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(115);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(146, 14));
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kWhiteColor;
        imageView.image = kImage(@"TJDeskInfoDefault");
        imageView.layerBorderWidth = 1;
        imageView.layerBorderColor = kWhiteColor;
        imageView.layerCornerRadius = 14;
        imageView.tag = 1610 + i;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(140);
            make.left.mas_equalTo(42+i*24);
            make.size.mas_equalTo(CGSizeMake(28, 28));
        }];
    }

}

- (void)updateTime:(NSString *)beginTime serviceTime:(NSString*)serviceTime {
    _timeL.text = [NSString stringWithFormat:@"%@后开始",[self getTheCountOfTwoDaysWithBeginDate:serviceTime endDate:beginTime]];
}

- (NSString *)getTheCountOfTwoDaysWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[inputFormatter dateFromString:beginDate];
    NSDate *endD = [inputFormatter dateFromString:endDate];
    
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

- (void)updateMaster:(NSString *)bMaster {
    if ([bMaster isEqualToString:@"1"]) {
        _status.hidden = false;
    } else
        _status.hidden = true;
    
}

- (void)showBeginImage:(BOOL)b {
    if (b) {
        _beginImage.hidden = false;
    } else {
        _beginImage.hidden = true;
    }
}

- (void)updateMember:(NSArray *)arr {
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *iv = [self.contentView viewWithTag:1610+i];
        if (i < arr.count) {
            [iv yy_setImageWithURL:[NSURL URLWithString:arr[i][@"head_image"]] options:0];
//            [iv sd_setImageWithURL:[NSURL URLWithString:arr[i][@"head_image"]] placeholderImage:[UIImage new] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                
//            }];
//            [iv sd_setImageWithURL:[NSURL URLWithString:arr[i][@"head_image"]]];
        } else {
            iv.image = kImage(@"TJDeskInfoDefault");
        }
    }
}


@end
