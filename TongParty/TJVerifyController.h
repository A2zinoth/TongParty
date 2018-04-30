//
//  TJVerifyController.h
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"

@interface TJVerifyController : BaseViewController

@property (nonatomic, assign) NSInteger         isBind;// 是否是绑定手机号码
@property (nonatomic, copy)   NSString          *type; // 验证码 忘记密码
@property (nonatomic, copy)   NSString          *phone;
@property (nonatomic, assign) BOOL              needSendVerify;

@end
