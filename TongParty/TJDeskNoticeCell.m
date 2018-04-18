//
//  TJDeskNoticeCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/17.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskNoticeCell.h"

@implementation TJDeskNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIImageView *background = [[UIImageView alloc] initWithImage:kImage(@"TJNoticeRectang")];
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-51);
        make.bottom.mas_equalTo(0);
    }];
    
    
    _time = [[UILabel alloc] init];
    _time.text = @"公告：2018-4-2 17：00";
    _time.font = [UIFont systemFontOfSize:9];
    _time.textColor = [UIColor hx_colorWithHexString:@"#869DB1"];
    [self.contentView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(27);
        make.left.mas_equalTo(48);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(14);
    }];
    
    _content = [[UILabel alloc] init];
    _content.numberOfLines = 0;
    _content.text = @"参加桌子的朋友们麻烦都电联一下我！";
    _content.font = [UIFont systemFontOfSize:13];
    _content.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(48);
        make.right.mas_equalTo(-75);
        make.height.mas_greaterThanOrEqualTo(19);
    }];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.tag = 2111;
    headImage.layerCornerRadius = 12;
    [self.contentView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(63);
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
}

- (void)updateWithDataArr:(NSDictionary *)dic {
    _content.text = dic[@"notice_text"];
    _time.text = [NSString stringWithFormat:@"公告：%@", dic[@"uptime"]];
    
    UIImageView *headImage = [self.contentView viewWithTag:2111];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[DDUserDefault objectForKey:@"masterHeadImage"]]];
}

- (void)updateMasterHeadImage {
   
}

@end
