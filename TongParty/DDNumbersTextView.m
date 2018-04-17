//
//  DDNumbersTextView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDNumbersTextView.h"
#import "UIView+Layer.h"
#import "LSHisUserInfoModel.h"

#define kSplitLineWidth  1
#define kItemWidth   (kScreenWidth - 3)/4

@interface DDNumbersTextView()
//铜币
@property (nonatomic, strong) DDNumbersTextItemView *itemViewCoin;
@property (nonatomic, strong) UILabel *splitLine1;
//关注
@property (nonatomic, strong) DDNumbersTextItemView *itemViewCare;
@property (nonatomic, strong) UILabel *splitLine2;
//被关注
@property (nonatomic, strong) DDNumbersTextItemView *itemViewCared;
@property (nonatomic, strong) UILabel *splitLine3;
//好友
@property (nonatomic, strong) DDNumbersTextItemView *itemViewFriends;
//关注
@property (nonatomic, strong) UIButton *careBtn;
//邀请
@property (nonatomic, strong) UIButton *inviteBtn;
@end

@implementation DDNumbersTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
-(void)setupViews{
    self.itemViewCoin = [DDNumbersTextItemView new];
    [self addSubview:self.itemViewCoin];
    self.itemViewCoin.tag = 100;
    [self.itemViewCoin addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemsClick:)]];
    self.itemViewCoin.itemName = @"桐币";
    self.itemViewCoin.itemNumbers  = @"0";
    
    self.splitLine1 = [UILabel new];
    [self addSubview:self.splitLine1];
    self.splitLine1.backgroundColor = kLightGrayColor;
    
    self.itemViewCare = [DDNumbersTextItemView new];
    [self addSubview:self.itemViewCare];
    self.itemViewCare.tag = 101;
    [self.itemViewCare addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemsClick:)]];
    self.itemViewCare.itemName = @"关注";
    self.itemViewCare.itemNumbers  = @"0";
    
    self.splitLine2 = [UILabel new];
    [self addSubview:self.splitLine2];
    self.splitLine2.backgroundColor = kLightGrayColor;
    
    self.itemViewCared = [DDNumbersTextItemView new];
    [self addSubview:self.itemViewCared];
    self.itemViewCared.tag = 102;
    [self.itemViewCared addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemsClick:)]];
    self.itemViewCared.itemName = @"被关注";
    self.itemViewCared.itemNumbers  = @"0";
    
    self.splitLine3 = [UILabel new];
    [self addSubview:self.splitLine3];
    self.splitLine3.backgroundColor = kLightGrayColor;
    
    self.itemViewFriends = [DDNumbersTextItemView new];
    [self addSubview:self.itemViewFriends];
    self.itemViewFriends.tag = 103;
    [self.itemViewFriends addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemsClick:)]];
    self.itemViewFriends.itemName = @"好友";
    self.itemViewFriends.itemNumbers  = @"0";
}

-(void)setNormalUI{
    [self.itemViewCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kItemWidth);
    }];
    [self.splitLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(self.itemViewCoin.mas_right);
        make.width.mas_equalTo(kSplitLineWidth);
        make.bottom.mas_equalTo(-18);
    }];
    [self.itemViewCare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.splitLine1.mas_right);
        make.width.mas_equalTo(kItemWidth);
    }];
    [self.splitLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.splitLine1);
        make.left.mas_equalTo(self.itemViewCare.mas_right);
        make.width.mas_equalTo(kSplitLineWidth);
        make.bottom.mas_equalTo(-18);
    }];
    [self.itemViewCared mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.splitLine2.mas_right);
        make.width.mas_equalTo(kItemWidth);
    }];
    [self.splitLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.splitLine1);
        make.left.mas_equalTo(self.itemViewCared.mas_right);
        make.width.mas_equalTo(kSplitLineWidth);
        make.bottom.mas_equalTo(-18);
    }];
    [self.itemViewFriends mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.splitLine3.mas_right);
        make.width.mas_equalTo(kItemWidth);
    }];
}

-(void)setOthersUI{
    _inviteBtn = [UIButton new];
    [self addSubview:_inviteBtn];
    [_inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(30);
    }];
    _inviteBtn.layerCornerRadius = 12;
    [_inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [_inviteBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_inviteBtn setBackgroundImage:kImage(@"btnbg_image") forState:UIControlStateNormal];
    _inviteBtn.titleLabel.font = kFont(12);
    [_inviteBtn addTarget:self action:@selector(inviteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _careBtn = [UIButton new];
    [self addSubview:_careBtn];
    [_careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.inviteBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(30);
    }];
    _careBtn.layerCornerRadius = 12;
    [_careBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _careBtn.titleLabel.font = kFont(12);
    
    float itemW = (kScreenWidth - 55 - 55 - 20 -10)/3;
    [self.itemViewCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
    [self.splitLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(self.itemViewCoin.mas_right);
        make.width.mas_equalTo(0);
        make.bottom.mas_equalTo(-18);
    }];
    [self.itemViewCare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.splitLine1.mas_right);
        make.width.mas_equalTo(itemW);
    }];
    [self.splitLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.splitLine1);
        make.left.mas_equalTo(self.itemViewCare.mas_right);
        make.width.mas_equalTo(0);
        make.bottom.mas_equalTo(-18);
    }];
    [self.itemViewCared mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.splitLine2.mas_right);
        make.width.mas_equalTo(itemW);
    }];
    [self.splitLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.splitLine1);
        make.left.mas_equalTo(self.itemViewCared.mas_right);
        make.width.mas_equalTo(0);
        make.bottom.mas_equalTo(-18);
    }];
    [self.itemViewFriends mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.splitLine3.mas_right);
        make.width.mas_equalTo(itemW);
    }];
}
#pragma mark - 关注
- (void)careAction:(UIButton *)sender{
    sender.tag = !sender.tag;
    if (sender.tag) {
        [_careBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [_careBtn setTitleColor:kBgBlueColor forState:UIControlStateNormal];
        _careBtn.backgroundColor = kWhiteColor;
        _careBtn.layerBorderColor = kBgBlueColor;
        _careBtn.layerBorderWidth = 1;
    }else{
        [_careBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_careBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _careBtn.backgroundColor = kBgBlueColor;
    }
}
#pragma mark - 邀请
-(void)inviteAction:(UIButton *)sender{
    sender.tag = !sender.tag;
    if (sender.tag) {
        [_inviteBtn setTitle:@"已邀请" forState:UIControlStateNormal];
        [_inviteBtn setTitleColor:kBgBlueColor forState:UIControlStateNormal];
        _inviteBtn.backgroundColor = kWhiteColor;
        _inviteBtn.layerBorderColor = kBgBlueColor;
        _inviteBtn.layerBorderWidth = 1;
    }else{
        [_inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
        [_inviteBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_inviteBtn setBackgroundImage:kImage(@"btnbg_image") forState:UIControlStateNormal];
    }
}
#pragma mark - set
- (void)setType:(DDNumbersTextViewType)type{
    switch (type) {
        case DDNumbersTextViewTypeNormal:
        {
            [self setNormalUI];
        }
            break;
        case DDNumbersTextViewTypeOthers:
        {
            [self setOthersUI];
        }break;
        default:
            break;
    }
}
#pragma mark - 四个点击回调
-(void)itemsClick:(UITapGestureRecognizer *)tap{
    if (_variousNumbersClickBlcok) {
        _variousNumbersClickBlcok([tap view].tag - 100);
    }
}
- (void)updateWithModel:(id)model withType:(DDNumbersTextViewType)style{
    
    switch (style) {
        case DDNumbersTextViewTypeNormal:{
            DDUserInfoModel *uModel = (DDUserInfoModel *)model;
            if (!uModel) {
                
                self.itemViewCoin.itemNumbers = @"0";
                self.itemViewCare.itemNumbers  = @"0";
                self.itemViewCared.itemNumbers  = @"0";
                self.itemViewFriends.itemNumbers  = @"0";
            } else {
                if (uModel.coin) {
                    self.itemViewCoin.itemNumbers  = uModel.coin;
                }
                if (uModel.bl_num) {
                    self.itemViewCare.itemNumbers  = uModel.bl_num;
                }
                if (uModel.tl_num) {
                    self.itemViewCared.itemNumbers  = uModel.tl_num;
                }
                if (uModel.f_num) {
                    self.itemViewFriends.itemNumbers  = uModel.f_num;
                }
            }
        }break;
        case DDNumbersTextViewTypeOthers:{
            LSHisUserInfoModel *hModel = (LSHisUserInfoModel *)model;
            if (!hModel) {
                
                self.itemViewCoin.itemNumbers = @"0";
                self.itemViewCare.itemNumbers  = @"0";
                self.itemViewCared.itemNumbers  = @"0";
                self.itemViewFriends.itemNumbers  = @"0";
            } else {
                self.itemViewCoin.itemNumbers = hModel.coin;
                self.itemViewCare.itemNumbers  = hModel.bl_num;
                self.itemViewCared.itemNumbers  = hModel.tl_num;
                self.itemViewFriends.itemNumbers  = hModel.f_num;
                if (hModel.is_like.integerValue == YES) {
                    [_careBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [_careBtn setTitleColor:kBgBlueColor forState:UIControlStateNormal];
                    _careBtn.backgroundColor = kWhiteColor;
                    _careBtn.layerBorderColor = kBgBlueColor;
                    _careBtn.layerBorderWidth = 1;
                    [_careBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelCareAtction:)]];
                } else {
                    [_careBtn setTitle:@"关注" forState:UIControlStateNormal];
                    [_careBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
                    _careBtn.backgroundColor = kBgBlueColor;
                    [_careBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(careAtction:)]];
                }
            }
        }break;
        default:
            break;
    }
}

- (void)careAtction:(UIButton *)sender {
    if (_careBtnClickBlcok) {
        _careBtnClickBlcok(YES);
    }
}

- (void)cancelCareAtction:(UIButton *)sender {
    if (_careBtnClickBlcok) {
        _careBtnClickBlcok(NO);
    }
}

@end


@interface  DDNumbersTextItemView()
@property (nonatomic, strong) UILabel * numbersLbl;
@property (nonatomic, strong) UILabel * nameLbl;
@end

@implementation DDNumbersTextItemView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    self.numbersLbl = [UILabel new];
    [self addSubview:self.numbersLbl];
    [self.numbersLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self).offset(-10);
        make.left.and.right.mas_equalTo(0);
    }];
    self.numbersLbl.textAlignment = NSTextAlignmentCenter;
    self.numbersLbl.textColor = kBlackColor;
    self.numbersLbl.font = kFont(13);
    
    self.nameLbl = [UILabel new];
    [self addSubview:self.nameLbl];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.centerY).offset(10);
        make.left.and.right.mas_equalTo(0);
    }];
    self.nameLbl.textAlignment = NSTextAlignmentCenter;
    self.nameLbl.textColor = kBlackColor;
    self.nameLbl.font = kFont(13);
}

-(void)setItemNumbers:(NSString *)itemNumbers{
    self.numbersLbl.text = itemNumbers;
}
-(void)setItemName:(NSString *)itemName{
    self.nameLbl.text = itemName;
}
@end










