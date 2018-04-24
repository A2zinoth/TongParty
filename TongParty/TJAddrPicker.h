//
//  TJAddrPicker.h
//  TongParty
//
//  Created by tojoin on 2018/4/23.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"

typedef void (^District)(NSString *);

@interface TJAddrPicker : TJBaseView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *metaData;
@property (nonatomic, strong) NSArray *province;
@property (nonatomic, strong) NSArray *city;
@property (nonatomic, strong) NSArray *district;
@property (nonatomic, copy)   District districtBlock;

@end
