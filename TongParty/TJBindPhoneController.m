//
//  TJBindPhoneController.m
//  TongParty
//
//  Created by tojoin on 2018/4/28.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBindPhoneController.h"
#import "TJBindView.h"
#import "TJVerifyController.h"

@interface TJBindPhoneController ()<UITextFieldDelegate>

@property (nonatomic, strong) TJBindView *bindView;

@end

@implementation TJBindPhoneController

- (void)createUI {
    _bindView = [[TJBindView alloc] init];
    if (_phone) {
        _bindView.titleLabel.text = @"更换手机号码";
        _bindView.phoneNum.text = [NSString stringWithFormat:@"您当前的手机号码为 +%@", _phone];
    }
    [self.view addSubview:_bindView];
    [_bindView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    _bindView.phoneTF.delegate = self;
    [_bindView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_bindView.nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        _bindView.nextButton.enabled = false;
        _bindView.nextButton.backgroundColor = kBtnDisable;
        return YES;
    }
    
    if (textField.text.length+string.length >= 11) {
        _bindView.nextButton.enabled = true;
        _bindView.nextButton.backgroundColor = kBtnEnable;
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

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)nextButtonAction {
    if (_bindView.phoneTF.text.length < 11) {
        return;
    }
    [DDResponseBaseHttp getWithAction:@"/tojoin/api/binding_phone.php" params:@{@"token":curUser.token, @"mobile":_bindView.phoneTF.text} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
    } failure:^{
        
    }];
    // 换绑
//    TJBindPhoneController *changeVC = [[TJBindPhoneController alloc] init];
//    changeVC.phone = @"1852643243";
//    [self.navigationController pushViewController:changeVC animated:true];
    
    
    // 绑定
//    TJVerifyController *vf = [[TJVerifyController alloc] init];
//    vf.isBind = true;
//    [self.navigationController pushViewController:vf animated:true];
}

- (void)requestData {

}

@end
