//
//  TJSettingCell.m
//  TongParty
//
//  Created by tojoin on 2018/5/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSettingCell.h"

@implementation TJSettingCell

- (void)createUI {
    self.separatorInset = UIEdgeInsetsMake(0, 24, 0, 0);
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.centerY.mas_equalTo(0);
    }];
    
    _accessoryImage = [[UIImageView alloc] initWithImage:kImage(@"TJMoreBtn")];
    [self.contentView addSubview:_accessoryImage];
    [_accessoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
}

- (void)hiddenAccessory {
    _accessoryImage.hidden = true;
}

@end
