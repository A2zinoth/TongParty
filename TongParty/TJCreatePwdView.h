//
//  TJCreatePwdView.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"

@interface TJCreatePwdView : TJBaseView

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIButton    *closeBtn;
@property (nonatomic, strong) UIButton    *signupBtn;
@property (nonatomic, strong) UILabel     *phoneNum;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) YYLabel     *showPwd;
@property (nonatomic, strong) UIButton    *loginBtn;

@end
