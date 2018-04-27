//
//  TJNoticeCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@interface TJNoticeCell : TJBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel     *badge;
@property (nonatomic, strong) UILabel     *titleL;
@property (nonatomic, strong) UILabel     *contentL;
@property (nonatomic, strong) UILabel     *timeL;
@property (nonatomic, strong) UIImageView *accessoryImage;


@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UILabel *remaindL;

- (void)updateSystemControl; // 系统提示信息样式
- (void)updateCustomControl; // 用户提示信息样式

- (void)updateSystemControl:(NSDictionary *)dic index:(NSInteger)index;

- (void)updateRemainL:(NSString *)time;
- (void)updateTime:(NSString *)time;

@end
