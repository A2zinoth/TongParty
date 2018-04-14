//
//  VerifyController.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "VerifyController.h"
#import "VerifyView.h"
#import "TJCreatePwdController.h"
#import "DDValidateManager.h"

@interface VerifyController ()

@property (nonatomic, strong) VerifyView        *verifyView;

@property (nonatomic, strong) DDValidateManager *validateManager;

@end

@implementation VerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _verifyView = [[VerifyView alloc] init];
    [self.view addSubview:_verifyView];
    [_verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
   
    [_verifyView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_verifyView.signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    WeakSelf(weakSelf);
    _verifyView.resend = ^ {
        [weakSelf sendMsgVerifycodeWithCode:weakSelf.phone];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _verifyView.phone = _phone;
    if (_phone) {
        [self sendMsgVerifycodeWithCode:_phone];
    }
}



- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)signupAction {
    [DDTJHttpRequest checkCodeWithDic:@{@"mobile":_phone, @"code":_verifyView.codeTF.text} success:^(NSString *resp) {
        if ([resp isEqualToString:@"success"]) {
            [self.navigationController pushViewController:[TJCreatePwdController new] animated:true];
        } else {
            [MBProgressHUD showMessage:@"验证码好像不太对~" toView:self.view];
        }
    }];
    
    
}

#pragma mark - 发送验证码
-(void)sendMsgVerifycodeWithCode:mobile{
    if ([self.validateManager validateVercodeWithPhone:mobile]) {
        [DDTJHttpRequest msgCodeWithUsername:mobile block:^(NSDictionary *dict) {
            [MBProgressHUD showMessage:dict[@"msg_cn"] toView:self.view];
            NSLog(@"对的" );
        } failure:^{
            //
        }];
    }
}
-(DDValidateManager *)validateManager
{
    if(!_validateManager) {
        _validateManager = [[DDValidateManager alloc]initWithController:self];
    }
    return _validateManager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
