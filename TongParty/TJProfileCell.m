//
//  TJProfileCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/20.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJProfileCell.h"

@implementation TJProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    _titleL = [[UILabel alloc] init];
    _titleL.font = [UIFont systemFontOfSize:15];
    _titleL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(24);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *_moreBtn = [[UIButton alloc] init];
    [_moreBtn setImage:[UIImage imageNamed:@"TJMoreBtn"] forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(9, 15));
    }];
}

- (void)updateData:(NSString *)data {
    _titleL.text = data;
}


@end
