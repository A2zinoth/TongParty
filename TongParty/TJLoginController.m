//
//  TJLoginControllerViewController.m
//  Tojoin
//
//  Created by tojoin on 2018/4/8.
//  Copyright © 2018年 Beijing Tojoin Network Technology Co., Ltd. All rights reserved.
//

#import "TJLoginController.h"
#import "TJLoginView.h"
#import "TJLoginModel.h"
#import "UserManager.h"
#import "TJVerifyController.h"

@interface TJLoginController ()

@property (nonatomic, strong) TJLoginView  *loginView;
@property (nonatomic, strong) TJLoginModel *loginModel;

@end

@implementation TJLoginController
- (void)createUI {
    _loginView = [[TJLoginView alloc] init];
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    if([_phone isEqualToString:@"中途"]) {
//        [_loginView.phoneTF becomeFirstResponder];
    } else if ([_phone isEqualToString:@"直接"]) {
//        [_loginView.phoneTF becomeFirstResponder];
    } else {
        _loginView.phoneTF.text = _phone;
        [_loginView.passwordTF becomeFirstResponder];
    }
    
    [self addUserAction];
    
    WeakSelf(weakSelf);
    _loginModel = [[TJLoginModel alloc] init];
    _loginView.thirdAction = ^(NSInteger index) {
        UserLoginType type = kUserLoginTypeWeChat;
        switch (index) {
            case 100:
                type = kUserLoginTypeWeibo;
                break;
            case 101:
                type = kUserLoginTypeWeChat;
                break;
            case 102:
                type = kUserLoginTypeQQ;
                break;
            default:
                break;
        }
        [userManager login:type completion:^(BOOL success, NSString *des) {
            [MBProgressHUD showMessage:des];
            if (success) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf dismissViewController];
                });
            }
        }];
    };
    
    _loginModel.thirdLoginSuccess = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf dismissViewController];
        });
        
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
}


#pragma mark - UserAction
- (void)forgetAction {
    if (_loginView.phoneTF.text.length<11) {
        [MBProgressHUD showMessage:@"请输入手机号码"];
        return;
    }
    
    TJVerifyController *vf = [[TJVerifyController alloc] init];
    vf.phone = _loginView.phoneTF.text;
    vf.type = @"忘记密码";
    [self.navigationController pushViewController:vf animated:true];
}

- (void)loginAction {
    _loginModel.mobile = _loginView.phoneTF.text;
    _loginModel.password = _loginView.passwordTF.text;
    
    [userManager login:kUserLoginTypeAccount params:@{@"mobile":_loginView.phoneTF.text, @"password":_loginView.passwordTF.text} completion:^(BOOL success, NSString *des) {
        if (success) {
            [MBProgressHUD showMessage:des];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewController];
            });
        }
    }];
}

- (void)closeAction {
    if ([_phone isEqualToString:@"直接"]) {
         [self dismissViewController];
    } else {
        [self.navigationController popViewControllerAnimated:true];
    }
    
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)signupAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)addUserAction {
    [_loginView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
