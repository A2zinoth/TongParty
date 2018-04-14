//
//  TJCreatePwdController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJCreatePwdController.h"
#import "TJCreatePwdView.h"
#import "TJCreatePwdModel.h"

@interface TJCreatePwdController ()

@property (nonatomic, strong) TJCreatePwdView  *createPwdView;
@property (nonatomic, strong) TJCreatePwdModel *createPwdModel;


@end

@implementation TJCreatePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI {
    _createPwdView = [[TJCreatePwdView alloc] init];
    [self.view addSubview:_createPwdView];
    [_createPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [_createPwdView.closeBtn  addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
