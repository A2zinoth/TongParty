//
//  TJSettingCell.h
//  TongParty
//
//  Created by tojoin on 2018/5/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@interface TJSettingCell : TJBaseTableViewCell

@property (nonatomic, strong) UIImageView *accessoryImage;

- (void)hiddenAccessory;

@end
