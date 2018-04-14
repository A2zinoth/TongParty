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


@interface TJLoginController ()

@property (nonatomic, strong) TJLoginView  *loginView;
@property (nonatomic, strong) TJLoginModel *loginModel;

@end

@implementation TJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
    
    _loginView = [[TJLoginView alloc] init];
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    if([_phone isEqualToString:@"中途"]) {
        [_loginView.passwordTF becomeFirstResponder];
    } else if ([_phone isEqualToString:@"直接"]) {
        [_loginView.phoneTF becomeFirstResponder];
#ifdef DEBUG
        _loginView.phoneTF.text = @"15210030317";
        _loginView.passwordTF.text = @"123456789";
#endif
    } else {
        _loginView.phoneTF.text = _phone;
        [_loginView.passwordTF becomeFirstResponder];
    }
    
    [self addUserAction];
    
    WeakSelf(weakSelf);
    _loginModel = [[TJLoginModel alloc] init];
    _loginView.thirdAction = ^(NSInteger index) {
        [weakSelf.loginModel thirdLogin:index];
    };
}


#pragma mark - UserAction
- (void)loginAction {
    _loginModel.mobile = _loginView.phoneTF.text;
    _loginModel.password = _loginView.passwordTF.text;
    [_loginModel login:^ {
        [self dismissViewController];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
