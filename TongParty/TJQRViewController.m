//
//  TJQRViewController.m
//  TongParty
//
//  Created by tojoin on 2018/4/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJQRViewController.h"
#import "SGQRCodeGenerateManager.h"

@interface TJQRViewController ()

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TJQRViewController
- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(self.view).offset(23);
        }
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"二维码签到";
    title.font = [UIFont systemFontOfSize:24];
    title.textColor = [UIColor hx_colorWithHexString:@"#2E3041"];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(69);
        } else {
            make.top.mas_equalTo(self.view).offset(89);
        }
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(130, 34));
    }];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:kImage(@"TJSignHeadBackground")];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(154);
        } else {
            make.top.mas_equalTo(self.view).offset(178);
        }
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(116);
    }];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.layerCornerRadius = 25;
    [headImage sd_setImageWithURL:[NSURL URLWithString:[DDUserDefault objectForKey:@"masterHeadImage"]]];
    [self.view addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(128);
        } else {
            make.top.mas_equalTo(self.view).offset(148);
        }
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    
    
    UILabel *content = [[UILabel alloc] init];
    content.text = @"让身边的桌友扫描你的二维码名片\n即可完成签到";
    content.numberOfLines = 0;
    content.textAlignment = NSTextAlignmentCenter;
    content.textColor = [UIColor hx_colorWithHexString:@"#93A8BA"];
    content.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(193);
        } else {
            make.top.mas_equalTo(self.view).offset(213);
        }
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(210);
        make.height.mas_equalTo(38);
    }];
    
    UIButton * nextButton = [[UIButton alloc] init];
    nextButton.enabled = false;
    [self.view addSubview:nextButton];
    [nextButton setTitle:@"签到名片" forState:UIControlStateNormal];
    [nextButton setBackgroundColor:kBtnEnable];
    [nextButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    nextButton.layer.cornerRadius = 15;
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(242);
        } else {
            make.top.mas_equalTo(self.view).offset(262);
        }
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(32);
    }];
    
    UIImageView *square = [[UIImageView alloc] initWithImage:kImage(@"TJQRBackground")];
    [self.view addSubview:square];
    [square mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(313);
        } else {
            make.top.mas_equalTo(self.view).offset(333);
        }
        make.centerX.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(215);
    }];
    
    [self setupGenerateQRCode];
}

// 生成二维码
- (void)setupGenerateQRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.tag = 1928;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(328);
        } else {
            make.top.mas_equalTo(self.view).offset(348);
        }
        make.centerX.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(185);
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [DDResponseBaseHttp getWithAction:kTJTableQRCode params:@{@"token":curUser.token, @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            NSString *str = result.data[@"qr_code"];
            UIImageView *imageView = [self.view viewWithTag:1928];
            imageView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:str logoImageName:@"TJAppIcon" logoScaleToSuperView:0.2];
        }
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
