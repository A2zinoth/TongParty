//
//  TJCreatePwdController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJCreatePwdController.h"

@interface TJCreatePwdController ()<UITextFieldDelegate>
@end

@implementation TJCreatePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    _createPwdView = [[TJCreatePwdView alloc] init];
    if(_type) {
        _createPwdView.titleLabel.text = @"创建新密码";
    }
    [self.view addSubview:_createPwdView];
    [_createPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [_createPwdView.closeBtn  addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_createPwdView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
  
    _createPwdView.passwordTF.delegate = self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        _createPwdView.loginBtn.userInteractionEnabled = false;
        _createPwdView.loginBtn.backgroundColor = kBtnDisable;
        if (textField.text.length>8) {
            _createPwdView.loginBtn.userInteractionEnabled = true;
            _createPwdView.loginBtn.backgroundColor = kBtnEnable;
        }
        return YES;
    }
    
    if (textField.text.length+string.length >= 8) {
        _createPwdView.loginBtn.userInteractionEnabled = true;
        _createPwdView.loginBtn.backgroundColor = kBtnEnable;
    }
    
    if (textField.text.length >= 16) {
        return false;
    }
    return YES;
}

- (TJCreatePwdModel *)createPwdModel {
    if (!_createPwdModel) {
        _createPwdModel = [[TJCreatePwdModel alloc] init];
    }
    return _createPwdModel;
}

- (void)registerUser {
    
    if (_type) {
        kWeakSelf
        [DDResponseBaseHttp getWithAction:kTJForgetPwd params:[_createPwdModel mj_keyValues] type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIViewController *loginvc = self.navigationController.childViewControllers[1];
                    [weakSelf.navigationController popToViewController:loginvc animated:true];
                });
            }
        } failure:^{
            
        }];
        
    } else {
        [userManager login:kUserLoginTypeCaptcha params:[_createPwdModel mj_keyValues] completion:^(BOOL success, NSString *des) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *rootVC = self.navigationController.childViewControllers[0];
                [rootVC dismissViewControllerAnimated:true completion:nil];
            });
        }];
    }
}

- (void)loginAction {
    if (_type) {
        _createPwdModel.newpwd = _createPwdView.passwordTF.text;
    } else {
        _createPwdModel.password = _createPwdView.passwordTF.text;
    }
    [self registerUser];
}

- (void)closeAction {
    _backBlock();
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
