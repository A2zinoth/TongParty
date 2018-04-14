//
//  TJRegisterController.h
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"
#import "TJRegisterView.h"
#import "TJRegisterModel.h"

@interface TJRegisterController : BaseViewController

@property (nonatomic, strong) TJRegisterView  *registerView;
@property (nonatomic, strong) TJRegisterModel *registerModel;

@end
