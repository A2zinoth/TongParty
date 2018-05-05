//
//  TJRegisterController.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJRegisterController.h"
#import "TJVerifyController.h"
#import "TJLoginController.h"
#import "ZLLAuthorizationCheckTool.h"


@implementation TJRegisterController

- (void)createData {
}

- (void)createUI {
    _registerView = [[TJRegisterView alloc] init];
    [self.view addSubview:_registerView];
    [_registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [_registerView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    

    if (kiPhoen) {
        _registerView.phoneTF.text = @"17600368817";
        _registerView.nextButton.enabled = true;
    }


    _registerView.phoneTF.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        _registerView.nextButton.enabled = false;
        _registerView.nextButton.backgroundColor = kBtnDisable;
        return YES;
    }
    
    if (textField.text.length+string.length >= 11) {
        _registerView.nextButton.enabled = true;
        _registerView.nextButton.backgroundColor = kBtnEnable;
    }
    
    if (textField.text.length >= 11) {
        return NO;
    }
    
    /**
     *  限制输入数字，方法二：
     */
    NSString *validRegEx =@"^[0-9]$";
    NSPredicate *regExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEx];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:string];
    if (myStringMatchesRegEx) {
        return YES;
    }
    return NO;
}

- (void)nextAction {
    NSString *phoneNum = _registerView.phoneTF.text;
//    NSString *CM = @"^13[0-9]{1}\\d{8}|15[0-9]\\d{8}|188\\d{8}|17[0-9]\\d{8}|14[0-9]\\d{8}$";
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    if([regextestcm evaluateWithObject:phoneNum]) {
    
    [DDResponseBaseHttp getWithAction:kTJUniqueness params:@{@"mobile":phoneNum} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if([result.msg_cn isEqualToString:@"用户可以使用。"]) {
            TJVerifyController *verifyVC = [[TJVerifyController alloc] init];
            verifyVC.phone = phoneNum;
            verifyVC.needSendVerify = true;
            [self.navigationController pushViewController:verifyVC animated:true];
        } else if([result.msg_cn isEqualToString:@"用户已存在。"]){
            TJLoginController *loginVC = [[TJLoginController alloc] init];
            loginVC.phone = phoneNum;
            [self.navigationController pushViewController:loginVC animated:true];
        } else if([result.msg_cn isEqualToString:@"手机号不规范"]){
            [MBProgressHUD showError:result.msg_cn toView: self.view];
        } else {
            [MBProgressHUD showError:result.msg_cn toView: self.view];
        }
    } failure:^{
        
    }];
    

    
}

- (void)signupAction {
//    TJLoginController *vc = [TJLoginController new];
//    vc.phone = @"中途";
//    [self.navigationController pushViewController:vc animated:true];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}
@end
