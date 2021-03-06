//
//  TJProfileView.h
//  TongParty
//
//  Created by tojoin on 2018/4/20.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"

@interface TJProfileView : TJBaseView

@property (nonatomic, copy  ) NSString *act;
@property (nonatomic, strong) UILabel  *nickName;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIButton    *addFollowBtn;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIButton *followerBtn;
@property (nonatomic, strong) UIButton *friendBtn;

@property (nonatomic, strong) UILabel *partake;

- (instancetype)initWithAct:(NSString *)act;
- (void)updateWithDic:(NSDictionary *)dic;

@end
