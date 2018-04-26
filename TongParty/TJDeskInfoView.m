//
//  TJDeskInfoView.m
//  TongParty
//
//  Created by tojoin on 2018/4/16.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskInfoView.h"
#import "TJDeskInfoModel.h"

@implementation TJDeskInfoView

- (void)createUI {
    NSLog(@"createui");
    float left = kScreenWidth-10-50;
    
    for (int i = 0; i < 12; i++) {
        NSInteger random = arc4random()%2;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJDeskInfoDefault"]];
        imageView.tag = i+ 1722;
        imageView.layerCornerRadius = 25;
        imageView.layerBorderColor = random? kBoyNameColor: kGirlNameColor;
        imageView.layerBorderWidth = 2;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(73+i/2*72);
            if (i%2) {
                make.left.mas_equalTo(left);
            } else {
                make.left.mas_equalTo(10);
            }
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        YYLabel *nickname = [[YYLabel alloc] init];
        nickname.text = @"空位";
        nickname.tag = 1925+i;
        [self addSubview:nickname];
        nickname.textAlignment = NSTextAlignmentCenter;
        nickname.font = [UIFont systemFontOfSize:10];
        nickname.textColor = random? kBoyNameColor: kGirlNameColor;
        [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(125+i/2*73);
            if (i%2) {
                make.left.mas_equalTo(left);
            } else {
                make.left.mas_equalTo(10);
            }
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
    }
    
    UILabel *master = [[UILabel alloc] init];
    master.text = @"桌主";
    master.layerCornerRadius = 9;
    master.font = [UIFont systemFontOfSize:10];
    master.textColor = kWhiteColor;
    master.textAlignment = NSTextAlignmentCenter;
    master.backgroundColor = [UIColor hx_colorWithHexString:@"#7ECCB5"];
    [self addSubview:master];
    [master mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(59);
        make.left.mas_equalTo(34);
        make.size.mas_equalTo(CGSizeMake(36, 18));
    }];
    
    UIImageView *backgroundIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJDeskInfoBackground"]];
    [self addSubview:backgroundIV];
    [backgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(59);
        make.left.mas_equalTo(74);
        make.width.mas_equalTo(kScreenWidth-74-72);
        make.height.mas_equalTo(358);
    }];
    
    float width = (kScreenWidth-72*2);
    UILabel *event = [[UILabel alloc] init];
    event.tag = 1836;
    event.text = @"打麻将，三缺一啊";
    event.textAlignment = NSTextAlignmentCenter;
    event.font = [UIFont systemFontOfSize:18];
    event.textColor = kBtnEnable;
    [self addSubview:event];
    [event mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(81);
        make.left.mas_equalTo(72);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(19);
    }];
    
    UILabel *aid = [[UILabel alloc] init];
    aid.text = @"桌子ID：111743";
    aid.tag = 2737;
    aid.textAlignment = NSTextAlignmentCenter;
    aid.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
    aid.textColor = kBtnEnable;
    [self addSubview:aid];
    [aid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(110);
        make.left.mas_equalTo(72);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(11);
    }];
    
    
    width = kScreenWidth - 80 -107;
    NSArray *arr = @[[NSString stringWithFormat:@"开始时间：%@",[self getAfterThreeDay]], @"活动人数：12人", @"人均消费：300/人", @"活动地点：北京市朝阳区望京 SOHOT1"];
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"TJDeskInfo_%zd",i]]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(152 + i * 47);
            make.left.mas_equalTo(84);
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
//        content.font = [UIFont systemFontOfSize:13];
//        content.textColor = [UIColor hx_colorWithHexString:@"#262626"];
        [self addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(153 + i *47);
            make.left.mas_equalTo(106);
            make.width.mas_equalTo(width);
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
    [self addSubview:remaind];
    [remaind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(169);
        make.left.mas_equalTo(107);
        make.size.mas_equalTo(CGSizeMake(50, 18));
    }];
    
    
    UILabel *content = [self viewWithTag:3738+3];
    UILabel *distance = [[UILabel alloc] init];
    distance.text = @"距离：500KM";
    distance.tag = 5753;
    distance.layerCornerRadius = 9;
    distance.font = [UIFont systemFontOfSize:10];
    distance.textColor = kWhiteColor;
    distance.textAlignment = NSTextAlignmentCenter;
    distance.backgroundColor = [UIColor hx_colorWithHexString:@"#FFCD76"];
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(content.mas_bottom);
        make.left.mas_equalTo(107);
        make.size.mas_equalTo(CGSizeMake(80, 18));
    }];
    
    
    _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _contactBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [_contactBtn setTitle:@"联系桌主" forState:UIControlStateNormal];
    _contactBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_contactBtn setTitleColor:[UIColor hx_colorWithHexString:@"#BDC9D4"] forState:UIControlStateNormal];
    [_contactBtn setImage:[UIImage imageNamed:@"TJDeskContact_disable"] forState:UIControlStateNormal];
    [self addSubview:_contactBtn];
    [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(380);
        make.left.mas_equalTo(self).offset(kScreenWidth/2-34);
        make.size.mas_equalTo(CGSizeMake(68, 18));
    }];
    
    _nextButton = [[UIButton alloc] init];
    [self addSubview:_nextButton];
    [_nextButton setTitle:@"加入桌子" forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:kBtnEnable];
    [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _nextButton.layer.cornerRadius = 20;
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(448);
        make.left.mas_equalTo(kScreenWidth/2-93);
        make.width.mas_equalTo(186);
        make.height.mas_equalTo(40);
    }];
}

- (void)selectHeaderImage:(UIGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView *)sender.view;
    NSLog(@"%zd", imageView.tag);
    if (_memberSelected) {
        _memberSelected(imageView.tag-1722);
    }
}

- (void)updateWithModel:(TJDeskInfoModel *)model {
    NSArray *members = model.member;
    for (NSInteger i = 0; i < 12; i++) {
        UIImageView *iv = [self viewWithTag:i+1722];
        YYLabel *label = [self viewWithTag:i+1925];
        
        if(i < members.count) {
            if (i == 0) {
                [DDUserDefault setObject:members[i][@"head_image"] forKey:@"masterHeadImage"];
            }
            iv.userInteractionEnabled = true;
            [iv sd_setImageWithURL:[NSURL URLWithString:members[i][@"head_image"]]];
            label.text = members[i][@"nickname"];
            if ([members[i][@"sex"] isEqualToString:@"2"]) {
                iv.layerBorderColor = kGirlNameColor;
                label.textColor = kGirlNameColor;
            } else {
                iv.layerBorderColor = kBoyNameColor;
                label.textColor = kBoyNameColor;
            }
        } else {
            iv.image = [UIImage imageNamed:@"TJDeskInfoDefault"];
            iv.userInteractionEnabled = false;
            iv.layerBorderColor = [UIColor clearColor];
            label.text = @"空位";
            label.textColor = [UIColor hx_colorWithHexString:@"#C6D0DA"];
            
        }
        
        
    }
    UILabel *event = [self viewWithTag:1836];
    event.text = model.title;
    
    UILabel *aid = [self viewWithTag:2737];
    aid.text = [NSString stringWithFormat:@"桌子ID：%@",model.aid];
    
    NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"开始时间：%@",[self deleteSecond:model.begin_time]],[NSString stringWithFormat:@"活动人数：%@人", model.person_num], [NSString stringWithFormat:@"人均消费：%@/人", model.average_price],[NSString stringWithFormat:@"活动地点：%@", model.place], nil];
    for (NSInteger i = 0; i < 4; i++) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:arr[i]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:UIFontWeightLight] range:NSMakeRange(0, [arr[i] length])];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [arr[i] length])];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexString:@"#262626"] range:NSMakeRange(0, [arr[i] length])];
        
        UILabel *content = [self viewWithTag:3738+i];
        content.attributedText = attributedString;
    }
   
    UILabel *remaind = [self viewWithTag:4748];
    NSTimeInterval timeinterval = [self getTheCountOfTwoDaysWithBeginDate:@"" endDate:model.begin_time];
    if (timeinterval > 3) {
        remaind.hidden = true;
    } else {
        remaind.hidden = false;
        remaind.text = [NSString stringWithFormat:@"%zd天", [self getTheCountOfTwoDaysWithBeginDate:@"" endDate:model.begin_time]];
    }
    
    UILabel *distance = [self viewWithTag:5753];
    distance.text = [NSString stringWithFormat:@"距离%.2fKM", model.distance.doubleValue];
    
    
    NSDictionary *dic = model.my;
    if ([dic[@"is_master"] isEqualToString:@"1"]) {
        _nextButton.tag = 1215;
        _contactBtn.hidden = true;
        [DDUserDefault setObject:@"1" forKey:@"is_master"];
        NSLog(@"is_master : 1");
    } else {
        _nextButton.tag = 1216;
        _contactBtn.hidden = false;
        [DDUserDefault setObject:@"0" forKey:@"is_master"];
        NSLog(@"is_master : 0");
    }
    [DDUserDefault synchronize];
    
    if ([dic[@"is_join"] isEqualToString:@"1"]) {
        [_nextButton setTitle:@"签到" forState:UIControlStateNormal];
        _contactBtn.enabled = true;
        _contactBtn.tintColor = kBtnEnable;
        [_contactBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        [_contactBtn setImage:[UIImage imageNamed:@"TJDeskContact_enable"] forState:UIControlStateNormal];
        _noticeLock(@"1");
    } else {
        _nextButton.tag = 1214;
        [_nextButton setTitle:@"加入桌子" forState:UIControlStateNormal];
        _contactBtn.enabled = false;
        [_contactBtn setTitleColor:kBtnDisable forState:UIControlStateNormal];
        [_contactBtn setImage:[UIImage imageNamed:@"TJDeskContact_disable"] forState:UIControlStateNormal];
        _noticeLock(@"0");
    }
    

}

- (NSInteger)getRemaindDays:(NSString *)str {
    return [str doubleValue]-[[NSDate date] timeIntervalSince1970]/24/60/60;
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


-(NSInteger)getTheCountOfTwoDaysWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate{

    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

//    NSDate *startD =[inputFormatter dateFromString:beginDate];
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
