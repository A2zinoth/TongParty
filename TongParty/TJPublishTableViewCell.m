//
//  TJPublishTableViewCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishTableViewCell.h"
#import "TJPublishModel.h"
#import "NSDate+Extension.h"

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
    _headImageView = [[UIImageView alloc] init];
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
        if (iPhoneX) {
            make.centerY.mas_equalTo(self.headImageView.mas_centerY).offset(2);
        } else {
            make.centerY.mas_equalTo(self.headImageView.mas_centerY);
        }
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 22));
    }];
    
    // 活动描述
    _eventLabel = [[YYLabel alloc] init];
    _eventLabel.font = [UIFont systemFontOfSize:13];
    _eventLabel.textAlignment = NSTextAlignmentRight;
    _eventLabel.textColor = [UIColor hx_colorWithHexString:@"#BAC6D2"];
    [self.contentView addSubview:_eventLabel];
    [_eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.trailing.mas_equalTo(-36);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.height.mas_equalTo(17);
    }];
    
    _moreBtn = [[UIButton alloc] init];
    [_moreBtn setImage:[UIImage imageNamed:@"TJMoreBtn"] forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(9, 15));
    }];
}

- (void)updateDataWithDic:(NSDictionary *)dic {
    _titleLabel.text = dic[@"title"];
    _headImageView.image = [UIImage imageNamed:dic[@"pic"]];
}

- (void)updateDataWithRow:(NSInteger)row model:(TJPublishModel *)model {
    if ([self.contentView viewWithTag:2059]) {
        [_switchBtn removeFromSuperview];
    } else if ([self.contentView viewWithTag:2338]) {
        [_themeBtn removeFromSuperview];
    }
    
    _moreBtn.hidden = false;
    
    NSString *content;
    switch (row) {
        case 0:{
            content = model.title;
            _moreBtn.hidden = true;
        }
            break;
        case 1:{
            content = model.activity;
            [self.contentView addSubview:self.themeBtn];
            [_themeBtn setTitle:content forState:UIControlStateNormal];
            [_themeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(16);
                make.trailing.mas_equalTo(-37);
                make.height.mas_equalTo(30);
                make.width.mas_lessThanOrEqualTo(160);
            }];
        }
            break;
        case 2:
                content = [self transformTimestamp:model.begin_time];
            break;
        case 3:
            content = model.place;
            break;
        case 4:
            content = [NSString stringWithFormat:@"%@人", model.person_num];
            break;
        case 5: {
            content = [NSString stringWithFormat:@"¥%@/人", model.average_price];
            _moreBtn.hidden = true;
        }
            break;
        case 6:{
            content = @"";
            [self.contentView addSubview:self.switchBtn];
            [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(15);
                make.trailing.mas_offset(-24);
                make.size.mas_equalTo(CGSizeMake(51, 31));
            }];
            _moreBtn.hidden = true;
            
        }
            break;
        default:
            break;
    }
    _eventLabel.text = content;
}
- (NSString *)transformTimestamp:(NSString *)time {
    return [NSDate timestampSwitchTime:[time doubleValue] andFormatter:@"YYYY/MM/dd HH:mm"];
}


- (UIButton *)themeBtn {
    if (!_themeBtn) {
        _themeBtn = [[UIButton alloc] init];
        _themeBtn.tag = 2338;
        [_themeBtn setBackgroundImage:[UIImage imageNamed:@"TJButtonSelect"] forState:UIControlStateNormal];
        _themeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _themeBtn.userInteractionEnabled = false;
    }
    return _themeBtn;
}


- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        _switchBtn.onTintColor = kBtnEnable;
        _switchBtn.tag = 2059;
    }
    return _switchBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
