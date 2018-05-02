//
//  TJHomeTableViewCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHomeTableViewCell.h"


@implementation TJHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(24);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    _nickname = [[YYLabel alloc] init];
    _nickname.text = @"Amy";
    _nickname.textColor = kBoyNameColor;
    [self.contentView addSubview:_nickname];
    [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(126);
        make.right.greaterThanOrEqualTo(self.contentView).offset(-24);
    }];
    
    _event = [[YYLabel alloc] init];
    _event.text = @"南池子春游约拍";
    _event.font = [UIFont systemFontOfSize:13];
    _event.textColor = [UIColor hx_colorWithHexString:@"#2E3041"];
    [self.contentView addSubview:_event];
    [_event mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nickname.mas_bottom).offset(6);
        make.left.mas_equalTo(self.nickname);
        make.right.mas_greaterThanOrEqualTo(self.contentView).offset(-24);
        make.height.mas_equalTo(19);
    }];
    
    UIImageView *addrPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJLocaiton"]];
    [self.contentView addSubview:addrPic];
    [addrPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.event.mas_bottom).offset(6);
        make.left.mas_equalTo(self.event);
        make.size.mas_equalTo(CGSizeMake(9, 11));
    }];
    
    
    _addr = [[YYLabel alloc] init];
    _addr.text = @"北京市首都剧场王府井大街22号";
    _addr.font = [UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight];
    _addr.textColor = [UIColor hx_colorWithHexString:@"#2E3041"];
    [self.contentView addSubview:_addr];
    [_addr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addrPic);
        make.left.mas_equalTo(addrPic.mas_right).offset(3);
        make.right.mas_equalTo(self.contentView).offset(-24);
        make.height.mas_equalTo(19);
    }];

    
    _distance = [[YYLabel alloc] init];
    _distance.text = @"距离：14KM   参与人数：3／4";
    _distance.font = [UIFont systemFontOfSize:11 weight:UIFontWeightThin];
    _distance.textColor = [UIColor hx_colorWithHexString:@"#464646"];
    [self.contentView addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addr.mas_bottom).offset(7);
        make.left.mas_equalTo(addrPic);
        
    }];
}
- (void)updataHeadImage:(NSString *)imagename {
    _headImageView.image = [UIImage imageNamed:imagename];
}

- (void)updateWithModel:(TJHomeModel *)model {
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.head_image]];
    _nickname.text = model.nickname;
    _event.text = model.title;
    _addr.text = model.place;
    _distance.text = [NSString stringWithFormat:@"距离：%.0fKM   参与人数：%@／%@",model.distance.doubleValue,model.current_num, model.person_num];
    
    if ([model.sex isEqualToString:@"2"]) {
        _nickname.textColor = kGirlNameColor;
    } else {
        _nickname.textColor = kBoyNameColor;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
