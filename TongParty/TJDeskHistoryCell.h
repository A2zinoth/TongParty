//
//  TJDeskHistoryCell.h
//  TongParty
//
//  Created by tojoin on 2018/5/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@interface TJDeskHistoryCell : TJBaseTableViewCell

@property (nonatomic, strong) UILabel *circle;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *past;


- (void)updateCircleColor:(NSString *)hexColor;
- (void)updatePastTime:(NSString *)time serviceTime:(NSString *)serviceTime;

@end
