//
//  TJShortCutCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJShortCutCell.h"

@implementation TJShortCutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _content = [[UILabel alloc] init];
    _content.font = [UIFont systemFontOfSize:13];
    _content.textColor = [UIColor hx_colorWithHexString:@"#363636"];
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(24);
        make.right.mas_equalTo(self.contentView).offset(-24);
        make.height.mas_equalTo(19);
    }];
    
}

- (void)updateWithContent:(NSDictionary *)dic {
    _content.text = dic[@"notice_text"];
}

@end
