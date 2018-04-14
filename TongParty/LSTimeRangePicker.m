//
//  LSTimeRangePicker.m
//  TongParty
//
//  Created by 刘帅 on 2018/1/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "LSTimeRangePicker.h"
@interface LSTimeRangePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.数据源数组 */
@property (nonatomic, strong, nullable)NSArray *arrayRoot;
/** 2.当前天数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayDay;
/** 3.当前小时数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayHour;
/** 4.当前分钟数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayMin;
/** 5.当前选中数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arraySelected;

/** 6.天 */
@property (nonatomic, strong, nullable)NSString *day;
/** 7.小时 */
@property (nonatomic, strong, nullable)NSString *hour;
/** 8.分钟 */
@property (nonatomic, strong, nullable)NSString *min;
@end
@implementation LSTimeRangePicker

- (void)setupUI {
    
    NSLog(@"%@",self.arrayRoot);
    for (int d = 0; d < 30; d++) {
        NSString *dayString = [NSString stringWithFormat:@"%d天",d];
        [self.arrayDay addObject:dayString];
    }
    for (int h = 0; h < 24; h++) {
        NSString *hourString = [NSString stringWithFormat:@"%d时",h];
        [self.arrayHour addObject:hourString];
    }
    for (int m = 0; m < 60; m++) {
        NSString *minString = [NSString stringWithFormat:@"%d分",m];
        [self.arrayMin addObject:minString];
    }
    
    // 2.设置视图的默认属性
    _heightPickerComponent = 32;
    [self setTitle:@"请选时长"];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}
#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.arrayDay.count;
    }else if (component == 1) {
        return self.arrayHour.count;
    }else{
        return self.arrayMin.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    NSString *text;
    if (component == 0) {
        text =  self.arrayDay[row];
    }else if (component == 1){
        text =  self.arrayHour[row];
    }else{
        if (self.arrayMin.count > 0) {
            text = self.arrayMin[row];
        }else{
            text =  @"";
        }
    }
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
    
    
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk {
    NSString *d = [self.day stringByReplacingOccurrencesOfString:@"天" withString:@""];
    NSString *h = [self.hour stringByReplacingOccurrencesOfString:@"时" withString:@""];
    NSString *m = [self.min stringByReplacingOccurrencesOfString:@"分" withString:@""];
    NSInteger s = d.integerValue*24*60*60 + h.integerValue*60*60 + m.integerValue*60;
    NSString *secondes = [NSString stringWithFormat:@"%ld",s];
    if (_timeRangeData) {
        _timeRangeData(self.day,self.hour,self.min,secondes);
    }
    //[self.delegate picker:self day:self.day hour:self.hour min:self.min sumarySeconds:secondes];
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData {
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    self.day = self.arrayDay[index0];
    self.hour = self.arrayHour[index1];
    self.min = self.arrayMin[index2];
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@", self.day, self.hour, self.min];
    [self setTitle:title];
    
}

#pragma mark - --- setters 属性 ---
#pragma mark - --- getters 属性 ---

- (NSMutableArray *)arrayDay
{
    if (!_arrayDay) {
        _arrayDay = [NSMutableArray array];
    }
    return _arrayDay;
}

- (NSMutableArray *)arrayHour
{
    if (!_arrayHour) {
        _arrayHour = [NSMutableArray array];
    }
    return _arrayHour;
}

- (NSMutableArray *)arrayMin
{
    if (!_arrayMin) {
        _arrayMin = [NSMutableArray array];
    }
    return _arrayMin;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = [NSMutableArray array];
    }
    return _arraySelected;
}

@end
