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
@property (nonatomic, strong) UIScrollView  *datePickerUP;
@property (nonatomic, strong) NSArray       *dateDataArr;

@property (nonatomic, strong) UIScrollView  *timePicker;
@property (nonatomic, strong) UIScrollView  *timePickerUP;
@property (nonatomic, strong) NSArray       *timeDataArr;

@property (nonatomic, copy)   FormatDate    formatDate;

@property (nonatomic, assign) CGFloat       left;
@property (nonatomic, assign) CGFloat       leftI;
@property (nonatomic, assign) CGFloat       offsetX;


- (void)setCurrentTime:(NSString *)time;

@end
