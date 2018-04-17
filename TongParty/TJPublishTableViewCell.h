//
//  TJPublishTableViewCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJThemeModel.h"

@interface TJPublishTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView    *headImageView;
@property (nonatomic, strong) YYLabel        *titleLabel;
@property (nonatomic, strong) UIButton       *moreBtn;

@property (nonatomic, strong) UIButton       *themeBtn;
@property (nonatomic, strong) UISwitch       *switchBtn;

- (void)updateDataWithDic:(NSDictionary *)dic;
- (void)updateDataWithRow:(NSInteger)row model:(NSObject *)model;
- (void)updateWithModel:(NSObject *)model;

@end
