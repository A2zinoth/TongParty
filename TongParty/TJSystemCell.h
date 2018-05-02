//
//  TJSystemCell.h
//  TongParty
//
//  Created by tojoin on 2018/5/2.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@interface TJSystemCell : TJBaseTableViewCell

@property (nonatomic, strong) UILabel     *time;
@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel     *content;

- (void)updateTime:(NSString *)time;

@end
