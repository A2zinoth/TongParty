//
//  TJSuggestTableViewCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/14.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSuggestTableViewCell.h"

@implementation TJSuggestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _titleLabel = [[YYLabel alloc] init];
    _titleLabel.text = @"望京SOHOT1";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(22);
    }];
    
    _addrLabel = [[YYLabel alloc] init];
    _addrLabel.text = @"北京市朝阳区望京街1号";
    _addrLabel.font = [UIFont systemFontOfSize:11];
    _addrLabel.textColor = [UIColor hx_colorWithHexString:@"#617B94"];
    [self.contentView addSubview:_addrLabel];
    [_addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(29);
        make.left.mas_offset(24);
        make.right.mas_offset(-60);
        make.height.mas_equalTo(13);
    }];
    
    
    _circleMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJAddrCircleMark"]];
    [self.contentView addSubview:_circleMark];
    [_circleMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_offset(23);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    _circleMark.hidden = true;
    
    _selectedLabel = [[YYLabel alloc] init];
    _selectedLabel.text = @"望京SOHOT1";
    _selectedLabel.font = [UIFont systemFontOfSize:15];
    _selectedLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self.contentView addSubview:_selectedLabel];
    [_selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(45);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(22);
    }];
    _selectedLabel.hidden = true;
    
    _selectedMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJAddrSelectedMark"]];
    [self.contentView addSubview:_selectedMark];
    [_selectedMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_offset(-24);
        make.size.mas_equalTo(CGSizeMake(20, 14));
    }];

    _selectedMark.hidden = YES;
}


@end
