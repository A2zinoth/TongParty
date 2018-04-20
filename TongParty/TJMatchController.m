//
//  TJMatchController.m
//  TongParty
//
//  Created by tojoin on 2018/4/19.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJMatchController.h"
#import "TJDeskViewController.h"

@interface TJMatchController ()

@end

@implementation TJMatchController
- (void)createUI {
    
    self.tid = _data[@"table_id"];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    [headImage sd_setImageWithURL:[NSURL URLWithString:_data[@"head_image"]]];
    headImage.layerCornerRadius = 34;
    if ([_data[@"sex"] isEqualToString:@"2"]) {
        headImage.layerBorderColor = kGirlNameColor;
    } else {
        headImage.layerBorderColor = kBoyNameColor;
    }
    headImage.layerBorderWidth = 1;
    [self.view addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(28);
        } else {
            make.top.mas_equalTo(self.view).offset(48);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(68, 68));
    }];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:kImage(@"TJMatchBackground")];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImage.mas_bottom);
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.height.mas_equalTo(288);
    }];
    

    UILabel *event = [[UILabel alloc] init];
    event.text = _data[@"activity_name"];
    event.textAlignment = NSTextAlignmentCenter;
    event.font = [UIFont systemFontOfSize:18];
    event.textColor = kBtnEnable;
    [self.view addSubview:event];
    [event mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(173);
        } else {
            make.top.mas_equalTo(193);
        }
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.height.mas_equalTo(26);
    }];
    
    NSArray *arr = @[[NSString stringWithFormat:@"开始时间：%@",[self deleteSecond:_data[@"begin_time"]]],
                     [NSString stringWithFormat:@"活动人数：%@人",_data[@"person_num"]],
                     [NSString stringWithFormat:@"人均消费：%@/人",_data[@"average_price"]],
                     [NSString stringWithFormat:@"活动地点：%@",_data[@"place"]]];
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"TJDeskInfo_%zd",i]]];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0, *)) {
                make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(211 + i * 32);
            } else {
                make.top.mas_equalTo(231 + i * 32);
            }
            make.left.mas_equalTo(53);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:arr[i]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:UIFontWeightLight] range:NSMakeRange(0, [arr[i] length])];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [arr[i] length])];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"#262626"] range:NSMakeRange(0, [arr[i] length])];
        
        UILabel *content = [[UILabel alloc] init];
        content.numberOfLines = 0;
        content.tag = 3738 +i;
        content.attributedText = attributedString;
        [self.view addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0, *)) {
                make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(211 + i * 32);
            } else {
                make.top.mas_equalTo(231 + i * 32);
            }
            make.left.mas_equalTo(82);
            make.right.mas_lessThanOrEqualTo(-50);
            make.height.mas_greaterThanOrEqualTo(19);
        }];
    }
    NSString *str = arr[0];
    str = [str substringFromIndex:5];
    UILabel *remaind = [[UILabel alloc] init];
    remaind.text = [NSString stringWithFormat:@"%zd天", [self getTheCountOfDate:str]];
    remaind.layerCornerRadius = 9;
    remaind.tag = 4748;
    remaind.font = [UIFont systemFontOfSize:10];
    remaind.textColor = kWhiteColor;
    remaind.textAlignment = NSTextAlignmentCenter;
    remaind.backgroundColor = [UIColor hx_colorWithHexString:@"#FFCD76"];
    [self.view addSubview:remaind];
    [remaind mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(211);
        } else {
            make.top.mas_equalTo(231);
        }
        make.left.mas_equalTo(268);
        make.size.mas_equalTo(CGSizeMake(50, 18));
    }];
    
    
    UILabel *content = [self.view viewWithTag:3738+3];
    UILabel *distance = [[UILabel alloc] init];
    distance.text = [NSString stringWithFormat:@"距离：%.2fKM",[_data[@"distance"] doubleValue]];
    distance.tag = 5753;
    distance.layerCornerRadius = 9;
    distance.font = [UIFont systemFontOfSize:10];
    distance.textColor = kWhiteColor;
    distance.textAlignment = NSTextAlignmentCenter;
    distance.backgroundColor = [UIColor hx_colorWithHexString:@"#FFCD76"];
    [self.view addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(content.mas_bottom);
        make.left.mas_equalTo(107);
        make.size.mas_equalTo(CGSizeMake(80, 18));
    }];
    
    UILabel *notice = [[UILabel alloc] init];
    notice.text = @"心跳桌匹配成功，赶紧去参加活动吧";
    notice.textAlignment = NSTextAlignmentCenter;
    notice.font = [UIFont systemFontOfSize:15];
    notice.textColor = [UIColor hx_colorWithHexString:@"#20B3F6"];
    [self.view addSubview:notice];
    [notice mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(410);
        } else {
            make.top.mas_equalTo(430);
        }
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.height.mas_equalTo(21);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [self.view addSubview:nextButton];
    [nextButton setTitle:@"查看活动" forState:UIControlStateNormal];
    [nextButton setBackgroundColor:kBtnEnable];
    [nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    nextButton.layer.cornerRadius = 20;
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(478);
        } else {
            make.top.mas_equalTo(498);
        }
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
    
    
    UILabel *attention = [[UILabel alloc] init];
    attention.numberOfLines = 0;
    attention.text = @"等您参加完活动，心跳桌\n才会再次开放哦～";
    attention.textAlignment = NSTextAlignmentCenter;
    attention.font = [UIFont systemFontOfSize:15];
    attention.textColor = [UIColor hx_colorWithHexString:@"#7B93AA"];
    [self.view addSubview:attention];
    [attention mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(534);
        } else {
            make.top.mas_equalTo(554);
        }
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)nextAction {
    TJDeskViewController *deskVC = [[TJDeskViewController alloc] init];
    deskVC.tid = self.tid;
    deskVC.flag = @"heartbeat";
    [self.navigationController pushViewController:deskVC animated:true];
}



- (NSString *)deleteSecond:(NSString *)str {
    NSArray *arr = [str componentsSeparatedByString:@":"];
    return [NSString stringWithFormat:@"%@:%@", arr[0], arr[1]];
}



//返回三天后的时间
- (NSString *)getAfterThreeDay {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:([components day]+3)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [[dateday stringFromDate:beginningOfWeek]stringByAppendingString:@" 16:00"];
}

-(NSInteger)getTheCountOfDate:(NSString *)endDate{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startD = [NSDate date];
    NSDate *endD = [inputFormatter dateFromString:endDate];
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startD toDate:endD options:0];
    if (dateCom.day == 0){
        NSDateComponents *comp1 = [calendar components:unit fromDate:startD];
        NSDateComponents *comp2 = [calendar components:unit fromDate:endD];
        if (comp1.day == comp2.day) {
            return 0;
        } else {
            return 1;
        }
    }
    return dateCom.day;
}
@end
