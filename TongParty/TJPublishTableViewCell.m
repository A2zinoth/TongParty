//
//  TJPublishTableViewCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishTableViewCell.h"
#import "TJPublishModel.h"

@interface TJPublishTableViewCell ()

@property (nonatomic, strong) YYLabel *eventLabel;
@end

@implementation TJPublishTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_qq_friend"]];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(23);
        make.left.mas_equalTo(self.contentView).offset(29);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    _titleLabel = [[YYLabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor hx_colorWithHexString:@"#2E3041"];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageView.mas_centerY).offset(2);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 22));
        make.height.mas_equalTo(22);
    }];
    
    // 活动描述
    _eventLabel = [[YYLabel alloc] init];
    _eventLabel.font = [UIFont systemFontOfSize:13];
    _eventLabel.textColor = [UIColor hx_colorWithHexString:@"#BAC6D2"];
    [self.contentView addSubview:_eventLabel];
    [_eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.trailing.mas_equalTo(-36);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.height.mas_equalTo(14);
    }];
}

- (void)updateDataWithDic:(NSDictionary *)dic {
    _titleLabel.text = dic[@"title"];
}

- (void)updateDataWithRow:(NSInteger)row model:(TJPublishModel *)model {
    switch (row) {
        case 0:
            _eventLabel.text = model.title;
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        default:
            break;
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
