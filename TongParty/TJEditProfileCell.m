//
//  TJEditProfileCell.m
//  TongParty
//
//  Created by tojoin on 2018/4/21.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEditProfileCell.h"
#import <IQKeyboardManager/IQUIView+IQKeyboardToolbar.h>

@implementation TJEditProfileCell

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
    _titleL.textColor = [UIColor hx_colorWithHexString:@"#BDC9D4"];
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(23);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(22);
    }];
    
    _valueL = [[UILabel alloc] init];
    _valueL.font = [UIFont systemFontOfSize:15];
    _valueL.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    [self.contentView addSubview:_valueL];
    [_valueL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(77);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *_moreBtn = [[UIButton alloc] init];
    [_moreBtn setImage:[UIImage imageNamed:@"TJMoreBtn"] forState:UIControlStateNormal];
    _moreBtn.tag = 1913;
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(9, 15));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (_bCouldEdit) {
        if (selected) {
            [self beginEditSchool];
        }
    }
}



- (void)updateData:(NSString *)data {
    _titleL.text = data;
}

- (void)updateValue:(NSString *)value {
    _valueL.text = value;
}


- (void)beginEditSchool {
    [self.contentView addSubview:self.editTF];
    _editTF.font = [UIFont systemFontOfSize:15];
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"请输入学校名称" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"#BBC8D3"]}];
    _editTF.attributedPlaceholder = attr;
    [_editTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(77);
        make.right.mas_offset(-30);
        make.height.mas_offset(22);
    }];
    [_editTF becomeFirstResponder];
}

- (void)endEditSchool {
    [self.editTF removeFromSuperview];
}

- (UITextField *)editTF {
    if (!_editTF) {
        _editTF = [[UITextField alloc] init];
        _editTF.backgroundColor = kWhiteColor;
        [_editTF addDoneOnKeyboardWithTarget:self action:@selector(doneAction)];
    }
    return _editTF;
}

- (void)doneAction {
    _valueL.text = _editTF.text;
    [self endEditSchool];
    if (_endEdit) {
        if (_editTF.text.length) {
            
            _endEdit(_editTF.text);
        } else {
            _endEdit(@"");
        }
    }
}

- (void)updateMoreBtn {
    UIButton *moreButton = [self.contentView viewWithTag:1913];
    moreButton.hidden = true;
    
    UIView *dot = [[UIView alloc] init];
    dot.backgroundColor = [UIColor hx_colorWithHexString:@"#BBC8D3"];
    dot.layerCornerRadius = 3;
    [self.contentView addSubview:dot];
    [dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.trailing.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
}

- (void)hiddenRightAccessory {
    UIButton *moreButton = [self.contentView viewWithTag:1913];
    moreButton.hidden = true;
}

@end
