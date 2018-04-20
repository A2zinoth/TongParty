//
//  TJDatePicker.h
//  TongParty
//
//  Created by tojoin on 2018/4/12.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"

typedef void (^FormatDate)(NSString *);

@interface TJDatePicker : TJBaseView<UIScrollViewDelegate>

@property (nonatomic, strong) UIView        *maskView;

@property (nonatomic, strong) UIScrollView  *datePicker;
@property (nonatomic, strong) UILabel       *centerLabel;
@property (nonatomic, strong) UILabel       *weekLabel;
@property (nonatomic, strong) UILabel       *monthLabel;

@property (nonatomic, strong) UIScrollView  *timePicker;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, copy)   FormatDate    formatDate;

@end
