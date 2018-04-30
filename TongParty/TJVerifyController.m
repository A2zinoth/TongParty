//
//  VerifyController.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJVerifyController.h"
#import "VerifyView.h"
#import "TJCreatePwdController.h"

@interface TJVerifyController ()<UITextFieldDelegate>

@property (nonatomic, strong) VerifyView        *verifyView;

@end

@implementation TJVerifyController
- (void)createData {
    _needSendVerify = true;
}

- (void)createUI {
    
    _verifyView = [[VerifyView alloc] init];
    
    if (_type) {
        _verifyView.titleLabel.text = _type;
    }
    [self.view addSubview:_verifyView];
    [_verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [_verifyView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_verifyView.nextButton addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    WeakSelf(weakSelf);
    _verifyView.resend = ^ {
        [weakSelf sendMsgVerifycodeWithCode:weakSelf.phone];
    };
    
    _verifyView.codeTF.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _verifyView.phone = _phone;
    if (_phone && _needSendVerify) {
        [self sendMsgVerifycodeWithCode:_phone];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        _verifyView.nextButton.enabled = false;
        _verifyView.nextButton.backgroundColor = kBtnDisable;
        return YES;
    }
    
    if (textField.text.length+string.length >= 6) {
        _verifyView.nextButton.enabled = true;
        _verifyView.nextButton.backgroundColor = kBtnEnable;
    }
    
    if (textField.text.length >= 6) {
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



- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)signupAction {

    NSString *code = _verifyView.codeTF.text;
    WeakSelf(weakSelf);
    
    [DDResponseBaseHttp getWithAction:kTJCheckVerifyCode params:@{@"mobile":_phone, @"code":code} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if([result.status isEqualToString:@"success"]) {
            TJCreatePwdController *VC = [TJCreatePwdController new];
            VC.createPwdModel.mobile = _phone;
            VC.createPwdModel.code = code;
            if (_type) {
                VC.type = _type;
            }
            VC.backBlock = ^{
                weakSelf.needSendVerify = false;
            };
            [weakSelf.navigationController pushViewController:VC animated:true];
        } else {
            [MBProgressHUD showMessage:result.msg_cn];
        }
    } failure:^{
    }];
}

#pragma mark - 发送验证码
-(void)sendMsgVerifycodeWithCode:mobile{
    [DDResponseBaseHttp getWithAction:kTJLoginSendCodeAPI params:@{@"mobile":mobile}  type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        [MBProgressHUD showMessage:result.msg_cn];
    } failure:^{
    }];
}




@end
