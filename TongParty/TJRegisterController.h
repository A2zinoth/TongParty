//
//  TJRegisterController.h
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"
#import "TJRegisterView.h"

@interface TJRegisterController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, strong) TJRegisterView  *registerView;


@end
