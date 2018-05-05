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
#import "TJRegisterController.h"
#import <CoreTelephony/CTCellularData.h>

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
        _loginView.closeBtn.hidden = false;
    } else if ([_phone isEqualToString:@"直接"]) {
        _loginView.closeBtn.hidden = true;
        if (kiPhoen) {
            _loginView.phoneTF.text = @"17600368817";
            _loginView.passwordTF.text = @"12345678";
        }
    } else {
        _loginView.closeBtn.hidden = false;
        _loginView.phoneTF.text = _phone;
        [_loginView.passwordTF becomeFirstResponder];
        if (kiPhoen) {
            _loginView.passwordTF.text = @"12345678";
        }
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    
    /*
     此函数会在网络权限改变时再次调用
     */
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        switch (state) {
            case kCTCellularDataRestricted:
                
                NSLog(@"Restricted");
                //2.1权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                
                break;
            case kCTCellularDataNotRestricted:
                
                NSLog(@"NotRestricted");
                //2.2已经开启网络权限 监听网络状态
                
                
                break;
            case kCTCellularDataRestrictedStateUnknown:
                
                NSLog(@"Unknown");
                //2.3未知情况 （还没有遇到推测是有网络但是连接不正常的情况下）
                
                break;
                
            default:
                break;
        }
    };
//    if([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusReachableViaWWAN || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusReachableViaWiFi) {
//        NSString *title = @"打开[无线数据]来允许桐聚访问网络";
//        NSString *message = [NSString stringWithFormat:@"请在系统设置中开启无线数据(设置>桐聚>无线数据>开启)"];
//        [self alertWithTitle:title message:message cancel:@"取消" ok:@"设置" cancel:^{
//        } ok:^{
//            if (@available(ios 10.0, *)) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
//            } else {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            }
//        }];
//    }
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
    [self.navigationController pushViewController:[TJRegisterController new] animated:true];
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
