//
//  TJDatePicker.m
//  TongParty
//
//  Created by tojoin on 2018/4/12.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDatePicker.h"
#import "NSDate+Extension.h"

@implementation TJDatePicker

- (void)createUI {

    self.backgroundColor = kWhiteColor;
    
    _maskView = [[UIView alloc] init];
    [self addSubview:_maskView];
    _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-244);
        } else {
            make.bottom.mas_equalTo(self).offset(-244);
        }
        make.top.mas_equalTo(self).offset(-568);
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
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(47);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    //获取当前月 日  星期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [calendar setTimeZone:timeZone];
    unsigned unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:14];
    for (NSInteger i = 0; i < 14; i++) {
        NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate dateWithTimeInterval:i*24*60*60 sinceDate:[NSDate date]]];
        NSString *month = [NSString stringWithFormat:@"%zd", components.month];
        NSString *day = [NSString stringWithFormat:@"%zd", components.day];
        NSString *week = [NSString stringWithFormat:@"%zd", components.weekday-1];
        [dataArr addObject:@[month, day, week]];
    }
    
    float labelWidth = 50;
    float labelHeight = 98;
    float left = (kScreenWidth/2-labelWidth/2)/labelWidth;
    
    float offsetLeft = -left+3*labelWidth;
    
    _datePicker = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48, kScreenWidth, labelHeight)];
    [self addSubview:_datePicker];
    _datePicker.contentSize = CGSizeMake((dataArr.count+left*2)*labelWidth, labelHeight);
    _datePicker.contentOffset = CGPointMake(offsetLeft, 0);
    _datePicker.showsHorizontalScrollIndicator = false;
    _datePicker.delegate = self;
    
    // 中间框
    _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(left*labelWidth, 48, labelWidth, labelHeight)];
    [self addSubview:_centerLabel];
    _centerLabel.text = dataArr[3][1];
    _centerLabel.backgroundColor = kBtnEnable;
    _centerLabel.font = [UIFont systemFontOfSize:11];
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    _centerLabel.textColor = [UIColor whiteColor];
    
    _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(left*labelWidth+7, 48+7, 36, 16)];
    [self addSubview:_weekLabel];
    _weekLabel.text = [self getWeekWithNum:dataArr[3][2]];
    _weekLabel.font = [UIFont systemFontOfSize:11];
    _weekLabel.textAlignment = NSTextAlignmentCenter;
    _weekLabel.textColor = kWhiteColor;
    
    
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(left*labelWidth+15, 48+77, 21, 12)];
    [self addSubview:_monthLabel];
    _monthLabel.text = [NSString stringWithFormat:@"%@月", dataArr[3][0]];
    _monthLabel.font = [UIFont systemFontOfSize:8];
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    _monthLabel.textColor = kWhiteColor;
    
    
    for (int i = 0; i < dataArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((left+i)*labelWidth, 0, labelWidth, labelHeight)];
        [_datePicker addSubview:label];
        label.tag = i+100;
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hx_colorWithHexString:@"#999999"];
        label.text = dataArr[i][1];
        
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake((left+i)*labelWidth+7, 7, 36, 16)];
        [_datePicker addSubview:weekLabel];
        weekLabel.tag = i+200;
        weekLabel.font = [UIFont systemFontOfSize:11];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.textColor = [UIColor hx_colorWithHexString:@"#999999"];
        weekLabel.text = [self getWeekWithNum:dataArr[i][2]];
        
        UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake((left+i)*labelWidth+15, 77, 21, 12)];
        [_datePicker addSubview:monthLabel];
        monthLabel.tag = i+300;
        monthLabel.font = [UIFont systemFontOfSize:8];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        monthLabel.textColor = [UIColor hx_colorWithHexString:@"#999999"];
        monthLabel.text = [NSString stringWithFormat:@"%@月", dataArr[i][0]];
    }
    
    
    //时间
    NSMutableArray *timeArr = [NSMutableArray arrayWithCapacity:24];
    for (NSInteger i = 0; i < 24; i++) {
        if (i < 10)
            [timeArr addObject:[NSString stringWithFormat:@"0%zd:00", i]];
        else
            [timeArr addObject:[NSString stringWithFormat:@"%zd:00", i]];
    }
    
    
    _timePicker = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48+98, kScreenWidth, labelHeight)];
    [self addSubview:_timePicker];
    _timePicker.contentSize = CGSizeMake((dataArr.count+left*2)*labelWidth, labelHeight);
    _timePicker.contentOffset = CGPointMake(offsetLeft, 0);
    _timePicker.showsHorizontalScrollIndicator = false;
    _timePicker.delegate = self;
    
    // 中间框
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(left*labelWidth, 48+98, labelWidth, labelHeight)];
    [self addSubview:_timeLabel];
    _timeLabel.text = timeArr[3];
    _timeLabel.backgroundColor = [UIColor hx_colorWithHexString:@"#D1D9E1"];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor whiteColor];
    
    for (int i = 0; i < timeArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((left+i)*labelWidth, 0, labelWidth, labelHeight)];
        [_timePicker addSubview:label];
        label.tag = i+400;
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hx_colorWithHexString:@"#999999"];
        label.text = timeArr[i];
    }
    
}
- (NSString *)getWeekWithNum:(NSString *)num {
    NSInteger index = [num integerValue];
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    return [weekdays objectAtIndex:index];
}


#pragma  mark - UIScrollViewDelegate
- (void)timeSnapToNearestItem {
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:_timePicker.contentOffset];
    [_timePicker setContentOffset:targetOffset animated:YES];
    [self getTimeCurrentContent];
}

- (void)getTimeCurrentContent {
    CGFloat pageSize = 50;
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:_timePicker.contentOffset];
    UILabel *label = (UILabel *)[_timePicker viewWithTag:targetOffset.x/pageSize+400];
    _timeLabel.text = label.text;
}


// 滚动到最近的item
- (void)snapToNearestItem{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:_datePicker.contentOffset];
    [_datePicker setContentOffset:targetOffset animated:YES];
    [self getCurrentContent];
}

- (void)getCurrentContent {
    CGFloat pageSize = 50;
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:_datePicker.contentOffset];
    UILabel *label = (UILabel *)[_datePicker viewWithTag:targetOffset.x/pageSize+100];
    _centerLabel.text = label.text;
    
    UILabel *weekLabel = (UILabel *)[_datePicker viewWithTag:targetOffset.x/pageSize+200];
    _weekLabel.text = weekLabel.text;
    
    UILabel *monthLabel = (UILabel *)[_datePicker viewWithTag:targetOffset.x/pageSize+300];
    _monthLabel.text = monthLabel.text;
}



// 找到最近目标点
- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset{
    CGFloat pageSize = 50;
    NSInteger page = roundf(offset.x / pageSize);
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, 0);
}

// 即将拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _datePicker) {
        [self getCurrentContent];
    } else if (scrollView == _timePicker) {
        [self getTimeCurrentContent];
    }
}

// 结束减速
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView{
    if (scrollView == _datePicker) {
        [self snapToNearestItem];
    } else if (scrollView == _timePicker) {
        [self timeSnapToNearestItem];
    }
}

// 结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _datePicker) {
        if (!decelerate) {
            [self snapToNearestItem];
        }
    } else if (scrollView == _timePicker) {
        if (!decelerate) {
            [self timeSnapToNearestItem];
        }
    }
}

- (NSString *)getYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [calendar setTimeZone:timeZone];
    unsigned unitFlags = NSCalendarUnitYear;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%zd",components.year];
}


- (void)okAction {
    
    NSString *time = [NSString stringWithFormat:@"%@/%@/%@ %@", [self getYear], [_monthLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""],_centerLabel.text, _timeLabel.text];
//     timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSInteger stamp = [NSDate timeSwitchTimestamp:time andFormatter:@"YYYY/MM/dd HH:mm"];
    self.complete([NSString stringWithFormat:@"%zd", stamp]);
    [self removeFromSuperview];
}

- (void)closeAction {
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == nil) {
        return _maskView;
    }
    return hitView;
}

@end
