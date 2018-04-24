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
#ifdef DEBUG
        NSString* deviceName = [[UIDevice currentDevice] name];
        if ([deviceName isEqualToString:@"iPhoen 6"])
            _loginView.phoneTF.text = @"13693326733";
        else
            _loginView.phoneTF.text = @"15210030317";
        
        _loginView.passwordTF.text = @"123456789";
#endif
    } else {
        _loginView.phoneTF.text = _phone;
        [_loginView.passwordTF becomeFirstResponder];
#if DEBUG
        _loginView.passwordTF.text = @"helloworld";
#endif
    }
    
    [self addUserAction];
    
    WeakSelf(weakSelf);
    _loginModel = [[TJLoginModel alloc] init];
    _loginView.thirdAction = ^(NSInteger index) {
        [weakSelf.loginModel thirdLogin:index];
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
- (void)loginAction {
    _loginModel.mobile = _loginView.phoneTF.text;
    _loginModel.password = _loginView.passwordTF.text;
    [_loginModel login:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewController];
        });
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
