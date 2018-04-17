//
//  TJCreatePwdController.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"
#import "TJCreatePwdView.h"
#import "TJCreatePwdModel.h"

typedef void (^BackBlock)();

@interface TJCreatePwdController : BaseViewController

@property (nonatomic, copy)   BackBlock        backBlock;

@property (nonatomic, strong) TJCreatePwdView  *createPwdView;
@property (nonatomic, strong) TJCreatePwdModel *createPwdModel;

@end
