//
//  LSTimeRangePicker.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@class LSTimeRangePicker;

@protocol  LSTimeRangePickerDelegate<NSObject>
- (void)picker:(LSTimeRangePicker *)picker day:(NSString *)day hour:(NSString *)hour min:(NSString *)min sumarySeconds:(NSString *)seconds;

@end
@interface LSTimeRangePicker : DDPickerView
@property (nonatomic, assign)CGFloat heightPickerComponent;
@property (nonatomic, copy)void(^timeRangeData)(NSString *day,NSString *hour,NSString *min,NSString *seconds);
@property(nonatomic, weak)id <LSTimeRangePickerDelegate>delegate ;
@end
NS_ASSUME_NONNULL_END
