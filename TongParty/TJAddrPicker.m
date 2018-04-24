//
//  TJAddrPicker.m
//  TongParty
//
//  Created by tojoin on 2018/4/23.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJAddrPicker.h"

@implementation TJAddrPicker

- (void)createUI {
    self.backgroundColor = kWhiteColor;
    
    UIView *_maskView = [[UIView alloc] init];
    [self addSubview:_maskView];
    _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-216);
        } else {
            make.bottom.mas_equalTo(self).offset(-216);
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
    
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 166)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
//    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(50);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(self);
//    }];
    

    
    
    // 读取plist
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"address.json" ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSArray *JsonObject= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.metaData = JsonObject;
    // 获取所有省份
    NSMutableArray *province = [NSMutableArray arrayWithCapacity:JsonObject.count];
    for (NSInteger i = 0; i < JsonObject.count; i++) {
        [province addObject:JsonObject[i][@"name"]];
        if (i == 0) {
            // 获取城市
            NSArray *cityList = JsonObject[i][@"cityList"];
            NSMutableArray *city = [NSMutableArray arrayWithCapacity:cityList.count];
            for (NSInteger j = 0;  j < cityList.count; j++) {
                [city addObject:cityList[j][@"name"]];
                // 获取地区
                if (j == 0) {
                    NSArray *arearList = cityList[j][@"areaList"];
                    NSMutableArray *district = [NSMutableArray arrayWithCapacity:arearList.count];
                    for (NSInteger k = 0; k < arearList.count; k++) {
                        [district addObject:arearList[k][@"name"]];
                    }
                    self.district = district.copy;
                }
            }
            self.city = city.copy;
        }
    }
    self.province = province.copy;
    
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.province.count;
            break;
        case 1:
            return self.city.count;
            break;
        case 2:
            return self.district.count;
            break;
        default:
            return 0;
            break;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.province[row];
            break;
        case 1:
            return self.city[row];
            break;
        case 2:
            return self.district[row];
            break;
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            //滑动第一列 刷新第二列第三列
            [self refreshCityAndDistrict:row];
            break;
        case 1:
            //滑动第二列 刷新第三列
            [self refreshDistrict:row];
            break;
        default:
            break;
    }
}

//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)refreshDistrict:(NSInteger)index {
    // 获取城市
    NSArray *cityList = self.metaData[[_pickerView selectedRowInComponent:0]][@"cityList"];
    NSArray *arearList = cityList[[_pickerView selectedRowInComponent:1]][@"areaList"];
    NSMutableArray *district = [NSMutableArray arrayWithCapacity:arearList.count];
    for (NSInteger k = 0; k < arearList.count; k++) {
        [district addObject:arearList[k][@"name"]];
    }
    self.district = district.copy;
    [_pickerView reloadComponent:2];
}


- (void)refreshCityAndDistrict:(NSInteger)index {
    // 获取城市
    NSArray *cityList = self.metaData[index][@"cityList"];
    NSMutableArray *city = [NSMutableArray arrayWithCapacity:cityList.count];
    for (NSInteger j = 0;  j < cityList.count; j++) {
        [city addObject:cityList[j][@"name"]];
        // 获取地区
        if (j == 0) {
            NSArray *arearList = cityList[j][@"areaList"];
            NSMutableArray *district = [NSMutableArray arrayWithCapacity:arearList.count];
            for (NSInteger k = 0; k < arearList.count; k++) {
                [district addObject:arearList[k][@"name"]];
            }
            self.district = district.copy;
            [_pickerView reloadComponent:2];
        }
    }
    self.city = city.copy;
    [_pickerView reloadComponent:1];
}


- (void)okAction {
    if (self.complete) {
        self.complete(self.city[[_pickerView selectedRowInComponent:1]]);
    }
    if (_districtBlock) {
        _districtBlock(self.district[[_pickerView selectedRowInComponent:2]]);
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
